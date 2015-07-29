//
//  NSDictionary+STHelper.h
//
//  Created by EIMEI on 2013/05/06.
//  Copyright (c) 2013 stack3.net (http://stack3.net/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <Foundation/Foundation.h>

/**
 * @brief Category methods to get values.
 *
 * USAGE:
 *   [dict st_integerForKey:@"value"]
 *     -> If the value was integer, it returns NSInteger value.
 *   [dict st_stringForKey:@"user.name"]
 *     -> You can get value from a nested dictionary.
 *        These methods are useful to get values from dictionary parsed JSON.
 */
@interface NSDictionary (STHelper)

#pragma mark - ForKey

- (BOOL)st_boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (BOOL)st_boolForKey:(NSString *)key;
- (NSInteger)st_integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;
- (NSInteger)st_integerForKey:(NSString *)key;
- (NSUInteger)st_unsignedIntegerForKey:(NSString *)key defaultValue:(NSUInteger)defaultValue;
- (NSUInteger)st_unsignedIntegerForKey:(NSString *)key;
- (char)st_charForKey:(NSString *)key defaultValue:(char)defaultValue;
- (char)st_charForKey:(NSString *)key;
- (unsigned char)st_unsignedCharForKey:(NSString *)key defaultValue:(unsigned char)defaultValue;
- (unsigned char)st_unsignedCharForKey:(NSString *)key;
- (short)st_shortForKey:(NSString *)key defaultValue:(short)defaultValue;
- (short)st_shortForKey:(NSString *)key;
- (unsigned short)st_unsignedShortForKey:(NSString *)key defaultValue:(unsigned short)defaultValue;
- (unsigned short)st_unsignedShortForKey:(NSString *)key;
- (long)st_longForKey:(NSString *)key defaultValue:(long)defaultValue;
- (long)st_longForKey:(NSString *)key;
- (unsigned long)st_unsignedLongForKey:(NSString *)key defaultValue:(unsigned long)defaultValue;
- (unsigned long)st_unsignedLongForKey:(NSString *)key;
- (long long)st_longLongForKey:(NSString *)key defaultValue:(long long)defaultValue;
- (long long)st_longLongForKey:(NSString *)key;
- (unsigned long long)st_unsignedLongLongForKey:(NSString *)key defaultValue:(unsigned long long)defaultValue;
- (unsigned long long)st_unsignedLongLongForKey:(NSString *)key;
- (int8_t)st_int8ForKey:(NSString *)key defaultValue:(int8_t)defaultValue;
- (int8_t)st_int8ForKey:(NSString *)key;
- (uint8_t)st_uint8ForKey:(NSString *)key defaultValue:(uint8_t)defaultValue;
- (uint8_t)st_uint8ForKey:(NSString *)key;
- (int16_t)st_int16ForKey:(NSString *)key defaultValue:(int16_t)defaultValue;
- (int16_t)st_int16ForKey:(NSString *)key;
- (uint16_t)st_uint16ForKey:(NSString *)key defaultValue:(uint16_t)defaultValue;
- (uint16_t)st_uint16ForKey:(NSString *)key;
- (int32_t)st_int32ForKey:(NSString *)key defaultValue:(int32_t)defaultValue;
- (int32_t)st_int32ForKey:(NSString *)key;
- (uint32_t)st_uint32ForKey:(NSString *)key defaultValue:(uint32_t)defaultValue;
- (uint32_t)st_uint32ForKey:(NSString *)key;
- (int64_t)st_int64ForKey:(NSString *)key defaultValue:(int64_t)defaultValue;
- (int64_t)st_int64ForKey:(NSString *)key;
- (uint64_t)st_uint64ForKey:(NSString *)key defaultValue:(uint64_t)defaultValue;
- (uint64_t)st_uint64ForKey:(NSString *)key;
- (float)st_floatForKey:(NSString *)key defaultValue:(float)defaultValue;
- (float)st_floatForKey:(NSString *)key;
- (double)st_doubleForKey:(NSString *)key defaultValue:(double)defaultValue;
- (double)st_doubleForKey:(NSString *)key;
- (NSTimeInterval)st_timeIntervalForKey:(NSString *)key defaultValue:(NSTimeInterval)defaultValue;
- (NSTimeInterval)st_timeIntervalForKey:(NSString *)key;
- (id)st_objectForKey:(NSString *)key defaultValue:(id)defaultValue;
- (id)st_objectForKey:(NSString *)key;
- (NSString *)st_stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (NSString *)st_stringForKey:(NSString *)key;
- (NSArray *)st_arrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;
- (NSArray *)st_arrayForKey:(NSString *)key;
- (NSDictionary *)st_dictionaryForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue;
- (NSDictionary *)st_dictionaryForKey:(NSString *)key;
- (NSDate *)st_dateForKey:(NSString *)key defaultValue:(NSDate *)defaultValue;
- (NSDate *)st_dateForKey:(NSString *)key;
- (NSData *)st_dataForKey:(NSString *)key defaultValue:(NSData *)defaultValue;
- (NSData *)st_dataForKey:(NSString *)key;
- (NSURL *)st_URLForKey:(NSString *)key defaultValue:(NSURL *)defaultValue;
- (NSURL *)st_URLForKey:(NSString *)key;

#pragma mark - ForPath

- (BOOL)st_boolForPath:(NSString *)path defaultValue:(BOOL)defaultValue;
- (BOOL)st_boolForPath:(NSString *)path;
- (NSInteger)st_integerForPath:(NSString *)path defaultValue:(NSInteger)defaultValue;
- (NSInteger)st_integerForPath:(NSString *)path;
- (NSUInteger)st_unsignedIntegerForPath:(NSString *)path defaultValue:(NSUInteger)defaultValue;
- (NSUInteger)st_unsignedIntegerForPath:(NSString *)path;
- (char)st_charForPath:(NSString *)key defaultValue:(char)defaultValue;
- (char)st_charForPath:(NSString *)key;
- (unsigned char)st_unsignedCharForPath:(NSString *)key defaultValue:(unsigned char)defaultValue;
- (unsigned char)st_unsignedCharForPath:(NSString *)key;
- (short)st_shortForPath:(NSString *)key defaultValue:(short)defaultValue;
- (short)st_shortForPath:(NSString *)key;
- (unsigned short)st_unsignedShortForPath:(NSString *)key defaultValue:(unsigned short)defaultValue;
- (unsigned short)st_unsignedShortForPath:(NSString *)key;
- (long)st_longForPath:(NSString *)key defaultValue:(long)defaultValue;
- (long)st_longForPath:(NSString *)key;
- (unsigned long)st_unsignedLongForPath:(NSString *)key defaultValue:(unsigned long)defaultValue;
- (unsigned long)st_unsignedLongForPath:(NSString *)key;
- (long long)st_longLongForPath:(NSString *)key defaultValue:(long long)defaultValue;
- (long long)st_longLongForPath:(NSString *)key;
- (unsigned long long)st_unsignedLongLongForPath:(NSString *)key defaultValue:(unsigned long long)defaultValue;
- (unsigned long long)st_unsignedLongLongForPath:(NSString *)key;
- (int8_t)st_int8ForPath:(NSString *)path defaultValue:(int8_t)defaultValue;
- (int8_t)st_int8ForPath:(NSString *)path;
- (uint8_t)st_uint8ForPath:(NSString *)path defaultValue:(uint8_t)defaultValue;
- (uint8_t)st_uint8ForPath:(NSString *)path;
- (int16_t)st_int16ForPath:(NSString *)path defaultValue:(int16_t)defaultValue;
- (int16_t)st_int16ForPath:(NSString *)path;
- (uint16_t)st_uint16ForPath:(NSString *)path defaultValue:(uint16_t)defaultValue;
- (uint16_t)st_uint16ForPath:(NSString *)path;
- (int32_t)st_int32ForPath:(NSString *)path defaultValue:(int32_t)defaultValue;
- (int32_t)st_int32ForPath:(NSString *)path;
- (uint32_t)st_uint32ForPath:(NSString *)path defaultValue:(uint32_t)defaultValue;
- (uint32_t)st_uint32ForPath:(NSString *)path;
- (int64_t)st_int64ForPath:(NSString *)path defaultValue:(int64_t)defaultValue;
- (int64_t)st_int64ForPath:(NSString *)path;
- (uint64_t)st_uint64ForPath:(NSString *)path defaultValue:(uint64_t)defaultValue;
- (uint64_t)st_uint64ForPath:(NSString *)path;
- (float)st_floatForPath:(NSString *)path defaultValue:(float)defaultValue;
- (float)st_floatForPath:(NSString *)path;
- (double)st_doubleForPath:(NSString *)path defaultValue:(double)defaultValue;
- (double)st_doubleForPath:(NSString *)path;
- (NSObject *)st_objectForPath:(NSString *)path defaultValue:(NSObject *)defaultValue;
- (NSObject *)st_objectForPath:(NSString *)path;
- (NSString *)st_stringForPath:(NSString *)path defaultValue:(NSString *)defaultValue;
- (NSString *)st_stringForPath:(NSString *)path;
- (NSArray *)st_arrayForPath:(NSString *)path defaultValue:(NSArray *)defaultValue;
- (NSArray *)st_arrayForPath:(NSString *)path;
- (NSDictionary *)st_dictionaryForPath:(NSString *)path defaultValue:(NSDictionary *)defaultValue;
- (NSDictionary *)st_dictionaryForPath:(NSString *)path;
- (NSDate *)st_dateForPath:(NSString *)path defaultValue:(NSDate *)defaultValue;
- (NSDate *)st_dateForPath:(NSString *)path;
- (NSData *)st_dataForPath:(NSString *)path defaultValue:(NSData *)defaultValue;
- (NSData *)st_dataForPath:(NSString *)path;
- (NSURL *)st_URLForPath:(NSString *)key defaultValue:(NSURL *)defaultValue;
- (NSURL *)st_URLForPath:(NSString *)key;

@end
