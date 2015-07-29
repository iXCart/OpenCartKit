//
//  NSMutableDictionary+STHelper.h
//  NSDictionary+STHelper
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
#import <UIKit/UIKit.h>

@interface NSMutableDictionary (STHelper)

- (void)st_setBool:(BOOL)value forKey:(NSString *)key;
- (void)st_setInteger:(NSInteger)value forKey:(NSString *)key;
- (void)st_setUnsignedInteger:(NSUInteger)value forKey:(NSString *)key;
- (void)st_setChar:(char)value forKey:(NSString *)key;
- (void)st_setUnsignedChar:(unsigned char)value forKey:(NSString *)key;
- (void)st_setShort:(short)value forKey:(NSString *)key;
- (void)st_setUnsignedShort:(unsigned short)value forKey:(NSString *)key;
- (void)st_setLong:(long)value forKey:(NSString *)key;
- (void)st_setUnsignedLong:(unsigned long)value forKey:(NSString *)key;
- (void)st_setLongLong:(long long)value forKey:(NSString *)key;
- (void)st_setUnsignedLongLong:(unsigned long long)value forKey:(NSString *)key;
- (void)st_setInt8:(int8_t)value forKey:(NSString *)key;
- (void)st_setUInt8:(uint8_t)value forKey:(NSString *)key;
- (void)st_setInt16:(int16_t)value forKey:(NSString *)key;
- (void)st_setUInt16:(uint16_t)value forKey:(NSString *)key;
- (void)st_setInt32:(int32_t)value forKey:(NSString *)key;
- (void)st_setUInt32:(uint32_t)value forKey:(NSString *)key;
- (void)st_setInt64:(int64_t)value forKey:(NSString *)key;
- (void)st_setUInt64:(uint64_t)value forKey:(NSString *)key;
- (void)st_setFloat:(float)value forKey:(NSString *)key;
- (void)st_setDouble:(double)value forKey:(NSString *)key;
- (void)st_setTimeInterval:(NSTimeInterval)value forKey:(NSString *)key;
- (void)st_setCGPoint:(CGPoint)value forKey:(NSString *)key;
- (void)st_setCGRect:(CGRect)value forKey:(NSString *)key;
- (void)st_setCGSize:(CGSize)value forKey:(NSString *)key;
- (void)st_setCGAffineTransform:(CGAffineTransform)value forKey:(NSString *)key;
- (void)st_setUIEdgeInsets:(UIEdgeInsets)value forKey:(NSString *)key;
- (void)st_setUIOffset:(UIOffset)value forKey:(NSString *)key;

@end
