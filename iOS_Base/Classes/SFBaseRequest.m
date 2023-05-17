//
//  SFBaseRequest.m
//  iOS_Base_Example
//
//  Created by shefeng on 2023/5/15.
//  Copyright © 2023 shefeng. All rights reserved.
//

#import "SFBaseRequest.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "SFWeakStrong.h"

@implementation SFBaseRequest

//获取AFHTTPSessionManager
+ (AFHTTPSessionManager *)getSessionManager:(SFContentType)contentType {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFSecurityPolicy *securityPolicy =  [AFSecurityPolicy defaultPolicy];
    // 客户端是否信任非法证书
    securityPolicy.allowInvalidCertificates = YES;
    // 是否在证书域字段中验证域名
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    if (contentType == SFContentTypeJson) {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    } else {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"image/jpeg",@"image/png",@"text/plain",@"application/json",nil];
    
    return manager;
}

/**
 *  POST
 *  @param url                                  请求地址
 *  @param params                           请求参数
 *  @param contentType                Content-Type
 *  @param dataClass                    data类名称
 *  @param completionBlock       完成的block
 */
+ (void)POST:(NSString *)url params:(NSDictionary * _Nullable)params contentType:(SFContentType)contentType dataClass:(Class)dataClass completionBlock:(void(^)(NSInteger code,id data,NSString *msg))completionBlock{
    AFHTTPSessionManager *manager = [self getSessionManager:contentType];
    
    @weakify(self)
    [manager POST:url parameters:params headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(),^(){
            @strongify(self)
            [self handleResponse:responseObject dataClass:dataClass completionBlock:completionBlock];
            
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(),^(){
            completionBlock(500,nil,error.localizedDescription);
        });
    }];
}

/**
 *  GET
 *  @param url                                  请求地址
 *  @param params                           请求参数
 *  @param contentType                Content-Type
 *  @param dataClass                    data类名称
 *  @param completionBlock       完成的block
 */
+ (void)GET:(NSString *)url params:(NSDictionary * _Nullable)params contentType:(SFContentType)contentType dataClass:(Class)dataClass completionBlock:(void(^)(NSInteger code,id data,NSString *msg))completionBlock{
    AFHTTPSessionManager *manager = [self getSessionManager:contentType];
    
    @weakify(self)
    [manager GET:url parameters:params headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(),^(){
            @strongify(self)
            [self handleResponse:responseObject dataClass:dataClass completionBlock:completionBlock];
            
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(),^(){
            completionBlock(500,nil,error.localizedDescription);
        });
    }];
}

//处理响应
+ (void)handleResponse:(id)responseObject dataClass:(Class)dataClass completionBlock:(void(^)(NSInteger code,id data,NSString *msg))completionBlock{
    if(responseObject == nil) {
        completionBlock(500, nil, @"无数据返回");
        return;
    }
    
    if(responseObject == [NSNull null]) {
        completionBlock(500, nil, @"无数据返回");
        return;
    }
    
    NSDictionary *response = [self getResponseDict:responseObject];
    
    if(response == nil){
        completionBlock(500, nil, @"数据格式不正确");
        return;
    }
    
    if([response.allKeys containsObject:@"code"]
       && [response.allKeys containsObject:@"data"]
       && [response.allKeys containsObject:@"msg"]) {
        NSInteger code = [response[@"code"] integerValue];
        id data = response[@"data"];
        NSString *msg = response[@"msg"];
        
        if([data isKindOfClass:[NSDictionary class]]){
            completionBlock(code,[dataClass mj_objectWithKeyValues:data],msg);
        }else if([data isKindOfClass:[NSArray class]]){
            completionBlock(code,[dataClass mj_objectArrayWithKeyValuesArray:data],msg);
        }else if([data isKindOfClass:[NSString class]]){
            completionBlock(code,(NSString *)data,msg);
        }else if([data isKindOfClass:[NSNumber class]]){
            completionBlock(code,(NSNumber *)data,msg);
        }else{
            completionBlock(code,data,msg);
        }
    }else{
        completionBlock(500, nil, @"数据格式不正确");
    }
}

+ (NSDictionary *)getResponseDict:(id)responseObj{
    NSDictionary *result = nil;
    
    if ([responseObj isKindOfClass:[NSDictionary class]]) {
        result = (NSDictionary *)responseObj;
    } else if ([responseObj isKindOfClass:[NSString class]]) {
        NSString *responseStr = (NSString *)responseObj;
        NSData *responseData = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
    } else if ([responseObj isKindOfClass:[NSData class]]) {
        NSData *responseData = (NSData *)responseObj;
        result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
    }
    
    return result;
}

@end
