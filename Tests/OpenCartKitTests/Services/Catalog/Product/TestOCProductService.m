//
//  TestOCProductService.m
//  OpenCartKit
//
//  Created by icoco7 on 6/22/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "OCTestCase.h"
#import "OpenCartKit.h"

@interface TestOCProductService : OCTestCase

@end

@implementation TestOCProductService

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test1_search {
    NSString* keywords = @"iphone";
    OCProductService* serivce = [OCProductService search:keywords page:1];
    [serivce execute:^(id response) {
        NSArray* list = (NSArray*)[(NSDictionary*)response objectForKey:@"products"];
        XCTAssertTrue([list count]>=1);
        [self.expection fulfill];
    } failure:^(NSError *error) {
        [self.expection fulfill];
    }];
    
    //@step
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)test2_getAllProducts {
    OCCategoryService* serivce = [OCCategoryService getCategories:nil];
    [serivce execute:^(id response) {
     
        NSArray* list = (NSArray*)response;
        __block int total = (int)[list count];
        [list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary* item = (NSDictionary*)obj;
            NSArray* children = [item objectForKey:@"children"];
            total = total + (int)[children count];
        }];
        //@TODO need query all categories
        [self initTask:total];
        //@step
        [list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary* item = (NSDictionary*)obj;
            NSString* category_id = [item stringValueForPath:@"category_id"];
            [self getProudctsByCategoryId:category_id];
            //@step
            NSArray* children = [item objectForKey:@"children"];
            [children enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSDictionary* item = (NSDictionary*)obj;
                NSString* category_id = [item stringValueForPath:@"category_id"];
                [self getProudctsByCategoryId:category_id];
            }];
        }];
          
        if ([self hasCompleteAllTask]) {
            [self.expection fulfill ];
        }
        
    } failure:^(NSError *error) {
        
          [self.expection fulfill ];
    }];
    
   
        //@step
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



- (void)getProudctsByCategoryId:(NSString*)categoryId {
    NSLog(@"getProudctsByCategoryId->categoryId:[%@]",categoryId);
    // XCTestExpectation* exp = [self expectationWithDescription:[self description]];
    
    categoryId = nil == categoryId ? @"34":categoryId;
    
    OCProductService* serivce = [OCProductService getProudctsByCategoryId:categoryId];
    [serivce execute:^(id response) {
        NSLog(@" success response:%@", response);
        [self completTask:1];
        if ([self hasCompleteAllTask]) {
            [self.expection fulfill ];
        }
    } failure:^(NSError *error) {
        NSLog(@" error:%@", error);
         [self completTask:1];
        if ([self hasCompleteAllTask]) {
            [self.expection fulfill ];
        }
    }];
 
}




- (void)test3_getProudct {
    NSString*  productId = nil;
    NSLog(@"testGetProudct->productId:[%@]",productId);
  //  XCTestExpectation* exp = [self expectationWithDescription:[self description]];
    
    productId = nil == productId ? @"34":productId;
    
    OCProductService* serivce = [OCProductService getProudct:productId];
    [serivce execute:^(id response) {
        
        [self.expection fulfill];
    } failure:^(NSError *error) {
       
        [self.expection fulfill];
    }];
    
    //@step
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}





@end
