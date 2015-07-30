//
//  OCCheckoutService.h
//  OpenCartKit
//
//  Created by icoco7 on 6/24/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//

#import "OCWebService.h"
#import "CKStringUtils.h"
#import "NSDictionary+OCHelper.h"
#import "OCWebServiceConstant.h"

@interface OCCheckoutService : OCWebService


/*
 @function: get payment address
 @response:
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=checkout/payment_address&json=1
 */
+ (instancetype)paymentAddress;

/*
 @function: add new paymentaAddress
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
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=checkout/payment_address&json=1
 */
+ (instancetype)addPaymentAddress:(NSString*)firstname lastname:(NSString*)lastname  company:(NSString*)company address_1:(NSString*)address_1 address_2:(NSString*)address_2 city:(NSString*)city postcode:(NSString*)postcode country_id:(NSString*)country_id zone_id:(NSString*)zone_id;

/*
 @function: set payment address
 @address_id
 @response:
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=checkout/payment_address/save&json=1
 */
+ (instancetype)setPaymentAddress:(NSString*)address_id;


#pragma -mark
#pragma -mark shipping address
/*
 @function: get shipping address
 @response:
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=checkout/shipping_address&json=1
 */
+ (instancetype)shippingAddress;

/*
 @function: add new shipping Address
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
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=checkout/shipping_address&json=1
 */
+ (instancetype)addShippingAddress:(NSString*)firstname lastname:(NSString*)lastname  company:(NSString*)company address_1:(NSString*)address_1 address_2:(NSString*)address_2 city:(NSString*)city postcode:(NSString*)postcode country_id:(NSString*)country_id zone_id:(NSString*)zone_id ;

/*
 @function: set shipping address
 @address_id
 @response:
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=checkout/shipping_address/save&json=1
 */
+ (instancetype)setShippingAddress:(NSString*)address_id;

#pragma -mark
#pragma -mark shipping method
/*
 @function: get shipping method
 @response:
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=checkout/shipping_method&json=1
 */
+ (instancetype)shippingMethod;

/*
 @function: set shipping method
 @shipping_method
 @comment
 @response:
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=checkout/shipping_method/save&json=1
 */
+ (instancetype)setShippingMethod:(NSString*)shipping_method comment:(NSString*)comment;

#pragma -mark
#pragma -mark payment method
/*
 @function: get payment method
 @response:
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=checkout/payment_method&json=1
 */
+ (instancetype)paymentMethod;

/*
 @function: set payment method
 @payment_method
 @comment
 @agree
 
 @response:
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=checkout/payment_method/save&json=1
 */
+ (instancetype)setPaymentMethod:(NSString*)payment_method comment:(NSString*)comment agree:(BOOL)agree;

/*
 @function: confirm
 @response:
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=checkout/confirm&json=1
 */
+ (instancetype)confirm;

/*
 @function: payment confirm
 @response:
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=payment/cod/confirm&json=1
 */
+ (instancetype)paymentConfirm;

/*
 @function: checkout success
 @response:
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=checkout/success&json=1
 */
+ (instancetype)success;

@end
