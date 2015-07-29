//
//  OCWebServiceConfig.h
//  OpenCartKit
//
//  Created by icoco7 on 7/19/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCWebServiceConfig : NSObject
//version = 2.0.3
@property(nonatomic,strong)NSString* version;

//apiRootUrl = http://127.0.0.1/oc2.0.3
@property(nonatomic,strong)NSString* apiRootUrl;

+ (instancetype)sharedInstance;
@end
