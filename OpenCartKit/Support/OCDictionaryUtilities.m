//
//  OCDictionaryUtilities.m
//
//

#import "OCDictionaryUtilities.h"

NSDictionary * OCDictionaryByMergingDictionaryWithDictionary(NSDictionary *dict1, NSDictionary *dict2)
{
    if (! dict1) return dict2;
    if (! dict2) return dict1;

    NSMutableDictionary *mergedDictionary = [dict1 mutableCopy];

    [dict2 enumerateKeysAndObjectsUsingBlock:^(id key2, id obj2, BOOL *stop) {
        id obj1 = [dict1 valueForKey:key2];
        if ([obj1 isKindOfClass:[NSDictionary class]] && [obj2 isKindOfClass:[NSDictionary class]]) {
            NSDictionary *mergedSubdict = OCDictionaryByMergingDictionaryWithDictionary(obj1, obj2);
            [mergedDictionary setValue:mergedSubdict forKey:key2];
        } else {
            [mergedDictionary setValue:obj2 forKey:key2];
        }
    }];
    
    return [mergedDictionary copy];
}

NSDictionary * OCDictionaryByReplacingPercentEscapesInEntriesFromDictionary(NSDictionary *dictionary)
{
    NSMutableDictionary *results = [NSMutableDictionary dictionaryWithCapacity:[dictionary count]];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop)
     {
         NSString *escapedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
         id escapedValue = value;
         if ([value respondsToSelector:@selector(stringByReplacingPercentEscapesUsingEncoding:)])
             escapedValue = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
         [results setObject:escapedValue forKey:escapedKey];
     }];
    return results;
}

/*
 *
 */

NSDictionary * _OCDictionaryWithVariableBindings(NSString *listKey, ... )
{
    listKey = [[listKey componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \n\t"]] componentsJoinedByString:@""];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    id obj;
    va_list marker;
    
    va_start( marker, listKey ); /* Initialize variable arguments. */
    NSArray *array = [listKey componentsSeparatedByString:@","];
    for (NSString *key in array) {
        obj = va_arg( marker, id);
        obj = obj?obj:@"";
        [dictionary setObject:obj forKey:key];
    }
    
    va_end( marker ); /* Reset variable arguments. */
    
    return dictionary;
    
}


/*
 * construct NSDictionary attach json =1 | NSDictionaryOfVariableBindings
 */
NSDictionary * _OCNSDictionaryOfParametersBindingsJson(NSString *listKey, ... )
{
    listKey = [[listKey componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \n\t"]] componentsJoinedByString:@""];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    id obj;
    va_list marker;
    
    va_start( marker, listKey ); /* Initialize variable arguments. */
    NSArray *array = [listKey componentsSeparatedByString:@","];
    for (NSString *key in array) {
        obj = va_arg( marker, id);
        obj = obj?obj:@"";
        [dictionary setObject:obj forKey:key];
    }
    
    va_end( marker ); /* Reset variable arguments. */
    
    [dictionary setObject:@"1" forKey:@"json"];
    
    return dictionary;
    
}


/*
 *
 */
BOOL  OCIsValidateDictionary (NSDictionary* value){
    BOOL result = ( value && [value isKindOfClass:[NSDictionary class]]);
    return result;
}
