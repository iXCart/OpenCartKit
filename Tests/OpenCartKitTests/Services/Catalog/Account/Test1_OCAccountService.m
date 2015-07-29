//
//  TestOCUserService.m
//  OpenCartKit
//
//  Created by icoco7 on 6/24/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "OCTestCase.h"
#import "OCAccountService.h"
#import "OCCustomer.h"

@interface Test1_OCAccountService : OCTestCase{
    BOOL _hasLogging  ;
}
@end

@implementation Test1_OCAccountService

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test0_register {
    NSString* firstname = @"OpenCartKit tester";
    NSString* lastname = @"C";
    NSString* email = self.email;
    NSString* password = self.password;
    NSString* confirm = @"1234";
    
    NSString* telephone = @"110";
    NSString* address_1 = @"70# Sailing Building";
    
    NSString* city = @"Dream City";
    NSString* postcode = @"AL78";
    NSString* country_id = @"3";
    NSString* zone_id = @"72";
    
    
    OCAccountService* serivce = [OCAccountService register:firstname lastname:lastname email:email password:password confirm:confirm telephone:telephone fax:nil company:nil address_1:address_1 address_2:nil city:city postcode:postcode country_id:country_id zone_id:zone_id agree:true newsletter:true];
    [serivce execute:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            NSDictionary* dict = (NSDictionary*)response;
            NSString* status = [dict stringValueForPath:@"status"];
            BOOL success = [@"success" isEqualToString:status];
            XCTAssertTrue(success);
            if (success) {
                self.email = email;
                self.password = password;
            }
        }
 
        [self.expection fulfill ];
    } failure:^(NSError *error) {
         [self.expection fulfill ];
    }];
    
    //@step
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



- (void)test1_login {
    NSString* email =  self.email;
    NSString* password = self.password;
    
    OCAccountService* serivce = [OCAccountService login:email password:password];
    [serivce execute:^(id response) {
        XCTAssertTrue([response isKindOfClass:[OCCustomer class]]);
        _hasLogging = true;
        [self.expection fulfill ];
        
    } failure:^(NSError *error) {
        [self.expection fulfill ];
    }];
      //@step
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



- (void)test2_edit {
    NSString* firstname = @"Name update by OpencartKit";
    NSString* lastname = @"C";
    NSString* email = self.email;
    NSString* telephone = @"110";
    NSString* fax = @"fax";
    
    
    OCAccountService* serivce = [OCAccountService edit:firstname lastname:lastname email:email telephone:telephone fax:fax];
    [serivce execute:^(id response) {
        NSDictionary* dict = (NSDictionary*)response;
        NSString* status = [dict stringValueForPath:@"status"];
        BOOL success = [@"success" isEqualToString:status];
        XCTAssertTrue(success);
        [self.expection fulfill ];
    } failure:^(NSError *error) {
        
        [self.expection fulfill ];
    }];
    
    //@step
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



- (void)test8_1_logout{
    OCAccountService* serivce = [OCAccountService logout];
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


- (void)notest8_2_forgotten {
    // if execute the 'forgotten' service, then the account will be invlidated unless activite it via email;
    //@step still can do this test with single unit test if remove the return statement below
  
    
    NSString* email = self.email;
    OCAccountService* serivce = [OCAccountService forgotten:email];
    [serivce execute:^(id response) {
        NSDictionary* dict = (NSDictionary*)response;
        NSString* status = [dict stringValueForPath:@"status"];
        BOOL success = [@"success" isEqualToString:status];
        XCTAssertTrue(success);
        [self.expection fulfill ];
        
    } failure:^(NSError *error) {
        
        [self.expection fulfill ];
    }];
    
    //@step
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


//- (void)test4_LoginAndEdit {
//    OCAccountService* serivce = [OCAccountService login:self.email password:self.password];
//    [serivce execute:^(id response) {
//        if (![response isKindOfClass:[OCCustomer class]]){
//            return ;
//        }
//         
//       // [self.expection fulfill ];
//        NSString* firstname = @"Name update by OCkit";
//        NSString* lastname = @"C";
//        NSString* telephone = @"110";
//        NSString* fax = @"fax 001";
//        
//        
//        OCAccountService* serivce = [OCAccountService edit:firstname lastname:lastname email:self.email telephone:telephone fax:fax];
//        [serivce execute:^(id response) {
//            NSDictionary* dict = (NSDictionary*)response;
//            NSString* status = [dict stringValueForPath:@"status"];
//            BOOL success = [@"success" isEqualToString:status];
//            XCTAssertTrue(success);
//            [self.expection fulfill ];
//        } failure:^(NSError *error) {
//           
//            [self.expection fulfill ];
//        }];
//
//    } failure:^(NSError *error) {
//       
//        [self.expection fulfill ];
//    }];
//    
//    
//    //@step
//    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
//}
//



@end
