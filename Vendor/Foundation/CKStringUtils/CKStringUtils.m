//
//  CKStringUtils.m
//  CKStringUtils
//
//  Created by Cody Kimberling on 12/14/13.
//  Copyright (c) 2013 Cody Kimberling. All rights reserved.
//

#import "CKStringUtils.h"

static NSString *kEmailRegex = @"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";

@implementation CKStringUtils

#pragma mark - isNil:

+ (BOOL)isNil:(NSString *)string
{
    return (string == nil) || (string == (id)NSNull.null);
}

#pragma mark - isNil:

+ (BOOL)isNotNil:(NSString *)string
{
    return ![self isNil:string];
}

#pragma mark - isEmpty:

+ (BOOL)isEmpty:(NSString *)string
{
    if ([self isNil:string]) {
        return YES;
    }
    
    return ([self isString:string] && string.length == 0);
}

#pragma mark - isNotEmpty:

+ (BOOL)isNotEmpty:(NSString *)string
{
    return ![self isEmpty:string];
}

#pragma mark - isBlank:

+ (BOOL)isBlank:(NSString *)string
{
    if ([self isEmpty:string]) {
        return YES;
    }
    return ([self isString:string] && [self isEmpty:[self stringWithWhitespacesStripped:string]]);
}

#pragma mark - isNotBlank:

+ (BOOL)isNotBlank:(NSString *)string
{
    return ![self isBlank:string];
}

#pragma mark - isAllLowerCase:

+ (BOOL)isAllLowerCase:(NSString *)string
{
    return (![CKStringUtils isString:string] || [CKStringUtils isBlank:string]) ? NO : ([string rangeOfCharacterFromSet:self.lowerCaseInvertedSet].location == NSNotFound);
}

#pragma mark - isAllUpperCase:

+ (BOOL)isAllUpperCase:(NSString *)string
{
    return (![CKStringUtils isString:string] || [CKStringUtils isBlank:string]) ? NO : ([string rangeOfCharacterFromSet:self.upperCaseInvertedSet].location == NSNotFound);
}

#pragma mark - isAlpha:

+ (BOOL)isAlpha:(NSString *)string
{
    return (![CKStringUtils isString:string] || [CKStringUtils isBlank:string]) ? NO : ([string rangeOfCharacterFromSet:self.lowerAndUpperCaseInvertedSet].location == NSNotFound);
}

#pragma mark - isNumeric:

+ (BOOL)isNumeric:(NSString *)string
{
    return (![CKStringUtils isString:string] || [CKStringUtils isBlank:string]) ? NO : ([string rangeOfCharacterFromSet:self.decimalDigitInvertedCharacterSet].location == NSNotFound);
}

#pragma mark - isAlphanumeric:

+ (BOOL)isAlphaNumeric:(NSString *)string
{
    return (![CKStringUtils isString:string] || [CKStringUtils isBlank:string]) ? NO : ([string rangeOfCharacterFromSet:self.alphaNumericInvertedCharacterSet].location == NSNotFound);
}

#pragma mark - string: containsString:

+ (BOOL)string:(NSString *)string containsString:(NSString *)searchString ignoreCase:(BOOL)ignoreCase
{
    if([self isNil:string] && [self isNil:searchString]){
        return YES;
    }
    
    if([self isNil:string] || [self isNil:searchString]){
        return NO;
    }
    
    if ([CKStringUtils isString:string] && [CKStringUtils isString:searchString]) {
        NSString *stringToSearch = (ignoreCase) ? string.lowercaseString : string;
        NSString *queryString = (ignoreCase) ? searchString.lowercaseString : searchString;
        
        return !([stringToSearch rangeOfString:queryString].location == NSNotFound);
    }
    return NO;
}

#pragma mark - string: doesNotContainString:

+ (BOOL)string:(NSString *)string doesNotContainString:(NSString *)searchString ignoreCase:(BOOL)ignoreCase
{
    return ![self string:string containsString:searchString ignoreCase:ignoreCase];
}

#pragma mark - string: equalsString: ignoreCase:

+ (BOOL)string:(NSString *)string1 equalsString:(NSString *)string2 ignoreCase:(BOOL)ignoreCase
{
    if(string1 == string2){
        return YES;
    }
    
    if(string1 == (id)NSNull.null || string2 == (id)NSNull.null){
        return NO;
    }
    
    if (![CKStringUtils isString:string1] || ![CKStringUtils isString:string2]) {
        return NO;
    }
    
    return ignoreCase ? [string1.lowercaseString isEqualToString:string2.lowercaseString] : [string1 isEqualToString:string2];
}

#pragma mark - defaultString: forString:

+ (NSString *)defaultString:(NSString *)defaultString forString:(NSString *)string
{
    if ([self isNil:string]) {
        return [self isString:defaultString] ? defaultString : @"";
    }
    
    return ![self isString:string] ? @"" : string;
}

#pragma mark - defaultStringIfEmpty: forString:

+ (NSString *)defaultStringIfEmpty:(NSString *)defaultString forString:(NSString *)string
{
    if ([self isEmpty:string]) {
        return [self isString:defaultString] ? defaultString : @"";
    }
    
    return ![self isString:string] ? @"" : string;
}

#pragma mark - defaultStringIfBlank: forString:

+ (NSString *)defaultStringIfBlank:(NSString *)defaultString forString:(NSString *)string
{
    if ([self isBlank:string]) {
        return [self isString:defaultString] ? defaultString : @"";
    }
    
    return ![self isString:string] ? @"" : string;
}

#pragma mark - abbreviate: maxWidth:

+ (NSString *)abbreviate:(NSString *)string maxWidth:(int)maxWidth
{
    NSString *ellipses = @"...";
    
    if([self isNil:string]){
        return nil;
    }
    
    if (![self isString:string]) {
        return @"";
    }
    
    if([self isEmpty:string]){
        return @"";
    }
    
    if(maxWidth <= ellipses.length){
        return string;
    }
    
    if(string.length > maxWidth){
        NSString *abbreviatedString = [string substringToIndex:(maxWidth - ellipses.length)];
        return [NSString stringWithFormat:@"%@%@", abbreviatedString, ellipses];
    }
    return string;
}

#pragma mark - Helpers

+ (NSString *)stringWithWhitespacesStripped:(NSString *)string
{
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}

+ (NSCharacterSet *)lowerCaseInvertedSet
{
    return [NSCharacterSet.lowercaseLetterCharacterSet invertedSet];
}

+ (NSCharacterSet *)upperCaseInvertedSet
{
    return  [NSCharacterSet.uppercaseLetterCharacterSet invertedSet];
}

+ (NSCharacterSet *)lowerCaseSet
{
    return NSCharacterSet.lowercaseLetterCharacterSet;
}

+ (NSCharacterSet *)upperCaseSet
{
    return  NSCharacterSet.uppercaseLetterCharacterSet;
}

+ (NSCharacterSet *)lowerAndUpperCaseSet
{
    NSMutableCharacterSet *lowerAndUpperSet = self.lowerCaseSet.mutableCopy;
    [lowerAndUpperSet formUnionWithCharacterSet:self.upperCaseSet];
    
    return lowerAndUpperSet;
}

+ (NSCharacterSet *)lowerAndUpperCaseInvertedSet
{
    return [self.lowerAndUpperCaseSet invertedSet];
}

+ (NSCharacterSet *)decimalDigitCharacterSet
{
    return  NSCharacterSet.decimalDigitCharacterSet;
}

+ (NSCharacterSet *)decimalDigitInvertedCharacterSet
{
    return  [NSCharacterSet.decimalDigitCharacterSet invertedSet];
}

+ (NSCharacterSet *)alphaNumericCharacterSet
{
    NSMutableCharacterSet *alphaNumericSet = self.lowerAndUpperCaseSet.mutableCopy;
    [alphaNumericSet formUnionWithCharacterSet:self.decimalDigitCharacterSet];
    
    return alphaNumericSet;
}

+ (NSCharacterSet *)alphaNumericInvertedCharacterSet
{
    return [self.alphaNumericCharacterSet invertedSet];
}

#pragma mark - isValidEmailAddress:

+ (BOOL)isValidEmailAddress:(NSString *)emailAddress
{
    if([self isEmpty:emailAddress] || ![self isString:emailAddress]){
        return NO;
    }
    
    NSString *lowerCaseEmailAddress = emailAddress.lowercaseString;
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", kEmailRegex];
    return [emailTest evaluateWithObject:lowerCaseEmailAddress];
}

#pragma mark stringByTrimmingLeadingWhitespaceCharactersInString:

+ (NSString *)stringByTrimmingLeadingWhitespaceCharactersInString:(NSString *)string
{
    if (![self isString:string]) {
        return @"";
    }
    
    if([self isBlank:string]){
        return string;
    }
    
    NSRange rangeOfFirstWantedCharacter = [string rangeOfCharacterFromSet:[NSCharacterSet.whitespaceCharacterSet invertedSet]];
    return (rangeOfFirstWantedCharacter.location == NSNotFound) ? string : [string substringFromIndex:rangeOfFirstWantedCharacter.location];
}

#pragma mark stringByTrimmingTrailingWhitespaceCharactersInString

+ (NSString *)stringByTrimmingTrailingWhitespaceCharactersInString:(NSString *)string
{
    if (![self isString:string]) {
        return @"";
    }
    
    if([self isBlank:string]){
        return string;
    }
    
    NSRange rangeOfLastWantedCharacter = [string rangeOfCharacterFromSet:[NSCharacterSet.whitespaceCharacterSet invertedSet]
                                                                 options:NSBackwardsSearch];
    return (rangeOfLastWantedCharacter.location == NSNotFound) ? string : [string substringToIndex:rangeOfLastWantedCharacter.location+1];
}

#pragma mark stringByTrimmingLeadingAndTrailingWhitespaceCharactersInString:

+ (NSString *)stringByTrimmingLeadingAndTrailingWhitespaceCharactersInString:(NSString *)string
{
    NSString *leadingWhitespaceTrimmedString = [self stringByTrimmingLeadingWhitespaceCharactersInString:string];
    return [self stringByTrimmingTrailingWhitespaceCharactersInString:leadingWhitespaceTrimmedString];
}

#pragma mark stringByUrlEscapingString:

+ (NSString *)stringByUrlEscapingString:(NSString *)string
{
    if([CKStringUtils isBlank:string] || ![self isString:string]){
        return [self isString:string] ? string : @"";
    }
    
    return [self doesStringContainIllegalUrlCharacters:string] ? [self stringByUrlEncodingString:string] : string;
}

#pragma mark - Helpers

+ (NSString *)stringByUrlEncodingString:(NSString *)string
{
    return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)(string),
                                                                     NULL, (__bridge CFStringRef)self.illegalCharaterSet, kCFStringEncodingUTF8));
}

+ (BOOL)doesStringContainIllegalUrlCharacters:(NSString *)string
{
    return ([string rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:self.illegalCharaterSet]].location != NSNotFound);
}

+ (NSString *)illegalCharaterSet
{
    return @"!*'();:@&=+@,/?#[]";
}

+ (BOOL)isString:(id)obj
{
    return [obj isKindOfClass:[NSString class]];
}

#pragma -mark
#pragma 

+ (NSString *)safeString:(NSString*)string  {
    if ([CKStringUtils isNil:string]) {
        return [CKStringUtils safeString:string defaultValue:@""];
    }
    return string;
}

+ (NSString *)safeString:(NSString*)string  defaultValue:(NSString*)defaultValue{
    if ([CKStringUtils isNil:string]) {
        return defaultValue;
    }
    return string;
}

+ (NSString *)decodeUTF8String:(NSString*)value{
    if (nil == value) {
        return value;
    }
    NSString *result = [NSString
                       stringWithCString:[value cStringUsingEncoding:NSUTF8StringEncoding]
                       encoding:NSNonLossyASCIIStringEncoding];
    return result;
}
@end