//
//  OCDeviceUtilties.m
//  icoco
//
//  Created by icoco on 6/5/15.
//  Copyright (c) 2015 icoco. All rights reserved.
//

#import "OCDeviceUtilties.h"
#import <UIKit/UIKit.h>
#import "SSKeychain.h"
#import "Lang.h"

@implementation OCDeviceUtilties


+ (NSString *)getUniqueDeviceIdentifierAsString{

    NSString *appName=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    
    NSString *strApplicationUUID = [SSKeychain passwordForService:appName account:@"incoding"];
    if (strApplicationUUID == nil)
    {
        strApplicationUUID  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [SSKeychain setPassword:strApplicationUUID forService:appName account:@"incoding"];
    }
    
    return strApplicationUUID;
}


+ (NSString*)getDeviceId{
    
    return [OCDeviceUtilties getUniqueDeviceIdentifierAsString];
    
}

+ (NSString* )getDeviceInfo{
    NSString* result = @"";
    
    UIDevice* device =  [UIDevice currentDevice];
    NSString* item = StringWithFormat (@"name: %@\n",device.name);
    result = StringJoin(result, item);
    
    item = StringWithFormat (@"systemName: %@\n",device.systemName);
    result = StringJoin(result, item);
    
    item = StringWithFormat (@"systemVersion: %@\n",device.systemVersion);
    result = StringJoin(result, item);
    
    item = StringWithFormat (@"localizedModel: %@\n",device.localizedModel);
    result = StringJoin(result, item);
    
    item =  [NSString stringWithFormat:@"identifierForVendor: %@\n",device.identifierForVendor];
    result = StringJoin(result, item);
    
    item = [NSString stringWithFormat:@"batteryLevel: %f\n",device.batteryLevel];
    result = StringJoin(result, item);
    
    item =  [NSString stringWithFormat:@"batteryState: %ld\n",device.batteryState];
    result = StringJoin(result, item);
    
    item =  [NSString stringWithFormat: @"orientation: %ld\n", device.orientation ];
    result = StringJoin(result, item);
    
    item = StringWithFormat (@"*** App Version = %@\n",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]);
    result = StringJoin(result, item);
    
    return result;
    
}


@end
