//
//  OCTestCase.h
//  OpenCartKit
//
//  Created by icoco7 on 6/21/15.
//  Copyright (c) 2015 icoco. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OpenCartKit.h"

@interface OCTestCase : XCTestCase

@property(nonatomic,strong)NSString* email;
@property(nonatomic,strong)NSString* password;

@property(nonatomic)XCTestExpectation*  expection;

#pragma -mark
#pragma -mark count task
- (void)initTask:(int)total;

- (BOOL)hasCompleteAllTask;

- (void)completTask:(int)value;

@end
