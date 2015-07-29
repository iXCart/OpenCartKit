//
//  OCCheckoutService.m
//  OpenCartKit
//
//  Created by icoco7 on 6/24/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//

#import "OCCheckoutService.h"

@implementation OCCheckoutService

#pragma -mark
#pragma -mark payment address
/*
 @function: get payment address
 @response:
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=checkout/payment_address&json=1
 */
+ (instancetype)paymentAddress{
    OCCheckoutService* service = [[OCCheckoutService alloc]init];
    NSString* route = @"checkout/payment_address";
    service.route = route;
    NSString* json = @"1";
    service.parameters = OCNSDictionaryOfParametersBindingsJson(json);
    return service;
}

/*
 @function: add new payment address
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
+ (instancetype)addPaymentAddress:(NSString*)firstname lastname:(NSString*)lastname  company:(NSString*)company address_1:(NSString*)address_1 address_2:(NSString*)address_2 city:(NSString*)city postcode:(NSString*)postcode country_id:(NSString*)country_id zone_id:(NSString*)zone_id {
    
    OCCheckoutService *service = [[OCCheckoutService alloc]init];
   
    NSDictionary *params = OCNSDictionaryOfParametersBindingsJson(firstname,lastname,company, address_1, address_2,city,postcode,country_id,zone_id);
    
    if ([service isVersion2Plus]) {
        service = [OCCheckoutService addPaymentAddressForVersion2:service params:params];
    }else{
        service = [OCCheckoutService addPaymentAddressForVersion1_5:service params:params];
    }
    return service;
}

//@ for Opencart v1.5 index.php?route=checkout/payment_address/validate:
+ (OCCheckoutService *)addPaymentAddressForVersion1_5:(OCCheckoutService *)service params:(NSDictionary *)params{
    NSString *route = @"checkout/payment_address/validate";
    service.route = route;
    service.method = kHTTP_REQUEST_METHOD_POST;
    service.parameters = params;
    return service;
}

//@ for Opencart v2.0 index.php?route=checkout/payment_address/save
+ (OCCheckoutService *)addPaymentAddressForVersion2:(OCCheckoutService *)service params:(NSDictionary *)params{
    NSString *route = @"checkout/payment_address/save";
    service.route = route;
    service.method = kHTTP_REQUEST_METHOD_POST;
    service.parameters = params;
    return service;
}

/*
 @function: set payment address
 @address_id
 @response:
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=checkout/payment_address/save&json=1
 */
+ (instancetype)setPaymentAddress:(NSString*)address_id{
    OCCheckoutService* service = [[OCCheckoutService alloc]init];
    NSString* route = @"checkout/payment_address/save";
    service.route = route;
   
    NSString* payment_address = @"existing";
   
    service.parameters = OCNSDictionaryOfParametersBindingsJson(payment_address,address_id);
    service.method = kHTTP_REQUEST_METHOD_POST;
    
    return service;
}

#pragma -mark
#pragma -mark shipping address
/*
 @function: get shipping address
 @response:
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=checkout/shipping_address&json=1
 */
+ (instancetype)shippingAddress{
    OCCheckoutService* service = [[OCCheckoutService alloc]init];
    NSString* route = @"checkout/shipping_address";
    service.route = route;
    NSString* json = @"1";
    service.parameters = OCNSDictionaryOfParametersBindingsJson(json);
    return service;
}

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
+ (instancetype)addShippingAddress:(NSString*)firstname lastname:(NSString*)lastname  company:(NSString*)company address_1:(NSString*)address_1 address_2:(NSString*)address_2 city:(NSString*)city postcode:(NSString*)postcode country_id:(NSString*)country_id zone_id:(NSString*)zone_id {
    
    OCCheckoutService *service = [[OCCheckoutService alloc]init];
    
    NSDictionary *params = OCNSDictionaryOfParametersBindingsJson(firstname,lastname,company, address_1, address_2,city,postcode,country_id,zone_id);
    
    if ([service isVersion2Plus]) {
        service = [OCCheckoutService addShippingAddressForVersion2:service params:params];
    }else{
        service = [OCCheckoutService addShippingAddressForVersion1_5:service params:params];
    }
    return service;
}

//@ for Opencart v1.5 index.php?route=checkout/shipping_address/validate:
+ (OCCheckoutService *)addShippingAddressForVersion1_5:(OCCheckoutService *)service params:(NSDictionary *)params{
    NSString *route = @"checkout/shipping_address/validate";
    service.route = route;
    service.method = kHTTP_REQUEST_METHOD_POST;
    service.parameters = params;
    return service;
}

//@ for Opencart v2.0 index.php?route=checkout/shipping_address/save
+ (OCCheckoutService *)addShippingAddressForVersion2:(OCCheckoutService *)service params:(NSDictionary *)params{
    NSString *route = @"checkout/shipping_address/save";
    service.route = route;
    service.method = kHTTP_REQUEST_METHOD_POST;
    service.parameters = params;
    return service;
}

/*
 @function: set shipping address
 @address_id
 @response:
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=checkout/shipping_address/save&json=1
 */
+ (instancetype)setShippingAddress:(NSString*)address_id{
    OCCheckoutService* service = [[OCCheckoutService alloc]init];
    NSString* route = @"checkout/shipping_address/save";
    service.route = route;
    NSString* shipping_address = @"existing";
    service.parameters = OCNSDictionaryOfParametersBindingsJson(shipping_address,address_id);
    service.method = kHTTP_REQUEST_METHOD_POST;
    return service;
}

#pragma -mark
#pragma -mark shipping method
/*
 @function: get shipping method
 @response:
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=checkout/shipping_method&json=1
 */
+ (instancetype)shippingMethod{
    OCCheckoutService* service = [[OCCheckoutService alloc]init];
    NSString* route = @"checkout/shipping_method";
    //service.route = route;
    service.parameters = OCNSDictionaryOfParametersBindingsJson(route);
    return service;
}

/*
 @function: set shipping method
 @shipping_method
 @comment
 @response:
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=checkout/shipping_method/save&json=1
 */
+ (instancetype)setShippingMethod:(NSString*)shipping_method comment:(NSString*)comment{
    OCCheckoutService* service = [[OCCheckoutService alloc]init];
    NSString* route = @"checkout/shipping_method/save";
    service.route = route;
    service.parameters = OCNSDictionaryOfParametersBindingsJson(shipping_method,comment);
    service.method = kHTTP_REQUEST_METHOD_POST;
    return service;
}

#pragma -mark
#pragma -mark payment method
/*
 @function: get payment method
 @response:
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=checkout/payment_method&json=1
 */
+ (instancetype)paymentMethod{
    OCCheckoutService* service = [[OCCheckoutService alloc]init];
    NSString* route = @"checkout/payment_method";
    //service.route = route;
    service.parameters = OCNSDictionaryOfParametersBindingsJson(route);
    return service;
}

/*
 @function: set payment method
 @payment_method
 @comment
 @agree
 
 @response:
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=checkout/payment_method/save&json=1
 */
+ (instancetype)setPaymentMethod:(NSString*)payment_method comment:(NSString*)comment agree:(BOOL)agree_b{
    OCCheckoutService* service = [[OCCheckoutService alloc]init];
    NSString* route = @"checkout/payment_method/save";
    service.route = route;
    NSString* agree = TRUE_ONE;
    NSDictionary* params = agree_b ?  OCNSDictionaryOfParametersBindingsJson(payment_method,comment,agree) :  OCNSDictionaryOfParametersBindingsJson(payment_method,comment);
    service.parameters =params;
    service.method = kHTTP_REQUEST_METHOD_POST;
    return service;
}

/*
 @function: confirm
 @response:
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=checkout/confirm&json=1
 */
+ (instancetype)confirm{
    OCCheckoutService* service = [[OCCheckoutService alloc]init];
    NSString* route = @"checkout/confirm";
    service.route = route;
    service.parameters = OCNSDictionaryOfParametersBindingsJson(nil);
    service.method = kHTTP_REQUEST_METHOD_POST;
    return service;
}


/*
 @function: payment confirm
 @response:
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=payment/cod/confirm&json=1
 */
+ (instancetype)paymentConfirm{
    OCCheckoutService* service = [[OCCheckoutService alloc]init];
    NSString* route = @"payment/cod/confirm";
    service.route = route;
    service.parameters = OCNSDictionaryOfParametersBindingsJson(nil);
    service.method = kHTTP_REQUEST_METHOD_POST;
    return service;
}


/*
 @function: checkout success
 @response:
 @return: OCCheckoutService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=checkout/success&json=1
 */
+ (instancetype)success{
    OCCheckoutService* service = [[OCCheckoutService alloc]init];
    NSString* route = @"checkout/success";
    service.route = route;
    service.parameters = OCNSDictionaryOfParametersBindingsJson(nil);
    return service;
}

@end
