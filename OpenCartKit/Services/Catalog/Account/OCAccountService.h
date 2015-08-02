//
//  OCAccountService.h
//  OpencartKit
//
//  Created by icoco7 on 6/21/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//

#import "OCWebService.h"

@interface OCAccountService : OCWebService

/*
 @function:login
 @email: user email
 @password: password
 @method=POST
 @response:
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/login
 */
+ (instancetype)login:(NSString*)email password:(NSString*)password;

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
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/register
 */
+ (instancetype)register:(NSString*)firstname lastname:(NSString*)lastname email:(NSString*)email password:(NSString*)password confirm:(NSString*)confirm telephone:(NSString*)telephone fax:(NSString*)fax  company:(NSString*)company address_1:(NSString*)address_1 address_2:(NSString*)address_2 city:(NSString*)city postcode:(NSString*)postcode country_id:(NSString*)country_id zone_id:(NSString*)zone_id agree:(BOOL)agree_b newsletter:(BOOL)newsletter_b ;

/*
 @function: forgotten, reset password
 @email: user email
 @password: password
 @method=POST
 @response:
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/forgotten
 */
+ (instancetype)forgotten:(NSString *)email;

/*
 @function: get account info for edit
 @response:
 @return: OCAccuontService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/edit&json=1
 */
+ (instancetype)getEditInfo;

/*
 @function: edit
 @firstname ;
 @lastname ;
 @email: user email
 @telephone
 @fax
 
 @method=POST
 @response:
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/register
 */
+ (instancetype)edit:(NSString*)firstname lastname:(NSString*)lastname email:(NSString*)email  telephone:(NSString*)telephone fax:(NSString*)fax;

/*
 @function: logout
 @response:
 @return: OCAccuontService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/logout&json=1
 */
+ (instancetype)logout;

#pragma -mark
#pragma -mark  order hisotry
/*
 @function: order
 @page: page index
 @response:
 @return: OCAccuontService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/order
 */
+ (instancetype)order:(int)page_i;

@end
