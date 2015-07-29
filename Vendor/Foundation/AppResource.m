//
//  AppResource.m
//  icoco
//
//  Created by icoco on 22/07/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "AppResource.h"


NSString*  AppLocalizedString(NSString* key)
{
    NSString* value = [[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil];
    
    if ( nil == value)
        return nil;
    
    return value;
}

NSString*  AppLocalizedStringWithDefaultValue(NSString* key,NSString* defaultValue)
{
    NSString* value = [[NSBundle mainBundle] localizedStringForKey:(key) value:defaultValue table:nil];
    
    if ( nil == value)
        return defaultValue;
    
    return value;
}

#pragma mark get array from comma localizedString
NSArray*  AppLocalizedStringArray(NSString* key)
{
	NSString* value = [[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil];
	
	if ( nil == value)
		return nil;
	
	return [value  componentsSeparatedByString: @","]; 
}




//////////////////////////////////////////////////////////////////
#pragma mark 
NSObject *AppResourceGet( NSString* aKey, NSObject* defaultValue)
{ 
	NSString * key = (NSString* )aKey;
	
	NSUserDefaults* settings = [NSUserDefaults standardUserDefaults];
    
	NSObject* value = (NSObject*)[settings objectForKey: key];
	if ( nil == value && nil != defaultValue)
	{
        
		[settings setObject:defaultValue forKey:key];
		value = defaultValue;
        NSLog(@"Set default key=[%@],value=[%@]", key, value );
	}
	NSLog(@"Get key=[%@],value=[%@]", key, value );
	
	return value;
	
}
NSObject *AppResourceSet(const NSString* aKey,    NSObject* value)
{
	NSString * key = (NSString* )aKey;
	NSUserDefaults* settings = [NSUserDefaults standardUserDefaults];
    if (nil == value) {
        [settings removeObjectForKey:key];
    }else{
        [settings setObject:value forKey:key];
    }
    
	[settings synchronize];
	NSLog(@"Set key=[%@],value=[%@]", key, value );
	return value;
	
}
//////////////////////////////////////////////////////////////////

static AppResource *  appResInstance = nil;

@implementation AppResource

+(AppResource*) sharedInstance
{
	@synchronized(self)
	{
		if ( nil == appResInstance)
		{
			appResInstance = [[AppResource alloc ] init];
			
			//autorelease
			
		}
	}
	return appResInstance;
}

 
@end
