//
//  TestOCAddressService.m
//  OpenCartKit
//
//  Created by icoco7 on 7/19/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "OCTestCase.h"
#import "OCAccountService.h"

@interface TestOCAddressService : OCTestCase{
    

}
@end

@implementation TestOCAddressService

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testStep1_login {
    
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

- (void)testStep1_loginAfter {
    [self testStep8_getList];
}

static NSString *_address_id = @"";

- (void)testStep2_addAddress {
    NSString* firstname = @"Robin";
    NSString* lastname = @"C";
    NSString* address_1 = @"70# Sailing Building";
    
    NSString* city = @"Dream City";
    NSString* country_id = @"3";
    NSString* zone_id = @"72";
    
    OCAddressService *serivce = [OCAddressService add:firstname lastname:lastname company:nil address_1:address_1 address_2:nil city:city postcode:nil country_id:country_id zone_id:zone_id];
    [serivce execute:^(id response) {
        NSDictionary* dict = (NSDictionary*)response;
        NSString* status = [dict stringValueForPath:@"status"];
        XCTAssertTrue([@"success" isEqualToString:status]);
        
        _address_id = [dict stringValueForPath:@"data.address_id"];
        XCTAssertTrue(![CKStringUtils isEmpty:_address_id]);
        [self.expection fulfill];
    } failure:^(NSError *error) {
        [self.expection fulfill];
    }];
    
    //@step
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)testStep2_addAddressAfter{
    [self testStep8_getList];
}

#pragma -mark 
#pragma -mark edit

- (void)testStep3_editAddress {
    NSString* firstname = @"Robin update";
    NSString* lastname = @"C";
    NSString* address_1 = @"70# Sailing Building";
    
    NSString* city = @"Dream City";
    NSString* country_id = @"3";
    NSString* zone_id = @"72";
    
    NSString* address_id = _address_id;
    
    OCAddressService *serivce = [OCAddressService edit:address_id firstname: firstname lastname:lastname company:nil address_1:address_1 address_2:nil city:city postcode:nil country_id:country_id zone_id:zone_id];
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

- (void)testStep3_editAddressAfter{
    [self testStep8_getList];
}



- (void)testStep5_deleteAddress {
   
    NSString* address_id = _address_id;
    
    OCAddressService *serivce = [OCAddressService delete:address_id];
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

- (void)testStep5_deleteAddressAfter{
    [self testStep8_getList];
}

- (void)testStep8_getList{
    OCAddressService *serivce = [OCAddressService getList];
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




- (void)testStep9_1_getCountriesAndStates{
    OCAddressService *serivce = [OCAddressService countries];
    __block NSUInteger country_total = 0;
    __block NSUInteger state_total = 0;
    
    
    [serivce execute:^(id response) {
        NSArray* list = (NSArray*) response;
        country_total = [list count];
        //@step
        [self initTask:(int)country_total];
        
        [list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString* country_id = [(NSDictionary*)obj stringValueForPath:@"country_id"];
            //@step
            OCAddressService * stateSerivce = [OCAddressService regions:country_id];
            [stateSerivce execute:^(id response) {
                
                NSArray* list = (NSArray*)[(NSDictionary*)response objectForKey:@"zone"];
                
                state_total = state_total + [list count];
                //@step if complete then notify finish the unit test
                [self completTask:1];
                if ([self hasCompleteAllTask]) {
                    [self.expection fulfill ];
                }
            } failure:^(NSError *error) {
                //@step if complete then notify finish the unit test
                [self completTask:1];
                if ([self hasCompleteAllTask]) {
                    [self.expection fulfill ];
                }

            }];
        }];
        
        //@step if complete then notify finish the unit test
        if ([self hasCompleteAllTask]) {
            [self.expection fulfill ];
        }
   
    } failure:^(NSError *error) {
        [self.expection fulfill];
    }];
    
    //@step
    [self waitForExpectationsWithTimeout:100  handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    NSLog(@"\n Test done ! country total:[%lu], state total:[%lu]",country_total, (unsigned long)state_total);
}

@end
