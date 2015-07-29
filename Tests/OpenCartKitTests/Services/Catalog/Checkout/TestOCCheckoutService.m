//
//  TestOCCheckoutService.m
//  OpenCartKit
//
//  Created by icoco7 on 7/19/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "OCTestCase.h"
#import "OCAccountService.h"

@interface TestOCCheckoutService : OCTestCase

@end

@implementation TestOCCheckoutService

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testStep0_login {
    
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

- (void)testStep1_addProudct2Cart {
    
    NSString* productId = @"40";// @"29";
    
    OCCartService *serivce = [OCCartService add:productId quantity:9];
    [serivce execute:^(id response) {
        NSLog(@" success response:%@", response);
        [self.expection fulfill];
    } failure:^(NSError *error) {
        [self.expection fulfill];
    }];
    
    //@step
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

static NSString *_address_id = @"";

- (void)testStep2_1_addPaymentAddress {
    NSString* firstname = @"Robin";
    NSString* lastname = @"C";
    NSString* address_1 = @"Payment address 70# Sailing Building ";
    
    NSString* city = @"Dream City";
    NSString* country_id = @"3";
    NSString* zone_id = @"72";
    
    OCCheckoutService *serivce = [OCCheckoutService addPaymentAddress:firstname lastname:lastname company:nil address_1:address_1 address_2:nil city:city postcode:nil country_id:country_id zone_id:zone_id];
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

- (void)testStep2_2_setPaymentAddress4Continue {
   
    
    OCCheckoutService *serivce = [OCCheckoutService setPaymentAddress:_address_id];
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


- (void)testStep2_3_paymentAddress{
    OCCheckoutService *serivce = [OCCheckoutService paymentAddress];
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

#pragma -mark
#pragma -mark test Shipping Address 

- (void)testStep3_1_addShippingAddress {
    NSString* firstname = @"Robin";
    NSString* lastname = @"C";
    NSString* address_1 = @"Shipping address 70# Sailing Building ";
    
    NSString* city = @"Dream City";
    NSString* country_id = @"3";
    NSString* zone_id = @"72";
    
    OCCheckoutService *serivce = [OCCheckoutService addShippingAddress:firstname lastname:lastname company:nil address_1:address_1 address_2:nil city:city postcode:nil country_id:country_id zone_id:zone_id];
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

- (void)testStep3_2_setShippingAddress4Continue {
    
    OCCheckoutService *serivce = [OCCheckoutService setShippingAddress:_address_id];
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


- (void)testStep3_3_shippingAddress{
    OCCheckoutService *serivce = [OCCheckoutService shippingAddress];
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

#pragma -mark
#pragma -mark shipping method 
static NSString* _shipping_method = @"";
/*
 
 {
	"button_continue": "Continue",
	"code": "",
	"comment": "",
	"error_warning": "",
	"shipping_methods": {
        "flat": {
            "error": false,
            "quote": {
                "flat": {
                    "code": "flat.flat",
                    "cost": "5.00",
                    "tax_class_id": "9",
                    "text": "$5.00",
                    "title": "Flat Shipping Rate"
                }
            },
            "sort_order": "1",
            "title": "Flat Rate"
        }
    },
	"text_comments": "Add Comments About Your Order",
	"text_loading": "Loading...",
	"text_shipping_method": "Please select the preferred shipping method to use on this order."
 }
 
 */
- (void)testStep4_1_shippingMethod{
    OCCheckoutService *serivce = [OCCheckoutService shippingMethod];
    [serivce execute:^(id response) {
        NSDictionary* shipping_methods = (NSDictionary*)[(NSDictionary*)response objectForKey:@"shipping_methods"];
        if(shipping_methods){
            NSString* code = [shipping_methods stringValueForPath:@"flat.quote.flat.code"];
            _shipping_method = code;
            XCTAssertFalse([CKStringUtils isEmpty:_shipping_method]);
        }
        [self.expection fulfill];
    } failure:^(NSError *error) {
        [self.expection fulfill];
    }];
    
    //@step
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)testStep4_2_setShippingMethod{
    NSString* comment = @"test by OpencartKit";
    OCCheckoutService *serivce = [OCCheckoutService setShippingMethod:_shipping_method comment:comment];
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


#pragma -mark
#pragma -mark payment method
static NSString* _payment_method = @"";
/*
 {
	"agree": "",
	"button_continue": "Continue",
	"code": "",
	"comment": "",
	"error_warning": "",
	"payment_methods": {
        "cod": {
            "code": "cod",
            "sort_order": "5",
            "terms": "",
            "title": "Cash On Delivery"
        }
	},
	"scripts": [
	],
	"text_agree": "I have read and agree to the <a href=\"http://127.0.0.1/oc2.0.3/index.php?route=information/information/agree&amp;information_id=5\" class=\"agree\"><b>Terms &amp; Conditions</b></a>",
	"text_comments": "Add Comments About Your Order",
	"text_loading": "Loading...",
	"text_payment_method": "Please select the preferred payment method to use on this order."
 }
 */
- (void)testStep5_1_paymentMethod{
    OCCheckoutService *serivce = [OCCheckoutService paymentMethod];
    [serivce execute:^(id response) {
        NSDictionary* payment_methods = (NSDictionary*)[(NSDictionary*)response objectForKey:@"payment_methods"];
        if(payment_methods){
            NSString* code = [payment_methods stringValueForPath:@"cod.code"];
            _payment_method = code;
            XCTAssertFalse([CKStringUtils isEmpty:_payment_method]);
        }
        [self.expection fulfill];
    } failure:^(NSError *error) {
        [self.expection fulfill];
    }];
    
    //@step
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)testStep5_2_setPaymentMethod{
    NSString* comment = @"payment method test by OpencartKit";
    OCCheckoutService *serivce = [OCCheckoutService setPaymentMethod:_payment_method comment:comment agree:true];
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

- (void)testStep5_3_setPaymentMethod{
    NSString* comment = @"payment method test by OpencartKit";
    OCCheckoutService *serivce = [OCCheckoutService setPaymentMethod:_payment_method comment:comment agree:false];
    [serivce execute:^(id response) {
        NSDictionary* dict = (NSDictionary*)response;
        NSString* status = [dict stringValueForPath:@"status"];
        XCTAssertFalse([@"success" isEqualToString:status]);
        [self.expection fulfill];
    } failure:^(NSError *error) {
        [self.expection fulfill];
    }];
    
    //@step
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (void)testStep6_1_confirm{
    OCCheckoutService *serivce = [OCCheckoutService confirm];
    [serivce execute:^(id response) {
        NSDictionary* dict = (NSDictionary*)response;
        NSArray* products = [dict objectForKey:@"products"];
        XCTAssertTrue( products || [products count]<=0);
        [self.expection fulfill];
    } failure:^(NSError *error) {
        [self.expection fulfill];
    }];
    
    //@step
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)testStep6_2_paymentConfirm{
    OCCheckoutService *serivce = [OCCheckoutService paymentConfirm];
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

- (void)testStep6_4_success{
    OCCheckoutService *serivce = [OCCheckoutService success];
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

@end
