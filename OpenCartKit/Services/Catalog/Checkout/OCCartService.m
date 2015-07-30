//
//  OCCartService.m
//  OpenCartKit
//
//  Created by icoco7 on 6/24/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//

#import "OCCartService.h"
#import "CKStringUtils.h"
#import "NSDictionary+OCHelper.h"
#import "OCWebServiceConstant.h"

@implementation OCCartService


/*
 @function: add goods into Cart
 @product_id  product id
 @quantity: quantity
 @method=POST
 @response:
 @return: OCCartService
 @ref: http://127.0.0.1/oc2.0.3/index.php?checkout/cart/add&product_id=42&json=1
*/
+ (instancetype)add:(NSString*)product_id quantity:(int)quantity_i{
    
    OCCartService* service = [[OCCartService alloc]init];
    
    NSString* route = @"checkout/cart/add";
    NSNumber* quantity = [NSNumber numberWithInt:quantity_i];
    
    service.route = route;
    service.method = kHTTP_REQUEST_METHOD_POST;
    service.parameters = OCNSDictionaryOfParametersBindingsJson(product_id,quantity);
    
    return service;
}


/*
 @function: get products from cart
 @response:
 @return: OCCartService
 @ref: http://127.0.0.1/oc2.0.3/index.php?checkout/cart&json=1
 */
+ (instancetype)getProducts{
    
    OCCartService* service = [[OCCartService alloc]init];
    
    NSString* route = @"checkout/cart";
    service.route = route;
    NSString* json = @"1";
    service.parameters = OCNSDictionaryOfParametersBindingsJson(json);
    
    return service;
}

/*
 @function: update quantity value of the proudct in the cart
 @params: dictionary which contains value paris of 'key' and 'quantity'
 
        eg: if the proudct key :"YToxOntzOjEwOiJwcm9kdWN0X2lkIjtpOjQxO30="
               the quantity value is 20,
        then it should be as follows:
         NSDictionary* params ;
         NSNumber* value =  20;
         NSString* key = @"YToxOntzOjEwOiJwcm9kdWN0X2lkIjtpOjQxO30";
         [params setValue:value key];
 
 @method=POST
 @response:
 @return: OCCartService
 @ref: http://127.0.0.1/oc2.0.3/index.php?checkout/cart/edit&json=1
 */
+ (instancetype)edit:(NSDictionary*)params{
    OCCartService* service = [[OCCartService alloc]init];
    NSString* route = @"checkout/cart/edit";
    service.route = route;
    
    NSMutableDictionary* dict = [OCCartService formatUpdateProudctParams:params];
    [dict setObject:TRUE_ONE forKey:Rest_json];
    service.parameters =dict;
    service.method = kHTTP_REQUEST_METHOD_POST;
    return service;
}

+ (NSMutableDictionary*)formatUpdateProudctParams:(NSDictionary*)params{
    NSMutableDictionary* result = [NSMutableDictionary dictionary];
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString* name = [NSString stringWithFormat:@"quantity[%@]", key];
        [result setValue:obj  forKey:name];
    }];
    return result;
}
/*
 @function: remove product from cart
 
 @response:
 @return: OCCartService
 @ref: http://127.0.0.1/oc2.0.3/index.php?checkout/cart&remove=29&json=1
 */
+ (instancetype)remove:(NSString*)key{
    OCCartService* service = [[OCCartService alloc]init];
    if ([service isVersion2Plus]) {
        service = [OCCartService removeForVersion2:service key:key];
    }else{
        service = [OCCartService removeForVersion1_5:service key:key];
    }
    
    return service;
}

//@ for Opencart v1.5 index.php?route=checkout/cart&remove=29:
+ (OCCartService *)removeForVersion1_5:(OCCartService *)service key:(NSString*)key{
    NSString* route = @"checkout/cart";
    service.route = route;
    NSString* remove = key;
    service.parameters = OCNSDictionaryOfParametersBindingsJson(remove);
    return service;
}

//@ for Opencart v2.0 index.php?route=checkout/cart/remove
+ (OCCartService *)removeForVersion2:(OCCartService *)service key:(NSString*)key{
    NSString* route = @"checkout/cart/remove";
    service.route = route;
    service.method = kHTTP_REQUEST_METHOD_POST;
    service.parameters = OCNSDictionaryOfParametersBindingsJson(key);
    return service;
}




@end
