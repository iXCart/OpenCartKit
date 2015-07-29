//
//  NSDictionary+OCHelper.m
//  icoco
//
//  Created by icoco7 on 6/7/15.
//  Copyright (c) 2015 icoco. All rights reserved.
//

#import "NSDictionary+OCHelper.h"
#import "NSDictionary+STHelper.h"
@implementation NSDictionary (OCHelper)

- (NSString*) stringValueForPath:(NSString*)path{
    
    return [self st_stringForPath:path];
}

- (NSString*) stringValueForPath:(NSString*)path defaultValue:(NSString*)defaultValue{
    
    return [self st_stringForPath:path defaultValue:defaultValue];
}

- (NSArray *)arrayValueForPath:(NSString *)path{
    return [self st_arrayForPath:path];
}

- (NSArray *) arrayValueForPath:(NSString *)path defaultValue:(NSArray *)defaultValue{
    return [self st_arrayForPath:path defaultValue:defaultValue];
}

- (NSObject *) objectValueForPath:(NSString *)path{
    return [self st_objectForPath:path];
}

- (NSObject *) objectValueForPath:(NSString *)path defaultValue:(NSObject *)defaultValue{
    return  [self st_objectForPath:path defaultValue:defaultValue];
}


@end
