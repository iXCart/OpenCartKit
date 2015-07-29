//
//  OCUser.h
//  OpenCartKit
//
//  Created by icoco7 on 7/17/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCCustomer : NSObject

@property(nonatomic,strong)NSString* customerId;
@property(nonatomic,strong)NSString* firstName;
@property(nonatomic,strong)NSString* lastName;
@property(nonatomic,strong)NSString* email;

@property(nonatomic,readonly)NSDictionary* info;
@property(nonatomic,readonly)NSDictionary* response;

-(id)initWithResponse:(NSDictionary*)response;

-(BOOL)isValidateUser;

@end
