//
//  OCAddressService.m
//  OpenCartKit
//
//  Created by icoco7 on 7/20/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//

#import "OCAddressService.h"
#import "OpenCartKit.h"

@implementation OCAddressService

/*
 @function: get all address as list
 @response:
 @return: OCAddressService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/address&json=1
 */
+ (instancetype)getList{
    OCAddressService* service = [[OCAddressService alloc]init];
    NSString* route = @"account/address";
    service.route = route;
    
    service.parameters = [NSDictionary dictionaryWithObjectsAndKeys:TRUE_ONE,Rest_json,nil ];
    
    return service;
}

#pragma -mark
#pragma mark add Address
/*
 @function: add new Address
 @firstname ;
 @lastname ;
 @company
 @address_1
 @address_2
 @city
 @postcode
 @country_id
 @zone_id
 
 @method=POST
 @response:
 @return: OCAddressService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/address/add
 */
+ (instancetype)add:(NSString*)firstname lastname:(NSString*)lastname  company:(NSString*)company address_1:(NSString*)address_1 address_2:(NSString*)address_2 city:(NSString*)city postcode:(NSString*)postcode country_id:(NSString*)country_id zone_id:(NSString*)zone_id {
    
    OCAddressService *service = [[self alloc]init];
    
    NSDictionary *params = OCNSDictionaryOfParametersBindingsJson(firstname,lastname,company, address_1, address_2,city,postcode,country_id,zone_id);
    
    if ([service isVersion2Plus]) {
        service = [OCAddressService addAddressForVersion2:service params:params];
    }else{
        service = [OCAddressService addAddressForVersion1_5:service params:params];
    }
    return service;
}


//@ for Opencart v1.5 index.php?route=account/address/insert
+ (instancetype)addAddressForVersion1_5:(OCAddressService *)service params:(NSDictionary *)params{
    NSString *route = @"account/address/insert";
    service.route = route;
    service.method = kHTTP_REQUEST_METHOD_POST;
    service.parameters = params;
    return service;
}

//@ for Opencart v2.0 index.php?route=account/address/add
+ (instancetype)addAddressForVersion2:(OCAddressService *)service params:(NSDictionary *)params{
    NSString *route = @"account/address/add";
    service.route = route;
    service.method = kHTTP_REQUEST_METHOD_POST;
    service.parameters = params;
    return service;
}

#pragma -mark
#pragma mark edit Address
/*
 @function: edit Address
 @address_id
 @firstname ;
 @lastname ;
 @company
 @address_1
 @address_2
 @city
 @postcode
 @country_id
 @zone_id
 
 @method=POST
 @response:
 @return: OCAddressService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/address/edit&address_id=9
 */
+ (instancetype)edit:(NSString *)address_id firstname:(NSString*)firstname lastname:(NSString*)lastname  company:(NSString*)company address_1:(NSString*)address_1 address_2:(NSString*)address_2 city:(NSString*)city postcode:(NSString*)postcode country_id:(NSString*)country_id zone_id:(NSString*)zone_id {
    
    OCAddressService *service = [[self alloc]init];
    
    NSDictionary *params = OCNSDictionaryOfParametersBindingsJson(address_id,firstname,lastname,company, address_1, address_2,city,postcode,country_id,zone_id);
    
    if ([service isVersion2Plus]) {
        service = [OCAddressService editAddressForVersion2:service address_id:address_id params:params];
    }else{
        service = [OCAddressService editAddressForVersion1_5:service address_id:address_id params:params];
    }
    return service;
}


//@ for Opencart v1.5 index.php?route=account/address/update&address_id=6
+ (instancetype)editAddressForVersion1_5:(OCAddressService *)service address_id:(NSString*)address_id params:(NSDictionary *)params{
    NSString *route = @"account/address/update";
    route = [NSString stringWithFormat:@"%@&address_id=%@",route,address_id];
    service.route = route;
    service.method = kHTTP_REQUEST_METHOD_POST;
    service.parameters = params;
    return service;
}

//@ for Opencart v2.0 index.php?route=account/address/edit&address_id=9
+ (instancetype)editAddressForVersion2:(OCAddressService *)service address_id:(NSString*)address_id params:(NSDictionary *)params{
    NSString *route = @"account/address/edit";
    route = [NSString stringWithFormat:@"%@&address_id=%@",route,address_id];
    service.route = route;
    service.method = kHTTP_REQUEST_METHOD_POST;
    service.parameters = params;
    return service;
}



#pragma -mark 
#pragma delete address
/*
 @function: delete address
 @response:
 @return: OCAddressService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/address/delete&amp;address_id=12&json=1
 */
+ (instancetype)delete:(NSString*)address_id{
    OCAddressService* service = [[OCAddressService alloc]init];
    NSString* route = @"account/address/delete";
    service.route = route;
   
    service.parameters = OCNSDictionaryOfParametersBindingsJson(address_id);
    return service;
}


#pragma -mark
#pragma country

/*
 @function: get countries
 @response: country list
 @return: OCAddressService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/account/country&query_country=1&json=1
 */
+ (instancetype)countries{
    OCAddressService* service = [[OCAddressService alloc]init];
    NSString* route = @"account/account/country";
    service.route = route;
    NSString* query_country = TRUE_ONE;
    service.parameters = OCNSDictionaryOfParametersBindingsJson(query_country);
    return service;
}

#pragma -mark
#pragma regions
/*
 @function: get regions
 @country_id
 @response: regions list
 @return: OCAddressService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/account/country&country_id=46&json=1
 */
+ (instancetype)regions:(NSString*)country_id{
    OCAddressService* service = [[OCAddressService alloc]init];
    NSString* route = @"account/account/country";
    service.route = route;
    service.parameters = OCNSDictionaryOfParametersBindingsJson(country_id);
    return service;
}
@end
