//
//  NSDictionary+OCHelper.h
//  icoco
//
//  Created by icoco7 on 6/7/15.
//  Copyright (c) 2015 icoco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (OCHelper)

- (NSString *) stringValueForPath:(NSString *)path;

- (NSString *) stringValueForPath:(NSString *)path defaultValue:(NSString *)defaultValue;

- (NSArray *) arrayValueForPath:(NSString *)path;

- (NSArray *) arrayValueForPath:(NSString *)path defaultValue:(NSArray *)defaultValue;

- (NSObject *) objectValueForPath:(NSString *)path;

- (NSObject *) objectValueForPath:(NSString *)path defaultValue:(NSObject *)defaultValue;

@end
