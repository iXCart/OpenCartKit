//
//  DataModel.m
//  iApp
//
//  Created by icoco7 on 6/11/14.
//  Copyright (c) 2014 i2Cart.com. All rights reserved.
//

#import "DataModel.h"

@interface DataModel (){
    OCCustomer* _activeUser;
}
@property (atomic)int taskCount;
@end

@implementation DataModel

+ (DataModel*)sharedInstance{
    
    static dispatch_once_t onceToken;
    static DataModel *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [DataModel new];
    });
    return sharedInstance;
}

- (OCCustomer*) getActiveUser{
    return _activeUser;
}
#pragma -mark Cart
#pragma -mark list product 
- (void)loadCart{
    
    OCCartService *serivce = [OCCartService getProducts];
    [serivce execute:^(id response) {
        
        NSDictionary* dict = (NSDictionary*)response;
        NSArray* list = (NSArray*)[dict objectForKey:@"products"];
        [self onEventCartUpdated:list];
        
    } failure:^(NSError *error) {
        [CDialogViewManager showMessageView:@"" message:[error localizedDescription] delayAutoHide:-1];
    }];

}
- (void)onEventCartUpdated:(NSArray*)products
{
    //@step
    NSUInteger count = [products count];
  
    
    int iquantity = 0;
    //@step
    for (int i=0; i < count; i++) {
        NSDictionary* item = [products objectAtIndex:i];
        NSNumber* quantity = [item valueForKey:Product_quantity];
        iquantity = iquantity + [quantity intValue];
    }
    
    NSString* countString = [NSString stringWithFormat:@"%d", iquantity];
    [Resource notifyCartUpdate:countString];
}

#pragma mark add proudct to cart
- (void)add2Cart:(NSDictionary*)dict{
   
    //@step
    if (nil != _activeUser && [_activeUser isValidateUser]) {
        [self submit2ServerCart:dict];
    }
    else
    {
        if (nil == _localCart) {
            _localCart =[NSMutableArray array];
        }
        
        [_localCart addObject:dict];
        
        NSString* count = [NSString stringWithFormat:@"%lu", (unsigned long)[_localCart count]];
        [Resource notifyCartUpdate:count];
    }
    
   
    
}

- (NSArray*)getProudctsFromCart{
    return _localCart;
}

- (void)submit2ServerCart:(NSDictionary*)dict
{
    NSString* product_id = [dict valueForKey:Product_product_id];
    NSNumber* quantity = (NSNumber*)[dict valueForKey:Product_quantity];
    if (nil == quantity) {
        quantity = [NSNumber numberWithInt:1];
    }

    OCCartService *serivce = [OCCartService add:product_id quantity:[quantity intValue]];
    [serivce execute:^(id response) {
        NSDictionary* dict = (NSDictionary*)response;
        NSString* status = [dict stringValueForPath:@"status"];
        BOOL success = [@"success" isEqualToString:status];
        if (success)
        {
            NSDictionary* data = [response valueForKey:Rest_data];
            NSString* total = [data valueForKey:Cart_Product_total];
            
            //@step
            [Resource notifyCartUpdate:total];
            
            NSString* msg = @"Success add product to your shopping cart!";
            [CDialogViewManager showMessageView:@"" message:msg delayAutoHide:2];
        }else
        {
            [Resource showRestResponseErrorMessage:response];
        }

    } failure:^(NSError *error) {
        
    }];
  
}

#pragma remove product from cart
- (void)moveProuctFromCart:(NSDictionary*)item
{
    if (nil == _unDeleteProducts) {
        _unDeleteProducts =[NSMutableArray array];
    }
    [_unDeleteProducts addObject:item];
}

- (void)batchRemoveProdcutsFromCart
{
    if (nil == _unDeleteProducts || [_unDeleteProducts count]<=0) {
        return;
    }
    for (NSDictionary* item in _unDeleteProducts) {
        if (item) {
            [self removeProductFromServerCart:item];
            //break;
        }
    }
    
    [_unDeleteProducts removeAllObjects];
}

- (void)resetUnDeleteProducts
{
    if (nil == _unDeleteProducts || [_unDeleteProducts count]<=0) {
        return;
    }
    [_unDeleteProducts removeAllObjects];
}


- (void)removeProductFromServerCart:(NSDictionary*)product{
    NSString* productKey = [product valueForKey:CartProdcut_key];
    OCCartService *serivce = [OCCartService remove:productKey];
    [serivce execute:^(id response) {
        //@step
        [[DataModel sharedInstance] finishOneTask];
        NSDictionary* dict = (NSDictionary*)response;
        NSString* status = [dict stringValueForPath:@"status"];
        if ( [Rest_success isEqualToString:status]){
            
        }else{
            [Resource showRestResponseErrorMessage:response];
        }
        
    } failure:^(NSError *error) {
        //@step
         [[DataModel sharedInstance] finishOneTask];
         [CDialogViewManager showMessageView:[error localizedDescription] message:nil delayAutoHide: 3];
    }];

}

#pragma
- (void)startTaskCount:(int)i
{
    self.taskCount = i;
}

- (void)finishOneTask
{
    @synchronized(self){
        int i = self.taskCount;
        self.taskCount = i -1;
    }
    
    if (0 <= self.taskCount ) {
            [self performSelector:@selector(notifyWhileFinishTask) withObject:nil afterDelay:0.5];
    }
    
}
- (void)notifyWhileFinishTask
{
     [[NSNotificationCenter defaultCenter]postNotificationName:NotifyEventCommpleteUpdateCart object:nil];
}

#pragma mark commitUpdateCart remove and update quanlity
- (void) commitUpdateCart:(NSArray*)list
{
    int iTaskCount = 0;
    
    if (nil != _unDeleteProducts) {
        iTaskCount = [_unDeleteProducts count];
    }
    if (nil != list) {
        iTaskCount = iTaskCount + [list count];
    }
    [self startTaskCount:iTaskCount];
    //@step
    [self batchRemoveProdcutsFromCart];
    [self applyUpdateCart:list];
}

#pragma mark updateCart
- (void)applyUpdateCart:(NSArray*)list
{
    if (nil == list || [list count]<=0) {
        return;
    }
    NSMutableDictionary* updatedProducts = [NSMutableDictionary dictionary];
    for (NSDictionary* item in list) {
        if (item) {
            NSNumber* originalValue = [item valueForKey:Product_quantity_orignal];
            if (nil != originalValue) {
                //@step it was update so then need update db
                NSNumber* value = [item valueForKey:Product_quantity];
                NSString* key = [item valueForKey:CartProdcut_key];
               // NSString* name = [NSString stringWithFormat:@"quantity[%@]", key];
                [updatedProducts setValue:value forKey:key];
            }
         }
    }
    //@step
    if ([updatedProducts count]>0) {
        [self persistentUpdateProdcutQuantity:updatedProducts];
    }
    
}

- (void)persistentUpdateProdcutQuantity:(NSDictionary*)products{
    OCCartService *serivce = [OCCartService edit:products];
    [serivce execute:^(id response) {
        //@step
        [[DataModel sharedInstance] finishOneTask];
        NSDictionary* dict = (NSDictionary*)response;
        NSString* status = [dict stringValueForPath:@"status"];
        if ( [Rest_success isEqualToString:status]){

        }else{
            [Resource showRestResponseErrorMessage:response];
        }
    } failure:^(NSError *error) {
        //@step
        [[DataModel sharedInstance] finishOneTask];
        
        [CDialogViewManager showMessageView:[error localizedDescription] message:nil delayAutoHide: 3];
    }];
    
}

- (void)resetWorkSpace{
    [self loadCart];
}
#pragma Account
- (BOOL)onLoginDone:(id)response{
    
    if ([response isKindOfClass:[OCCustomer class]]) {
        OCCustomer* user = (OCCustomer*)response;
        if (nil !=user && [user isValidateUser]) {
            //@step login succcess
            _activeUser = user;
            //@step
            [self resetWorkSpace];
            return true;
        }
    }
    
    //@step faield login
    [self cleanUpUserAccountInfo];
    //@step
    NSString* mssage = @"Failed login";
    
    if ( nil != response &&[response isKindOfClass:[NSException class]]){
        
        NSException* error = (NSException*)response;
        mssage = [error description];
     }
    
    [CDialogViewManager showMessageView:@"" message:mssage delayAutoHide: -1];
    return false;
}

- (void)login:(NSString*) email password:(NSString*)password popupLogiviewWhileFailed:(BOOL)popupLogiviewWhileFailed{
    
    if ([Lang isEmptyString:email] || [Lang isEmptyString:password]) {
        return;
    }
    __weak __typeof(self)weakSelf = self;
    OCAccountService* serivce = [OCAccountService login:email password:password];
    [serivce execute:^(id response) {
        [weakSelf onLoginDone:response];
    } failure:^(NSError *error) {
        
    }];
   
}

- (void)auotoLogin
{
    NSDictionary* dict =[Resource loadUserAccountInfo];
    if (nil == dict) return;
    NSString* email = [dict valueForKey:@"email"];
    NSString* password = [dict valueForKey:@"password"];
    
    [self login:email password:password popupLogiviewWhileFailed:true];
    
}

- (void)loutOut{
    OCAccountService* serivce = [OCAccountService logout];
    [serivce execute:^(id response) {
        NSDictionary* dict = (NSDictionary*)response;
        NSString* status = [dict stringValueForPath:@"status"];
        if ( StringEqual(Rest_success,   status))
        {
            _activeUser = nil;
            [self cleanUpUserAccountInfo];
            
        }else
        {
            [Resource showRestResponseErrorMessage:response];
        }

    } failure:^(NSError *error) {
        [CDialogViewManager showMessageView:@"" message:[error localizedDescription] delayAutoHide:-1];
    }];
     
}

#pragma mark cache the user account information
- (void)cleanUpUserAccountInfo
{
    NSDictionary* dict =[NSDictionary dictionary];
    [Resource storeUserAccountInfo:dict];
}

- (void)storeUserAccountInfo:(NSString*) email password:(NSString*)password
{
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:email, @"email", password,@"password",nil];
    
    [Resource storeUserAccountInfo:dict];
}
@end
