//
//  OCProductService.h
//  OpenCartKit
//
//  Created by icoco7 on 6/22/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OCWebService.h"

@interface OCProductService : OCWebService

/*
 * @function search
 * @keywords
 * @page
 *
 * @ref: http://127.0.0.1/oc2.0.3/index.php?route=product/search&search=iphone&page=1&json
 */
+ (instancetype)search:(NSString*)keywords page:(NSUInteger)page_i;

/*
 * @function getProudctsByCategoryId
 *
 * @categoryId  category id
 *
 * @ref: http://127.0.0.1/oc2.0.3/index.php?route=product/category&path=20&json
 */
+ (instancetype)getProudctsByCategoryId:(NSString*)categoryId;

/*
 * @function getProudct
 *
 * @productId  product id
 *
 * @ref: http://127.0.0.1/oc2.0.3/index.php?route=product/product&product_id=42&json
 */
+ (instancetype)getProudct:(NSString*)productId;

@end
