//
//  TestOCCategoryService.m
//  OpenCartKit
//
//  Created by icoco7 on 6/21/15.
//  Copyright (c) 2015 icoco. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "OCTestCase.h"
#import "OCCategoryService.h"


@interface TestOCCategoryService : OCTestCase

@end

@implementation TestOCCategoryService

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetCategories {
    OCCategoryService* serivce = [OCCategoryService getCategories:nil];
    [serivce execute:^(id response) {
        
    } failure:^(NSError *error) {
        
    }];
    
    serivce = [OCCategoryService getCategories:@"20"];
    [serivce execute:^(id response) {
          [self.expection fulfill ];
    } failure:^(NSError *error) {
          [self.expection fulfill ];
    }];

    //@step
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



@end
