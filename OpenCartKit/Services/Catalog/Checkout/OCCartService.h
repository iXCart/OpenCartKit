//
//  OCCartService.h
//  OpenCartKit
//
//  Created by icoco7 on 6/24/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//

#import "OCWebService.h"

@interface OCCartService : OCWebService


/*
 @function: add goods into Cart
 @product_id  product id
 @quantity: quantity
 @method=POST
 @response:
 @return: OCCartService
 @ref: http://127.0.0.1/oc2.0.3/index.php?checkout/cart/add&product_id=42&json
 */
+ (instancetype)add:(NSString*)product_id quantity:(int)quantity_i;

/*
 @function: get products from cart
 @response:
 @return: OCCartService
 @ref: http://127.0.0.1/oc2.0.3/index.php?checkout/cart&json=1
 */
+ (instancetype)getProducts;

/*
 @function: update quantity value of the proudct in the cart
 @params: dictionary which contains value paris of 'key' and 'quantity'
 
 eg: if the proudct key :"YToxOntzOjEwOiJwcm9kdWN0X2lkIjtpOjQxO30="
     the quantity value is 20,
     then it should be as follows:
     NSDictionary* params ;
     NSNumber* value =  20;
     NSString* key = @"YToxOntzOjEwOiJwcm9kdWN0X2lkIjtpOjQxO30";
     [params setValue:value key:key];
     
 @method=POST
 @response:
 @return: OCCartService
 @ref: http://127.0.0.1/oc2.0.3/index.php?checkout/cart/edit&json=1
 */
+ (instancetype)edit:(NSDictionary*)params;

/*
 @function: remove product from cart
 @key : product key in the cart
 @response:
 @return: OCCartService
 @ref: http://127.0.0.1/oc2.0.3/index.php?checkout/cart&json=1
 */
+ (instancetype)remove:(NSString*)key;

@end
