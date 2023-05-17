//
//  SFBaseRequest.h
//  iOS_Base_Example
//
//  Created by shefeng on 2023/5/15.
//  Copyright © 2023 shefeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define SFApplicationJson @"application/json"
#define SFApplicationXWwwFormUrlencoded @"application/x-www-form-urlencoded"

typedef NS_ENUM(NSInteger,SFContentType){
    SFContentTypeForm= 0,   //application/x-www-form-urlencoded
    SFContentTypeJson = 1,  //application/json
};

@interface SFBaseRequest : NSObject

/**
 *  POST
 *  @param url                                  请求地址
 *  @param params                           请求参数
 *  @param contentType                Content-Type
 *  @param dataClass                    data类名称
 *  @param completionBlock       完成的block
 */
+ (void)POST:(NSString *)url params:(NSDictionary * _Nullable)params contentType:(SFContentType)contentType dataClass:(Class)dataClass completionBlock:(void(^)(NSInteger code,id data,NSString *msg))completionBlock;

/**
 *  GET
 *  @param url                                  请求地址
 *  @param params                           请求参数
 *  @param contentType                Content-Type
 *  @param dataClass                    data类名称
 *  @param completionBlock       完成的block
 */
+ (void)GET:(NSString *)url params:(NSDictionary * _Nullable)params contentType:(SFContentType)contentType dataClass:(Class)dataClass completionBlock:(void(^)(NSInteger code,id data,NSString *msg))completionBlock;

@end

NS_ASSUME_NONNULL_END
