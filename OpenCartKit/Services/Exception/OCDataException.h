//
//  OCDataException.h
//  OpencartKit
//
//  Created by icoco7 on 6/21/15.
//  Copyright (c) 2015 i2Cart. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const OCExceptionDomain;


@interface OCDataException : NSException{
@private
    int		 code;

}
@property (readonly, assign) int  code;


+ (OCDataException *)exceptionWithCode:(int)code name:(NSString *)name reason:(NSString *)reason userInfo:(NSDictionary *)userInfo;

@end
