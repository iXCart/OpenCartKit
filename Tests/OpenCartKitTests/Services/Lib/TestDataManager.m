//
//  OCTestDataManager.m
//  OpenCartKit
//
//  Created by icoco7 on 7/8/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "OCTestCase.h"

#import "OCDataManager.h"

@interface TestDataManager : OCTestCase

@end

@implementation TestDataManager

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPost {
    // This is an example of a functional test case.
  //  NSString* url = @"http://127.0.0.1/test/post.php";
    
    NSString* firstname = @"Robin";
    NSString* lastname = @"C";
    NSString* email = @"ixcoder@hotmail.com";
    NSString* password = @"110";
    NSString* confirm = @"110";
    
    NSString* telephone = @"110";
    NSString* address_1 = @"70# Sailing Building";
    
    NSString* city = @"Dream City";
    NSString* postcode = @"AL78";
    NSString* country_id = @"3";
    NSString* zone_id = @"72";
    
  //  NSString* newsletter = @"1";
    NSDictionary* dict = OCNSDictionaryOfParametersBindingsJson(firstname,lastname,email,password,confirm,
                                                                telephone,address_1,city,postcode,country_id,zone_id                                 );
    dict = nil;
//    [[OCDataManager sharedInstance]POST:url params:dict success:^(id response) {
//          [self.expection fulfill ];
//        NSLog(@"success:%@", response);
//    } successFilter:nil failure:^(NSError *error) {
//          [self.expection fulfill ];
//        NSLog(@"failure:%@", error);
//        
//    }];
    //@ jump
    [self.expection fulfill ];
    //@step
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}



@end
