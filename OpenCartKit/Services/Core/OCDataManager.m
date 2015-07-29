//
//  OCDataManager.m
//  OpencartKit
//
//  Created by icoco7 on 6/21/15.
//  Copyright (c) 2015 i2Cart. All rights reserved.
//

#import "OCDataManager.h"
#import <AFURLRequestSerialization.h>
#import <AFNetworkActivityIndicatorManager.h>
#import "OCWebService.h"
#import "AppResource.h"



NSString *const kOCAuthorizedToekn =@"OCAuthorizedToekn";

@interface OCDataManager (){
    AFHTTPRequestOperationManager * _operator;
    
    NSString* _token;
}
@end

@implementation OCDataManager

+ (instancetype)sharedInstance {
    static OCDataManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[self alloc] init];
        
        [_instance setupWorkspace];

    });
    
    return _instance;
}

- (AFHTTPRequestOperationManager*) getRequestOperator{
    if (nil == _operator) {
        _operator = [AFHTTPRequestOperationManager manager];
    }
    return _operator;
}

- (void)setupJsonMode:(AFHTTPRequestOperationManager*) operator{
    operator.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    operator.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operator.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    
   // [operator.requestSerializer setValue:@"application/json; charset=utf-8"forHTTPHeaderField:@"Content-Type"];
}

- (void)setupWorkspace{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [self setupJsonMode:[self getRequestOperator]];
}


- (void)setHeader:(AFHTTPRequestOperationManager*)operator header:(NSDictionary*)header{
    if (nil == header) {
        return;
    }
    [header enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [operator.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
}

+ (void)handleSucessResponse:(AFHTTPRequestOperation *)operation response:(id) response success:(OCInvokeSuccessBlock)success successFilter:(OCFilterBlock)successFilter failure:(OCInvokeFailureBlock)failure{
    NSLog(@"handleSucessResponse->operation:[%@],\n JSON:[%@]", operation, response);
    NSException* exception = nil;// [OCWebService dataExceptionWithResponse:response];
    
    if (nil != exception) {
        //@step
        response = exception;
    }
    
    if (successFilter) {
        NSLog(@"successFilter->before JSON: %@", response);
        response = successFilter(response);
        NSLog(@"successFilter->done JSON: %@", response);
    }
    
    success(response);
}

+ (void)handleFailureResponse:(AFHTTPRequestOperation *)operation error:(NSError *)error failure:(OCInvokeFailureBlock)failure{
   
    NSString *buf = [[NSString alloc] initWithData:operation.responseData  encoding:NSUTF8StringEncoding];
    NSLog(@"handleFailureResponse->operation:[%@],\nreponse:[%@],\n error:[%@]", operation,buf, error);
    
    failure( error);
}


- (void)POST:(NSString*)url  params:(NSDictionary*)params  success:(OCInvokeSuccessBlock)success successFilter:(OCFilterBlock)successFilter failure:(OCInvokeFailureBlock)failure {
    
    [_operator POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [OCDataManager handleSucessResponse:operation response:responseObject success:success successFilter:successFilter failure:failure];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [OCDataManager handleFailureResponse:operation error:error failure:failure];
    }];
    
    
}

- (void)GET:(NSString*)url params:(NSDictionary*)params  success:(OCInvokeSuccessBlock)success successFilter:(OCFilterBlock)successFilter failure:(OCInvokeFailureBlock)failure {
    
    [_operator GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [OCDataManager handleSucessResponse:operation response:responseObject success:success successFilter:successFilter failure:failure];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [OCDataManager handleFailureResponse:operation error:error failure:failure];
    }];
}


- (void)request:(NSString*)url method:(NSString*)method params:(NSDictionary*)params  success:(OCInvokeSuccessBlock)success successFilter:(OCFilterBlock)successFilter failure:(OCInvokeFailureBlock)failure {
    
    NSLog(@"url:%@, param:%@",url, params);
    if ([@"POST" isEqualToString:method]) {
        [self POST:url params:params success:success successFilter:successFilter failure:failure];
        return;
    }
    if ([@"GET" isEqualToString:method]) {
        [self GET:url params:params success:success successFilter:successFilter failure:failure];
        return;
    }
    
}

- (void)request:(NSString*)url method:(NSString*)method params:(NSDictionary*)params header:(NSDictionary*)header success:(OCInvokeSuccessBlock)success successFilter:(OCFilterBlock)successFilter failure:(OCInvokeFailureBlock)failure {
    if (nil != header) {
        [self setHeader:_operator header:header];
        NSLog(@"header:[%@]",header);
    }
    //@step
    [self request:url method:method params:params  success:success  successFilter:successFilter failure:failure];
}

#pragma mark
#pragma mark -invokeService
- (void)invokeService:(OCWebService*)service{
    [self invokeService:service success:^(id response) {
        if (service.delegate && [service.delegate respondsToSelector:@selector(onSuccess:response:) ]){
            [service.delegate onSuccess:service response:response];
        }
    } failure:^(NSError *error) {
        if (service.delegate && [service.delegate respondsToSelector:@selector(onFailure:error:) ]){
            [service.delegate onFailure:service error:error];
        }
    }];
}

- (void)invokeService:(OCWebService*)service success:(OCInvokeSuccessBlock)success failure:(OCInvokeFailureBlock)failure {
    
    NSString* url = [service getUrl];
    NSDictionary* params = service.parameters;
    NSDictionary* header = service.header;
    OCFilterBlock successFilter = service.successFilter;
    NSString* method = service.method;
    
    [self request:url method:method params:params header: header success:success successFilter: successFilter failure:failure];
}


#pragma mark
#pragma mark -User Token

- (void)setUserToken:(NSString*)value{
    _token = value;
    AppResourceSet(kOCAuthorizedToekn, _token);
}

- (NSString*)getUserToken{
    if (nil ==_token) {
        _token = (NSString*)AppResourceGet(kOCAuthorizedToekn, _token);
    }
    return _token;
}

@end
