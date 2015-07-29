//
//  TestOCCartService.m
//  OpenCartKit
//
//  Created by icoco7 on 7/18/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OCTestCase.h"

@interface TestOCCartService : OCTestCase{
    NSString* _productId ;
}

@end

@implementation TestOCCartService

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    _productId = @"29";// @"34";
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test0_1_login {
    
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

//@step get the products before add product
- (void)test0_2_getProuct{
    [self test2_getProducts];
}


- (void)test1_addProuct {
    
    OCCartService *serivce = [OCCartService add:_productId quantity:10];
    [serivce execute:^(id response) {
        NSDictionary* dict = (NSDictionary*)response;
        NSString* status = [dict stringValueForPath:@"status"];
        XCTAssertTrue([@"success" isEqualToString:status]);
        [self.expection fulfill];
    } failure:^(NSError *error) {
        
        [self.expection fulfill];
    }];
    
    //@step
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



static NSString* _keyOfProduct = @""; //use to test 'edit' and 'remove'
- (void)test2_getProducts {
     
    OCCartService *serivce = [OCCartService getProducts];
    [serivce execute:^(id response) {
        XCTAssertTrue([OCCartService isSuccessOperation:response]);
        NSDictionary* dict = (NSDictionary*)response;
        NSArray* list = (NSArray*)[dict objectForKey:@"products"];
        
        [list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary* item = obj;
            NSString* product_id = [item stringValueForPath:@"product_id"];
            if ([_productId isEqualToString:product_id]) {
                //@step we want remove the first proudct from the cart
                if ([CKStringUtils isEmpty:_keyOfProduct]){
                    _keyOfProduct = [item objectForKey:@"key"];
                }
                *stop = true;
            }
        }];
        
        [self.expection fulfill];
    } failure:^(NSError *error) {
        [self.expection fulfill];
    }];
    
    //@step
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)test3_1_updateProduct {
    NSNumber* update_quantity = [NSNumber numberWithInt:199];
    NSDictionary* updateProducts = [NSDictionary dictionaryWithObjectsAndKeys:update_quantity,_keyOfProduct, nil];
    OCCartService *serivce = [OCCartService edit:updateProducts];
    [serivce execute:^(id response) {
        NSDictionary* dict = (NSDictionary*)response;
        NSString* status = [dict stringValueForPath:@"status"];
        XCTAssertTrue([@"success" isEqualToString:status]);
        [self.expection fulfill];
    } failure:^(NSError *error) {
        [self.expection fulfill];
    }];
    
    //@step
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}
//@step get the products again to check the update operation success or not
- (void)test3_2_updateProduct{
    [self test2_getProducts];
}

- (void)test4_1_removeProduct {
    
    OCCartService *serivce = [OCCartService remove:_keyOfProduct];
    [serivce execute:^(id response) {
        NSDictionary* dict = (NSDictionary*)response;
        NSString* status = [dict stringValueForPath:@"status"];
        XCTAssertTrue([@"success" isEqualToString:status]);
        [self.expection fulfill];
    } failure:^(NSError *error) {
        [self.expection fulfill];
    }];
    
    //@step
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//@step get the products again to check the remove operation success or not
- (void)test4_2_removeProduct{
    [self test2_getProducts];
}

@end
