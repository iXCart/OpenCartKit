//
//  OCTestCase.m
//  OpenCartKit
//
//  Created by icoco7 on 6/21/15.
//  Copyright (c) 2015 icoco. All rights reserved.
//

#import "OCTestCase.h"
#import <OpenCartKit/OCWebServiceConfig.h>

@interface OCTestCase ()
{
    
}
@end
@implementation OCTestCase

@synthesize expection;


- (void)setUp {
    [super setUp];
    
    BOOL isLocalServer = false;
    if ( !isLocalServer) {
        //@step default value define in macro OCWebServiceApiRoot, need set while init
        [OCWebServiceConfig sharedInstance].apiRootUrl = @"http://opencart.i2cart.com";
        //@step default is 2.0+
        //[OCWebServiceConfig sharedInstance].version = @"";
     }
    
    //@step setup the test account
    self.email = @"mykit@test.com";
    self.password = @"1234";
 
    
    self.expection = [self expectationWithDescription:[self description]];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma -mark
#pragma -mark count task
static int _completeTask = 0; static int _totalTask = 0;
- (void)initTask:(int)total{
    _totalTask = total;
    _completeTask = 0;
}
- (BOOL)hasCompleteAllTask{
    return _completeTask >= _totalTask;
}
- (void)completTask:(int)value{
    _completeTask = _completeTask + value;
}


@end
