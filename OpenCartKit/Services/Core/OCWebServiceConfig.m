//
//  OCWebServiceConfig.m
//  OpenCartKit
//
//  Created by icoco7 on 7/19/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//

#import "OCWebServiceConfig.h"

#define OCWebServiceApiRoot @"http://127.0.0.1/oc2.0.3"
#define OCWebServiceApiVersion @"2.0.3"


@implementation OCWebServiceConfig

+ (instancetype)sharedInstance {
    static OCWebServiceConfig *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[self alloc] init];
        
        NSLog(@"create:%@",_instance);
    });
    
    return _instance;
}

-(id)init {
    if (self = [super init])  {
        //default
        self.version = OCWebServiceApiVersion;
        self.apiRootUrl = OCWebServiceApiRoot;
    }
    return self;
}


@end
