//
//  OCUser.m
//  OpenCartKit
//
//  Created by icoco7 on 7/17/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//

#import "OCCustomer.h"
#import "CKStringUtils.h"
#import "NSDictionary+OCHelper.h"


@implementation OCCustomer
@synthesize response = _response;

-(id)initWithResponse:(NSDictionary*)response{
    self = [super init];
    _response = response;
    
    [self initData:_response];
    return self;
}

-(void)initData:(NSDictionary *)response{
    if (nil == response || ![response isKindOfClass:[NSDictionary class]]){
        return ;
    }
    NSString* customer_id = [response stringValueForPath:@"info.customer_id"];
    self.customerId = customer_id;
    NSString* firstName = [response stringValueForPath:@"info.firstname"];
    self.firstName = firstName;
    NSString* lastname = [response stringValueForPath:@"info.lastname"];
    self.lastName = lastname;
    
}

-(BOOL)isValidateCustomerResponse:(NSDictionary*)response{
    if (nil == response || ![response isKindOfClass:[NSDictionary class]]){
        return false;
    }
    NSDictionary* dict = (NSDictionary*)response;
    _info = dict;
    
    NSString* customer_id = [dict stringValueForPath:@"info.customer_id"];
    if ([CKStringUtils isEmpty:customer_id]) {
        return false;
    }
    NSString* firstname = [dict stringValueForPath:@"info.firstname"];
    if ([CKStringUtils isEmpty:firstname]) {
       // return false;
    }
    //...
    return true;
    
}

- (BOOL)isValidateUser{
    return [self isValidateCustomerResponse:_response];
}



@end
