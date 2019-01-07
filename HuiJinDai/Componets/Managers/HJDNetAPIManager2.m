//
//  HJDNetAPIManager2.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/27.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDNetAPIManager2.h"

static NSURL *baseurl = nil;
static NSString *acesstoken = nil;

@implementation HJDNetAPIManager2

static HJDNetAPIManager2 *_sharedManager = nil;
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baseurl = [NSURL URLWithString:kAPIMainURL];
        _sharedManager = [[HJDNetAPIManager2 alloc] initWithBaseURL:baseurl withCer:YES];
    });
    return _sharedManager;
}

- (id)initWithBaseURL:(NSURL *)url withCer:(BOOL)shouldSetCer{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html",
     @"image/png", @"image/jpg", @"video/mpeg4", @"image/gif", @"application/x-zip-compressed",
     @"application/binary", nil];
    
    //超时设置
    self.requestSerializer.timeoutInterval = 30.0f;
    
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
    
    
    self.securityPolicy.allowInvalidCertificates = YES;
    
    //是否匹配域名
    self.securityPolicy.validatesDomainName = NO;
    
    // 客户端是否信任非法证书
    self.securityPolicy.allowInvalidCertificates = YES;
    // 是否在证书域字段中验证域名
    [self.securityPolicy setValidatesDomainName:NO];
    
    //设置HJD header
    [self.requestSerializer setValue:@"1.0.0" forHTTPHeaderField:@"app-version"];
    [self.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"AppType"];
    [self.requestSerializer setValue:@"v1.0.1" forHTTPHeaderField:@"api-version"];

    return self;
}

- (void)setAuthorization:(NSString *)accessToken {
    acesstoken = accessToken;
    [self.requestSerializer setValue:accessToken forHTTPHeaderField:@"AppToken"];
}

- (NSURLSessionDataTask *)requestWithPath:(NSString *)path
                            requestParams:(NSDictionary *)params
                            networkMethod:(NetworkMethod2)method
                                 callback:(void (^)(id data, NSError *error))block {
    if (!path || path.length <= 0) {
        return nil;
    }
    //path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    @weakify(self);
    //    发起请求
    switch (method) {
        case GET2: {
            return [self GET:path
                  parameters:params
                    progress:^(NSProgress * _Nonnull downloadProgress) {
                    }
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         @strongify(self);
                         id error = [self handleResponse:responseObject];
                         if (error) {
                             block(responseObject, error);
                         } else {
                             block(responseObject, nil);
                         }
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         NSLog(@"\n===========response===========\n%@:\n%@", path, error);
                         block(nil, error);
                     }];
            break;
        }
        case POST2: {
            return [self POST:path
                   parameters:params
                     progress:^(NSProgress * _Nonnull downloadProgress) {
                     }
                      success:^(NSURLSessionTask *task, id responseObject) {
                          @strongify(self);
                          
                          id error = [self handleResponse:responseObject];
                          if (error) {
                              block(responseObject, error);
                          } else {
                              block(responseObject, nil);
                          }
                      }
                      failure:^(NSURLSessionTask *task, NSError *error) {
                          NSLog(@"\n===========response===========\n%@:\n%@", path, error);
                          block(nil, error);
                      }];
            break;
        }
        case PUT2: {
            return [self PUT:path
                  parameters:params
                     success:^(NSURLSessionTask *task, id responseObject) {
                         @strongify(self);
                         id error = [self handleResponse:responseObject];
                         if (error) {
                             block(responseObject, error);
                         } else {
                             block(responseObject, nil);
                         }
                     }
                     failure:^(NSURLSessionTask *task, NSError *error) {
                         NSLog(@"\n===========response===========\n%@:\n%@", path, error);
                         block(nil, error);
                     }];
            break;
        }
        case DELETE2: {
            return [self DELETE:path
                     parameters:params
                        success:^(NSURLSessionTask *task, id responseObject) {
                            @strongify(self);
                            id error = [self handleResponse:responseObject];
                            if (error) {
                                block(responseObject, error);
                            } else {
                                block(responseObject, nil);
                            }
                        }
                        failure:^(NSURLSessionTask *task, NSError *error) {
                            NSLog(@"\n===========response===========\n%@:\n%@", path, error);
                            block(nil, error);
                        }];
        }
        default:
            break;
    }
    return nil;
}

#pragma mark NetError
- (id)handleResponse:(id)responseJSON {
    return [self handleResponse:responseJSON autoShowError:YES];
}

- (id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError {
    NSError *error = nil;
    NSDictionary *headDic = [responseJSON valueForKeyPath:@"head"];
    // status为非0值时，表示有错
    NSNumber *status = [headDic valueForKeyPath:@"status"];
    
    if (status.intValue != 0) {
        error = [NSError errorWithDomain:kAPIMainURL
                                    code:status.intValue
                                userInfo:responseJSON];
        
        //显示错误信息
    }
    return error;
}

@end
