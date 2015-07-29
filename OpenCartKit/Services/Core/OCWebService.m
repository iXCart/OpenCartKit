//
//  OCWebService.m
//  OpencartKit
//
//  Created by icoco7 on 6/21/15.
//  Copyright (c) 2015 i2Cart. All rights reserved.
//

#import "OCWebService.h"
#import "RKURLEncodedSerialization.h"
#import "NSDictionary+OCHelper.h"
#import "CKStringUtils.h"

#import "OCDataManager.h"
#import "OCDataException.h"

#import "OCWebServiceConfig.h"

@interface OCWebService (){
    NSString* _version;
}
@end

@implementation OCWebService
@synthesize serviceId;
@synthesize route;
@synthesize header;
@synthesize method;
@synthesize parameters;

@synthesize delegate;

-(id)init {
    if (self = [super init])  {
        self.method = @"GET";
        self.route = @"";
        _version = [OCWebServiceConfig sharedInstance].version;
    }
    return self;
}

- (BOOL)isVersion2Plus{
    if ([CKStringUtils isEmpty:_version]) {
        return true;
    }
    int i = [_version intValue];
    return i > 1;
}

- (NSString*)getUrl{
    
    NSString* root = [OCWebServiceConfig sharedInstance].apiRootUrl;
    NSString* appInfo = [self getAppInfo];
    NSString* queryString = RKPercentEscapedQueryStringFromStringWithEncoding(appInfo,NSUTF8StringEncoding);
    NSString* url = [NSString stringWithFormat:@"%@/index.php?route=%@&%@",root,self.route, queryString];
    
    return url;
}


- (NSString*)getAppInfo{
    //TODO
    return @"client=ios";
}

- (void)generateSerivceId{
    
}

- (void)setParameters:(NSDictionary *)value{
    parameters = value;
    
    [self generateSerivceId];
}

 

/*
 *  base64  encode
 */
+ (NSDictionary*)encodeAuthorizeLoginInfo:(NSString*)user password:(NSString*)password{
    NSString *str = [NSString stringWithFormat:@"%@:%@:1", user, password];
    NSString *base64 = [[str dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    NSDictionary *dict = @{@"Authorization":[@"Base " stringByAppendingString:base64]};
    return dict;
}

/*
 *
 *  Header   Authorization= Token 8f8d957b60de3401e44821553b978107
 */
+ (NSDictionary*)encodeAuthorizeTokenInfo:(NSString*)token{
    NSString *str = [NSString stringWithFormat:@"%@",token];
    
    NSDictionary *dict = @{@"Authorization":[@"Token " stringByAppendingString:str]};
    return dict;
}

+ (NSDictionary*)encodedAuthorizeTokenInfo{
    
    NSString* token = [[OCDataManager sharedInstance]getUserToken];
    return [OCWebService encodeAuthorizeTokenInfo:token];
}




+ (BOOL)isSuccessOperation:(id)response{
    if (nil == response) {
        return false;
    }
    if ([response isKindOfClass:[NSDictionary class]]
        || [response isKindOfClass:[NSArray class]] ) {
        return true;
    }
    return false;
}

+ (NSException *)dataExceptionWithResponse:(id)response{
    
    if ([OCWebService isSuccessOperation:response]) {
        return nil;
    }
  
    NSString* msg = (NSString*)response;
    msg = [CKStringUtils safeString:msg defaultValue:OCExceptionDomain];
    //@ msg = [CKStringUtils decodeUTF8String:msg];
    
    OCDataException* exception = [OCDataException exceptionWithCode: 0 name:OCExceptionDomain reason:msg userInfo:nil];
    
    return  exception;
    
}


- (void)execute{
    
    [[OCDataManager sharedInstance] invokeService:self];
}

/*
 * set the success block and failure block directly
 */
- (void)execute:(OCInvokeSuccessBlock)success failure:(OCInvokeFailureBlock)failure {
    [[OCDataManager sharedInstance] invokeService:self success:success failure:failure];
}

- (void)dealloc{
    
    serviceId = nil;
    self.header = nil;
    self.method = nil;
    self.route = nil;
    self.parameters = nil;
    self.successFilter = nil;
    NSLog(@"dealloc %@", self);
}


@end
