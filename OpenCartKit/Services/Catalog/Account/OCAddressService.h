//
//  OCAddressService.h
//  OpenCartKit
//
//  Created by icoco7 on 7/20/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//

#import "OCWebService.h"

@interface OCAddressService : OCWebService

/*
 @function: get all address as list
 @response:
 @return: OCAddressService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/address&json=1
 */
+ (instancetype)getList;

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
+ (instancetype)add:(NSString*)firstname lastname:(NSString*)lastname  company:(NSString*)company address_1:(NSString*)address_1 address_2:(NSString*)address_2 city:(NSString*)city postcode:(NSString*)postcode country_id:(NSString*)country_id zone_id:(NSString*)zone_id ;

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
+ (instancetype)edit:(NSString *)address_id firstname:(NSString*)firstname lastname:(NSString*)lastname  company:(NSString*)company address_1:(NSString*)address_1 address_2:(NSString*)address_2 city:(NSString*)city postcode:(NSString*)postcode country_id:(NSString*)country_id zone_id:(NSString*)zone_id;

/*
 @function: delete address
 @response:
 @return: OCAddressService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/address/delete&amp;address_id=12
 */
+ (instancetype)delete:(NSString*)address_id;


#pragma -mark
#pragma country
/*
 @function: get countries
 @response: country list
 @return: OCAddressService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/account/country&query_country=1&json=1
 */
+ (instancetype)countries;

#pragma -mark
#pragma regions
/*
 @function: get regions
 @country_id
 @response: regions list
 @return: OCAddressService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/account/country&country_id=46&json=1
 */
+ (instancetype)regions:(NSString*)country_id;

@end
