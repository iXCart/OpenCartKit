//
//  NSDictionary+STHelper.m
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

#import "NSDictionary+STHelper.h"

@implementation NSDictionary (STHelper)

#pragma mark - ForKey

- (BOOL)st_boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue
{
    id obj = [self objectForKey:key];
	if (obj && [obj isKindOfClass:[NSNumber class]]) {
		return [(NSNumber *)obj boolValue];
	} else {
		return defaultValue;
	}
}

- (BOOL)st_boolForKey:(NSString *)key
{
	return [self st_boolForKey:key defaultValue:NO];
}

- (NSInteger)st_integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj integerValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return [(NSString *)obj integerValue];
        }
    }
    
    return defaultValue;
}

- (NSInteger)st_integerForKey:(NSString *)key
{
	return [self st_integerForKey:key defaultValue:0];
}

- (NSUInteger)st_unsignedIntegerForKey:(NSString *)key defaultValue:(NSUInteger)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj unsignedIntegerValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return (NSInteger)strtoul([(NSString *)obj UTF8String], NULL, 0);
        }
    }
    
    return defaultValue;
}

- (NSUInteger)st_unsignedIntegerForKey:(NSString *)key
{
	return [self st_unsignedIntegerForKey:key defaultValue:0];
}

- (char)st_charForKey:(NSString *)key defaultValue:(char)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj charValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return (char)[(NSString *)obj integerValue];
        }
    }
    
    return defaultValue;
}

- (char)st_charForKey:(NSString *)key
{
	return [self st_charForKey:key defaultValue:0];
}

- (unsigned char)st_unsignedCharForKey:(NSString *)key defaultValue:(unsigned char)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj unsignedCharValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return (unsigned char)[(NSString *)obj integerValue];
        }
    }
    
    return defaultValue;
}

- (unsigned char)st_unsignedCharForKey:(NSString *)key
{
	return [self st_unsignedCharForKey:key defaultValue:0];
}

- (short)st_shortForKey:(NSString *)key defaultValue:(short)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj shortValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return (short)[(NSString *)obj integerValue];
        }
    }
    
    return defaultValue;
}

- (short)st_shortForKey:(NSString *)key
{
	return [self st_shortForKey:key defaultValue:0];
}

- (unsigned short)st_unsignedShortForKey:(NSString *)key defaultValue:(unsigned short)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj unsignedShortValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return (unsigned short)[(NSString *)obj integerValue];
        }
    }
    
    return defaultValue;
}

- (unsigned short)st_unsignedShortForKey:(NSString *)key
{
	return [self st_unsignedShortForKey:key defaultValue:0];
}

- (long)st_longForKey:(NSString *)key defaultValue:(long)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj longValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return (long)[(NSString *)obj integerValue];
        }
    }
    
    return defaultValue;
}

- (long)st_longForKey:(NSString *)key
{
	return [self st_longForKey:key defaultValue:0];
}

- (unsigned long)st_unsignedLongForKey:(NSString *)key defaultValue:(unsigned long)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj unsignedLongValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return (unsigned long)strtoul([(NSString *)obj UTF8String], NULL, 0);
        }
    }
    
    return defaultValue;
}

- (unsigned long)st_unsignedLongForKey:(NSString *)key
{
	return [self st_unsignedLongForKey:key defaultValue:0];
}

- (long long)st_longLongForKey:(NSString *)key defaultValue:(long long)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj longLongValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return (long long)strtoll([(NSString *)obj UTF8String], NULL, 0);
        }
    }
    
    return defaultValue;
}

- (long long)st_longLongForKey:(NSString *)key
{
	return [self st_longLongForKey:key defaultValue:0];
}

- (unsigned long long)st_unsignedLongLongForKey:(NSString *)key defaultValue:(unsigned long long)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj unsignedLongLongValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return (unsigned long long)strtoull([(NSString *)obj UTF8String], NULL, 0);
        }
    }
    
    return defaultValue;
}

- (unsigned long long)st_unsignedLongLongForKey:(NSString *)key
{
	return [self st_unsignedLongLongForKey:key defaultValue:0];
}

- (int8_t)st_int8ForKey:(NSString *)key defaultValue:(int8_t)defaultValue
{
    return [self st_charForKey:key defaultValue:defaultValue];
}

- (int8_t)st_int8ForKey:(NSString *)key
{
	return [self st_charForKey:key];
}

- (uint8_t)st_uint8ForKey:(NSString *)key defaultValue:(uint8_t)defaultValue
{
    return [self st_unsignedCharForKey:key defaultValue:defaultValue];
}

- (uint8_t)st_uint8ForKey:(NSString *)key
{
	return [self st_unsignedCharForKey:key];
}

- (int16_t)st_int16ForKey:(NSString *)key defaultValue:(int16_t)defaultValue
{
    return [self st_shortForKey:key defaultValue:defaultValue];
}

- (int16_t)st_int16ForKey:(NSString *)key
{
	return [self st_shortForKey:key];
}

- (uint16_t)st_uint16ForKey:(NSString *)key defaultValue:(uint16_t)defaultValue
{
    return [self st_unsignedShortForKey:key defaultValue:defaultValue];
}

- (uint16_t)st_uint16ForKey:(NSString *)key
{
	return [self st_unsignedShortForKey:key];
}

- (int32_t)st_int32ForKey:(NSString *)key defaultValue:(int32_t)defaultValue
{
    return (int32_t)[self st_longForKey:key defaultValue:defaultValue];
}

- (int32_t)st_int32ForKey:(NSString *)key
{
	return (int32_t)[self st_longForKey:key];
}

- (uint32_t)st_uint32ForKey:(NSString *)key defaultValue:(uint32_t)defaultValue
{
    return (uint32_t)[self st_unsignedLongForKey:key defaultValue:defaultValue];
}

- (uint32_t)st_uint32ForKey:(NSString *)key
{
	return (uint32_t)[self st_unsignedLongForKey:key];
}

- (int64_t)st_int64ForKey:(NSString *)key defaultValue:(int64_t)defaultValue
{
    return [self st_longLongForKey:key defaultValue:defaultValue];
}

- (int64_t)st_int64ForKey:(NSString *)key
{
	return [self st_longLongForKey:key];
}

- (uint64_t)st_uint64ForKey:(NSString *)key defaultValue:(uint64_t)defaultValue
{
	return [self st_unsignedLongLongForKey:key defaultValue:defaultValue];
}

- (uint64_t)st_uint64ForKey:(NSString *)key
{
	return [self st_unsignedLongLongForKey:key];
}

- (float)st_floatForKey:(NSString *)key defaultValue:(float)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj floatValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return [(NSString *)obj floatValue];
        }
    }
    
    return defaultValue;
}

- (float)st_floatForKey:(NSString *)key
{
	return [self st_floatForKey:key defaultValue:0];
}

- (double)st_doubleForKey:(NSString *)key defaultValue:(double)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj doubleValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return [(NSString *)obj doubleValue];
        }
    }
    
    return defaultValue;
}

- (double)st_doubleForKey:(NSString *)key
{
	return [self st_doubleForKey:key defaultValue:0];
}

- (NSTimeInterval)st_timeIntervalForKey:(NSString *)key defaultValue:(NSTimeInterval)defaultValue
{
    return [self st_doubleForKey:key defaultValue:defaultValue];
}

- (NSTimeInterval)st_timeIntervalForKey:(NSString *)key
{
	return [self st_doubleForKey:key defaultValue:0];
}

- (id)st_objectForKey:(NSString *)key defaultValue:(NSString *)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
		return obj;
	} else {
		return defaultValue;
	}
}

- (id)st_objectForKey:(NSString *)key
{
    return [self st_objectForKey:key defaultValue:nil];
}

- (NSString *)st_stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSString class]]) {
            return obj;
        } else if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj stringValue];
        }
    }
    
    return defaultValue;
}

- (NSString *)st_stringForKey:(NSString *)key
{
	return [self st_stringForKey:key defaultValue:nil];
}

- (NSArray *)st_arrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue
{
	id obj = [self objectForKey:key];
    if (obj && [obj isKindOfClass:[NSArray class]]) {
		return obj;
	} else {
		return defaultValue;
	}
}

- (NSArray *)st_arrayForKey:(NSString *)key
{
	return [self st_arrayForKey:key defaultValue:nil];
}

- (NSDictionary *)st_dictionaryForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue
{
	id obj = [self objectForKey:key];
    if (obj && [obj isKindOfClass:[NSDictionary class]]) {
		return obj;
	} else {
		return defaultValue;
	}
}

- (NSDictionary *)st_dictionaryForKey:(NSString *)key
{
	return [self st_dictionaryForKey:key defaultValue:nil];
}

- (NSDate *)st_dateForKey:(NSString *)key defaultValue:(NSDate *)defaultValue
{
	id obj = [self objectForKey:key];
    if (obj && [obj isKindOfClass:[NSDate class]]) {
		return obj;
	} else {
		return defaultValue;
	}
}

- (NSDate *)st_dateForKey:(NSString *)key
{
	return [self st_dateForKey:key defaultValue:nil];
}

- (NSData *)st_dataForKey:(NSString  *)key defaultValue:(NSData *)defaultValue
{
    id obj = [self objectForKey:key];
	if (obj && [obj isKindOfClass:[NSData class]]) {
		return obj;
	} else {
		return defaultValue;
	}
}

- (NSData *)st_dataForKey:(NSString *)key
{
    return [self st_dataForKey:key defaultValue:nil];
}

- (NSURL *)st_URLForKey:(NSString *)key defaultValue:(NSURL *)defaultValue
{
    id obj = [self objectForKey:key];
	if (obj && [obj isKindOfClass:[NSURL class]]) {
		return obj;
	} else {
		return defaultValue;
	}
}

- (NSURL *)st_URLForKey:(NSString *)key
{
    return [self st_URLForKey:key defaultValue:nil];
}

#pragma mark - ForPath

- (NSDictionary *)st_dictionaryForPaths:(NSArray *)paths
{
    if (paths.count == 0) {
        return nil;
    }
    
    NSDictionary *target = self;
    for (int i = 0; i < paths.count - 1; i++) {
        NSString *key = [paths objectAtIndex:i];
        target = [target st_dictionaryForKey:key];
        if (!target) {
            return nil;
        }
    }
    
    return target;
}

- (BOOL)st_boolForPath:(NSString *)path defaultValue:(BOOL)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self st_boolForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self st_dictionaryForPaths:paths];
        return [obj st_boolForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (BOOL)st_boolForPath:(NSString *)path
{
    return [self st_boolForPath:path defaultValue:NO];
}

- (NSInteger)st_integerForPath:(NSString *)path defaultValue:(NSInteger)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self st_integerForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self st_dictionaryForPaths:paths];
        return [obj st_integerForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSInteger)st_integerForPath:(NSString *)path
{
    return [self st_integerForPath:path defaultValue:0];
}

- (NSUInteger)st_unsignedIntegerForPath:(NSString *)path defaultValue:(NSUInteger)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self st_unsignedIntegerForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self st_dictionaryForPaths:paths];
        return [obj st_unsignedIntegerForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSUInteger)st_unsignedIntegerForPath:(NSString *)path
{
    return [self st_unsignedIntegerForPath:path defaultValue:0];
}

- (char)st_charForPath:(NSString *)path defaultValue:(char)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self st_charForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self st_dictionaryForPaths:paths];
        return [obj st_charForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (char)st_charForPath:(NSString *)path
{
    return [self st_charForPath:path defaultValue:0];
}

- (unsigned char)st_unsignedCharForPath:(NSString *)path defaultValue:(unsigned char)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self st_unsignedCharForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self st_dictionaryForPaths:paths];
        return [obj st_unsignedCharForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (unsigned char)st_unsignedCharForPath:(NSString *)path
{
    return [self st_unsignedCharForPath:path defaultValue:0];
}

- (short)st_shortForPath:(NSString *)path defaultValue:(short)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self st_shortForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self st_dictionaryForPaths:paths];
        return [obj st_shortForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (short)st_shortForPath:(NSString *)path
{
    return [self st_shortForPath:path defaultValue:0];
}

- (unsigned short)st_unsignedShortForPath:(NSString *)path defaultValue:(unsigned short)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self st_unsignedShortForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self st_dictionaryForPaths:paths];
        return [obj st_unsignedShortForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (unsigned short)st_unsignedShortForPath:(NSString *)path
{
    return [self st_unsignedShortForPath:path defaultValue:0];
}

- (long)st_longForPath:(NSString *)path defaultValue:(long)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self st_longForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self st_dictionaryForPaths:paths];
        return [obj st_longForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (long)st_longForPath:(NSString *)path
{
    return [self st_longForPath:path defaultValue:0];
}

- (unsigned long)st_unsignedLongForPath:(NSString *)path defaultValue:(unsigned long)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self st_unsignedLongForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self st_dictionaryForPaths:paths];
        return [obj st_unsignedLongForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (unsigned long)st_unsignedLongForPath:(NSString *)path
{
    return [self st_unsignedLongForPath:path defaultValue:0];
}

- (long long)st_longLongForPath:(NSString *)path defaultValue:(long long)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self st_longLongForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self st_dictionaryForPaths:paths];
        return [obj st_longLongForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (long long)st_longLongForPath:(NSString *)path
{
    return [self st_longLongForPath:path defaultValue:0];
}

- (unsigned long long)st_unsignedLongLongForPath:(NSString *)path defaultValue:(unsigned long long)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self st_longLongForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self st_dictionaryForPaths:paths];
        return [obj st_unsignedLongLongForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (unsigned long long)st_unsignedLongLongForPath:(NSString *)path
{
    return [self st_unsignedLongLongForPath:path defaultValue:0];
}

- (int8_t)st_int8ForPath:(NSString *)path
{
    return [self st_charForPath:path];
}

- (int8_t)st_int8ForPath:(NSString *)path defaultValue:(int8_t)defaultValue
{
    return [self st_charForPath:path defaultValue:defaultValue];
}

- (uint8_t)st_uint8ForPath:(NSString *)path
{
    return [self st_unsignedCharForPath:path];
}

- (uint8_t)st_uint8ForPath:(NSString *)path defaultValue:(uint8_t)defaultValue
{
    return [self st_unsignedCharForPath:path defaultValue:defaultValue];
}

- (int16_t)st_int16ForPath:(NSString *)path
{
    return [self st_shortForPath:path];
}

- (int16_t)st_int16ForPath:(NSString *)path defaultValue:(int16_t)defaultValue
{
    return [self st_shortForPath:path defaultValue:defaultValue];
}

- (uint16_t)st_uint16ForPath:(NSString *)path
{
    return [self st_unsignedShortForPath:path];
}

- (uint16_t)st_uint16ForPath:(NSString *)path defaultValue:(uint16_t)defaultValue
{
    return [self st_unsignedShortForPath:path defaultValue:defaultValue];
}

- (int32_t)st_int32ForPath:(NSString *)path
{
    return (int32_t)[self st_longForPath:path];
}

- (int32_t)st_int32ForPath:(NSString *)path defaultValue:(int32_t)defaultValue
{
    return (int32_t)[self st_longForPath:path defaultValue:defaultValue];
}

- (uint32_t)st_uint32ForPath:(NSString *)path
{
    return (uint32_t)[self st_unsignedLongForPath:path];
}

- (uint32_t)st_uint32ForPath:(NSString *)path defaultValue:(uint32_t)defaultValue
{
    return (uint32_t)[self st_unsignedLongForPath:path defaultValue:defaultValue];
}

- (int64_t)st_int64ForPath:(NSString *)path
{
    return [self st_longLongForPath:path];
}

- (int64_t)st_int64ForPath:(NSString *)path defaultValue:(int64_t)defaultValue
{
    return [self st_longLongForPath:path defaultValue:defaultValue];
}

- (uint64_t)st_uint64ForPath:(NSString *)path
{
    return [self st_unsignedLongLongForPath:path];
}

- (uint64_t)st_uint64ForPath:(NSString *)path defaultValue:(uint64_t)defaultValue
{
    return [self st_unsignedLongLongForPath:path defaultValue:defaultValue];
}

- (float)st_floatForPath:(NSString *)path
{
    return [self st_floatForPath:path defaultValue:0];
}

- (float)st_floatForPath:(NSString *)path defaultValue:(float)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self st_floatForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self st_dictionaryForPaths:paths];
        return [obj st_floatForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (double)st_doubleForPath:(NSString *)path
{
    return [self st_doubleForPath:path defaultValue:0];
}

- (double)st_doubleForPath:(NSString *)path defaultValue:(double)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self st_doubleForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self st_dictionaryForPaths:paths];
        return [obj st_doubleForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSObject *)st_objectForPath:(NSString *)path defaultValue:(NSObject *)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self st_objectForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self st_dictionaryForPaths:paths];
        if (obj) {
            return [obj st_objectForKey:paths.lastObject];
        }
        
    }
    
    return defaultValue;
}

- (NSObject *)st_objectForPath:(NSString *)path
{
    return [self st_objectForPath:path defaultValue:nil];
}

- (NSString *)st_stringForPath:(NSString *)path defaultValue:(NSString *)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self st_stringForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self st_dictionaryForPaths:paths];
        if (obj) { //@@by Robin
            return [obj st_stringForKey:paths.lastObject];
        }
        //@step
        return defaultValue;
    }
    
    return defaultValue;
}

- (NSString *)st_stringForPath:(NSString *)path
{
    return [self st_stringForPath:path defaultValue:nil];
}

- (NSArray *)st_arrayForPath:(NSString *)path defaultValue:(NSArray *)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self st_arrayForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self st_dictionaryForPaths:paths];
        if (obj) {
            return [obj st_arrayForKey:paths.lastObject];
        }
        return defaultValue;
    }
    
    return defaultValue;
}

- (NSArray *)st_arrayForPath:(NSString *)path
{
    return [self st_arrayForPath:path defaultValue:nil];
}

- (NSDictionary *)st_dictionaryForPath:(NSString *)path defaultValue:(NSDictionary *)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self st_dictionaryForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self st_dictionaryForPaths:paths];
        return [obj st_dictionaryForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSDictionary *)st_dictionaryForPath:(NSString *)path
{
    return [self st_dictionaryForPath:path defaultValue:nil];
}

- (NSDate *)st_dateForPath:(NSString *)path defaultValue:(NSDate *)defaultValue {
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self st_dateForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self st_dictionaryForPaths:paths];
        return [obj st_dateForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSDate *)st_dateForPath:(NSString *)path {
    return [self st_dateForPath:path defaultValue:nil];
}

- (NSData *)st_dataForPath:(NSString *)path defaultValue:(NSData *)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self st_dataForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self st_dictionaryForPaths:paths];
        return [obj st_dataForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSData *)st_dataForPath:(NSString *)path
{
    return [self st_dataForPath:path defaultValue:nil];
}

- (NSURL *)st_URLForPath:(NSString *)path defaultValue:(NSURL *)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self st_URLForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self st_dictionaryForPaths:paths];
        return [obj st_URLForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSURL *)st_URLForPath:(NSString *)path
{
    return [self st_URLForPath:path defaultValue:nil];
}

@end
