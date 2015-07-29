//
//  OCWishListService.h
//  OpenCartKit
//
//  Created by icoco7 on 7/25/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//

#import "OCWebService.h"

@interface OCWishListService : OCWebService


/*
 @function: wishlist
 @response:
 @return: OCAccuontService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/wishlist&json=1
 */
+ (instancetype)wishlist;

/*
 @function: add product to wish list
 @product_id
 @method=POST
 @response:
 @return: OCAccuontService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/wishlist/add&json=1
 */
+ (instancetype)add:(NSString*)product_id;

/*
 @function: remove product from wish list
 @product_id
 @response:
 @return: OCAccuontService
 @ref: http://127.0.0.1/oc2.0.3/index.php?route=account/wishlist&remove=42&json=1
 */
+ (instancetype)remove:(NSString*)product_id;
@end
