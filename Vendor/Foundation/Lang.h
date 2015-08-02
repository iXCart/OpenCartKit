//
//  Lang.h
//  OpenCartKit
//
//  Created by icoco7 on 6/21/15.
//  Copyright (c) 2015 i2Cart.com All rights reserved.
//

#import <Foundation/Foundation.h>


FOUNDATION_EXPORT    NSString* CTString( const NSString*);

FOUNDATION_EXPORT  NSString*   StringWithFormat(  NSString*  fmt  ,  NSString*   bString);

FOUNDATION_EXPORT    NSString*   StringJoin(  NSString*  aString  ,  NSString*   bString);
FOUNDATION_EXPORT    BOOL    StringEqual(const  NSString*  aString  ,  const NSString*   bString);


static const NSString* _TRUE = @"TRUE";
static const NSString* _FALSE = @"FALSE";
static const NSString* _TRUE_ONE= @"1";
static const NSString* _FALSE_ZERO = @"0";


@interface Lang : NSObject

 

+ (void)assginDictonaryValue:(NSDictionary*)source  key:(id)key  target:(NSMutableDictionary*)target  targetKey:(id)targetKey;

+ (NSData*) archiveObject2Data:(NSObject*)obj;

+ (NSObject*)unArchiveData2Object:(NSData*)data;


+ (BOOL) isEmptyString:(NSString*) value;

+ (BOOL) isContainsString:(const NSString*) value   token:(const NSString*) token;

+ (NSString*)safeString:(NSString*) value   toValue:(NSString*) toValue;

+ (NSString*) trimString:(NSString*) value;

+ (NSString*)safeNumberToIntString:(NSNumber*) value   toValue:(NSString*) toValue;

+ (float)safeStringToFloat:(NSString*)value toValue:(float)toValue;

+ (NSString*) toBoolString:(BOOL) value;

+ (BOOL) toBool:( NSString*) value;

+ (id)paseJSONDatatoArrayOrNSDictionary:(NSData *)jsonData;

@end
