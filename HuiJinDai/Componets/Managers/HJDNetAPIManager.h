//
//  HJDNetAPIManager.h
//  HuiJinDai
//
//  Created by GXW on 2018/9/27.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef NS_ENUM(NSUInteger, NetworkMethod) {
    GET = 0,  // get请求
    POST,     // post请求
    PUT,
    DELETE
};

@interface HJDNetAPIManager : AFHTTPSessionManager

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
                            networkMethod:(NetworkMethod)method
                                 callback:(void (^)(id data, NSError *error))callback;
@end

#pragma mark DownLoadFile -
@interface AFHTTPSessionManager (DownLoadData)

- (NSURLSessionDownloadTask *)downloadWithUrl:(NSString *)url
                                   tofilePath:(NSString *)file
                                     progress:(void (^)(NSUInteger bytesRead, long long totalBytesRead,
                                                        long long totalBytesExpectedToRead))block
                                      success:(void (^)(NSURLSessionDownloadTask *task, NSURLResponse *response))success
                                      failure:(void (^)(NSURLSessionDownloadTask *task, NSError *error))failure;

@end
