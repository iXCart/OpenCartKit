//
//  Lang.m
//  OpenCartKit
//
//  Created by icoco7 on 6/21/15.
//  Copyright (c) 2015 icoco. All rights reserved.
//

#import "Lang.h"


#pragma NSString
//@purpose  convert constan string to  normal string
NSString* CTString( const NSString*  value)
{
    if ( nil == value) return nil;
    return [NSString stringWithFormat:@"%@", value];
}

NSString*   StringWithFormat(  NSString*  fmt  ,  NSString*   bString)
{
    NSString* result = [NSString stringWithFormat:fmt, bString];
    return result;
}


NSString*   StringJoin(  NSString*  aString  ,  NSString*   bString)
{
    aString =  [aString stringByAppendingFormat:@"%@",    bString];
    return aString;
}
BOOL    StringEqual(  NSString*  aString  ,   NSString*   bString)
{
    if ( nil == aString && nil == bString) return TRUE;
    if ( nil == aString || nil == bString) return FALSE;
    
    return [aString isEqualToString:bString];
}


@implementation Lang



+ (void)assginDictonaryValue:(NSDictionary*)source  key:(id)key  target:(NSMutableDictionary*)target  targetKey:(id)targetKey{
    if (nil == source) {
        return ;
    }
    NSObject* value = [source objectForKey:key];
    if (nil!= value) {
        [target setObject:value forKey:targetKey];
    }
}


+ (NSData*) archiveObject2Data:(NSObject*)obj{
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    return data;
}

+ (NSObject*)unArchiveData2Object:(NSData*)data{
    
    NSObject *obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return obj;
}

@end
