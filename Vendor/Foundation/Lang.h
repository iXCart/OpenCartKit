//
//  Lang.h
//  OpenCartKit
//
//  Created by icoco7 on 6/21/15.
//  Copyright (c) 2015 icoco. All rights reserved.
//

#import <Foundation/Foundation.h>


FOUNDATION_EXPORT    NSString* CTString( const NSString*);

FOUNDATION_EXPORT  NSString*   StringWithFormat(  NSString*  fmt  ,  NSString*   bString);

FOUNDATION_EXPORT    NSString*   StringJoin(  NSString*  aString  ,  NSString*   bString);
FOUNDATION_EXPORT    BOOL    StringEqual(const  NSString*  aString  ,  const NSString*   bString);

@interface Lang : NSObject

 

+ (void)assginDictonaryValue:(NSDictionary*)source  key:(id)key  target:(NSMutableDictionary*)target  targetKey:(id)targetKey;

+ (NSData*) archiveObject2Data:(NSObject*)obj;

+ (NSObject*)unArchiveData2Object:(NSData*)data;


@end
