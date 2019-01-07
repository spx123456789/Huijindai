//
//  HJDNetAPIManager2.h
//  HuiJinDai
//
//  Created by GXW on 2018/9/27.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef NS_ENUM(NSUInteger, NetworkMethod2) {
    GET2 = 0,  // get请求
    POST2,     // post请求
    PUT2,
    DELETE2
};

@interface HJDNetAPIManager2 : AFHTTPSessionManager

+ (instancetype)sharedManager;

/**
 *  设置accessToken
 *
 *  @param accessToken 用户token
 */
- (void)setAuthorization:(NSString *)accessToken;

/**
 *  请求服务器数据
 *
 *  @param path     API接口
 *  @param params   参数
 *  @param method   GET/POST/PUT/DELETE
 *  @param callback 成功/失败回调
 */
- (NSURLSessionDataTask *)requestWithPath:(NSString *)path
                            requestParams:(NSDictionary *)params
                            networkMethod:(NetworkMethod2)method
                                 callback:(void (^)(id data, NSError *error))callback;
@end

