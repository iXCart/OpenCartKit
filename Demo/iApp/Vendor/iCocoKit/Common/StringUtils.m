//
//  StringUtils.m
//  iApp
//
//  Created by icoco7 on 8/2/15.
//  Copyright (c) 2015 i2Cart.com All rights reserved.
//

#import "StringUtils.h"

@implementation StringUtils

+ (NSString *)decodeHTMLString:(NSString *)value{
    if (value) {
        value =[value stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    }
    return value;
 
}

@end
