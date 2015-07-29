//
//  TestOCAccountService.m
//  OpenCartKit
//
//  Created by icoco7 on 7/25/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//
#import <XCTest/XCTest.h>
#import "OCTestCase.h"


@interface TestOCAccountService : OCTestCase

@end

@implementation TestOCAccountService

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test0_login {
    
    OCAccountService* serivce = [OCAccountService login:self.email password:self.password];
    [serivce execute:^(id response) {
        XCTAssertTrue([response isKindOfClass:[OCCustomer class]]);
        [self.expection fulfill ];
    } failure:^(NSError *error) {
        [self.expection fulfill ];
    }];
    //@step
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)test1_order{
    OCAccountService* serivce = [OCAccountService order:1];
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

- (void)test2_1_wishlist{
    OCWishListService* serivce = [OCWishListService wishlist];
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

NSString* _proudct_id = @"29";

- (void)test2_2_1_add_wishlist{
    OCWishListService* serivce = [OCWishListService add:_proudct_id];
    [serivce execute:^(id response) {
        NSDictionary* dict = (NSDictionary*)response;
        NSString* status = [dict stringValueForPath:@"status"];
        XCTAssertTrue([@"success" isEqualToString:status]);
        
        [self.expection fulfill ];
    } failure:^(NSError *error) {
        [self.expection fulfill ];
    }];
    //@step
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)test2_2_2_add_wishlist{
    [self test2_1_wishlist];
}

- (void)test2_3_1_remove_wishlist{
    OCWishListService* serivce = [OCWishListService remove:_proudct_id];
    [serivce execute:^(id response) {
        NSDictionary* dict = (NSDictionary*)response;
        NSString* status = [dict stringValueForPath:@"status"];
        XCTAssertTrue([@"success" isEqualToString:status]);
        [self.expection fulfill ];
    } failure:^(NSError *error) {
        [self.expection fulfill ];
    }];
    //@step
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)test2_3_2_remove_wishlist{
    [self test2_1_wishlist];
}


@end
