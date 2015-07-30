//
//  OCAccountService.m
//  OpencartKit
//
//  Created by icoco7 on 6/21/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//

#import "OCAccountService.h"
#import "OCCustomer.h"
#import "OCDataException.h"
#import "CKStringUtils.h"
#import "NSDictionary+OCHelper.h"

@implementation OCAccountService

/*
 @function:login, if login success then response should be a OCUser instance
 @email: user email
 @password: password
 @method=POST
 @response:
 @return: OCAccuontService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/login
 */
+ (instancetype)login:(NSString*)email password:(NSString*)password{
    OCAccountService* service = [[OCAccountService alloc]init];
    NSString* route = @"account/login";
    service.route = route;
    service.method = kHTTP_REQUEST_METHOD_POST;
    service.parameters = OCNSDictionaryOfParametersBindingsJson(email,password);
    service.successFilter = (id)^( id response){
        id result = response;
        if (![OCAccountService isLoginSuccessResponse:response]){
            NSException* exception =[OCDataException exceptionWithName:OCExceptionDomain reason: @"logging failed" userInfo:response];
            result = exception;
            return result;
        }
        NSDictionary* customer = [response objectForKey:@"customer"];
        OCCustomer *user = [[OCCustomer alloc]initWithResponse:customer];
        if ([user isValidateUser]) {
            result = user;
        }
        return result;
    };

    return service;
}

+ (BOOL)isLoginSuccessResponse:(NSDictionary*)response
{
    if (nil == response || ![response isKindOfClass:[NSDictionary class]]){
        return false;
    }
    NSDictionary* dict = (NSDictionary*)response;
    NSString* error_warning = [dict objectForKey:@"error"];
    if (![CKStringUtils isEmpty:error_warning]) {
        return false;
    }
    NSString* success = [dict stringValueForPath:@"success"];
    if (nil == success || ![success isEqualToString:@""]) {
        return false;
    }
    //@step the success should set and eaual ''
    return true;
    
}

/*
 @function: register
 @firstname ;
 @lastname ;
 @email: user email
 @telephone
 @fax 
 @company
 @address_1
 @address_2
 @city
 @postcode
 @country_id
 @zone_id
 @password: password
 @confirm:
 @agree = 0;
 @newsletter = 0;
 
 @method=POST
 @response:
 @return: OCAccuontService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/register
 */
+ (instancetype)register:(NSString*)firstname lastname:(NSString*)lastname email:(NSString*)email password:(NSString*)password confirm:(NSString*)confirm telephone:(NSString*)telephone fax:(NSString*)fax  company:(NSString*)company address_1:(NSString*)address_1 address_2:(NSString*)address_2 city:(NSString*)city postcode:(NSString*)postcode country_id:(NSString*)country_id zone_id:(NSString*)zone_id agree:(BOOL)agree_b newsletter:(BOOL)newsletter_b {
    
    OCAccountService* service = [[OCAccountService alloc]init];
    NSString* route = @"account/register";
    
    service.method = kHTTP_REQUEST_METHOD_POST;
    service.route = route;
    
    NSString* agree = agree_b ? @"1" : @"0";
    NSString* newsletter = newsletter_b ? @"1" : @"0";
    
    NSDictionary* dict = OCNSDictionaryOfParametersBindingsJson(firstname,lastname,email,password,confirm,
                         telephone,fax,company, address_1, address_2,city,postcode,country_id,zone_id,agree,newsletter
                        );
    
     
    service.parameters = dict;
    
    service.successFilter = (id)^( id response){
        if (nil == response || ![response isKindOfClass:[NSDictionary class]]){
            return response;
        }
        
        id result = response;
        NSDictionary* error = [(NSDictionary*)response objectForKey:@"error"];
        if (error){
            NSException* exception =[OCDataException exceptionWithName:OCExceptionDomain reason:[error description] userInfo:error];
            result = exception;
        }
        return result;
    };
    
    return service;
}

/*
 @function: forgotten, reset password
 @email: user email
 @password: password
 @method=POST
 @response:
 @return: OCAccuontService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/forgotten
 */
+ (instancetype)forgotten:(NSString *)email{
    OCAccountService* service = [[OCAccountService alloc]init];
    NSString* route = @"account/forgotten";
    service.route = route;
    service.method = kHTTP_REQUEST_METHOD_POST;
    service.parameters = OCNSDictionaryOfParametersBindingsJson(email);
    return service;
}


/*
 @function: edit
 @firstname ;
 @lastname ;
 @email: user email
 @telephone
 @fax

 @method=POST
 @response:
 @return: OCAccuontService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/edit
 */
+ (instancetype)edit:(NSString*)firstname lastname:(NSString*)lastname email:(NSString*)email  telephone:(NSString*)telephone fax:(NSString*)fax  {
    
    OCAccountService* service = [[OCAccountService alloc]init];
    NSString* route = @"account/edit";
    
    service.method = kHTTP_REQUEST_METHOD_POST;
    service.route = route;
    
    NSDictionary* dict = OCNSDictionaryOfParametersBindingsJson(firstname,lastname,email, telephone,fax);
    
    
    service.parameters = dict;
    
    return service;
}

/*
 @function: logout
 @response:
 @return: OCAccuontService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/logout&json=1
 */
+ (instancetype)logout{
    OCAccountService* service = [[OCAccountService alloc]init];
    NSString* route = @"account/logout";
    service.route = route;
    service.parameters = OCNSDictionaryOfParametersBindingsJson(nil);
    return service;
}


#pragma -mark
#pragma -mark hisotry order
/*
 @function: order
 @page: page index
 @response:
 @return: OCAccuontService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/order&json=1
 */
+ (instancetype)order:(int)page_i{
    OCAccountService* service = [[OCAccountService alloc]init];
    NSString* route = @"account/order";
    service.route = route;
    NSNumber* page = [NSNumber numberWithInt:page_i];
    NSDictionary* dict = OCNSDictionaryOfParametersBindingsJson(page);
    service.parameters = dict;
    return service;
}




@end
