//
//  OCWishListService.m
//  OpenCartKit
//
//  Created by icoco7 on 7/25/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//

#import "OCWishListService.h"
#import "OCWebServiceConstant.h"

@implementation OCWishListService

/*
 @function: wishlist
 @response:
 @return: OCAccuontService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/wishlist&json=1
 */
+ (instancetype)wishlist{
    OCWishListService* service = [[OCWishListService alloc]init];
    NSString* route = @"account/wishlist";
    service.route = route;
    NSString* json = TRUE_ONE;
    NSDictionary* dict = OCNSDictionaryOfParametersBindingsJson(json);
    service.parameters = dict;
    return service;
}

/*
 @function: add product to wish list
 @product_id
 @method=POST
 @response:
 @return: OCAccuontService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/wishlist/add&json=1
 */
+ (instancetype)add:(NSString*)product_id{
    OCWishListService* service = [[OCWishListService alloc]init];
    NSString* route = @"account/wishlist/add";
    service.route = route;
    service.method = kHTTP_REQUEST_METHOD_POST;
    NSDictionary* dict = OCNSDictionaryOfParametersBindingsJson(product_id);
    service.parameters = dict;
    return service;
}

/*
 @function: remove product from wish list
 @product_id
 @response:
 @return: OCAccuontService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/wishlist&remove=42&json=1
 */
+ (instancetype)remove:(NSString*)product_id{
    OCWishListService* service = [[OCWishListService alloc]init];
    NSString* route = @"account/wishlist";
    service.route = route;
    NSString* remove = product_id;
    NSDictionary* dict = OCNSDictionaryOfParametersBindingsJson(remove);
    service.parameters = dict;
    return service;
}

@end
