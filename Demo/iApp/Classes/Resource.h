//
//  Resource.h
//  iCart
//
//  Created by icoco7 on 5/21/14.
//  Copyright (c) 2014 icocosoftware. All rights reserved.
//

#import <Foundation/Foundation.h>



#import "RKMappingResult.h"

extern  NSString* NotifyEventCommpleteAddCart ;

extern  NSString* NotifyEventCommpleteUpdateCart;

extern const NSString* KeyOfStoreURL ;
extern const NSString* DefaultValueOfStoreURL ;


@interface Resource : NSObject

+ (void)setupLogger;

+(UIColor*) getStandardColor;

+ (NSString*) getRestEndpoint;

+ (NSString*)getAboutURLString;

+ (NSString*)getPrivacyPolicyURLString;


+ (RKMappingResult*)parseResponse2Result:(id)response;

+ (RKMappingResult*)parseData2Result:(NSData*)data;

+ (NSArray*)getImagesDefsFromProductResult:(NSDictionary*)dict;

+ (void) assginImageWithSource:(UIImageView*)target  source:(NSString*)source;

+ (void)storeUserAccountInfo:(NSDictionary*) dict;

+ (NSDictionary*)loadUserAccountInfo;

+ (void)showRestResponseErrorMessage:(NSDictionary*)response;

+ (void)notifyCartUpdate:(NSString*)count;
@end
