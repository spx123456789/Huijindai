//
//  HJDMyManager.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMyManager.h"
#import "HJDNetAPIManager.h"
#import "AFURLRequestSerialization.h"

@implementation HJDMyManager

+ (void)getMyCustomerManagerWithCallBack:(void (^)(NSArray *, BOOL))callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:@"/User/get_customer" requestParams:nil networkMethod:GET callback:^(NSDictionary *data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            callback([data getObjectByPath:@"data/list"], YES);
        }
    }];
}

+ (void)getMyAgentWithCallBack:(void (^)(NSArray *, BOOL))callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:@"/User/get_agent" requestParams:nil networkMethod:GET callback:^(NSDictionary *data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            callback([data getObjectByPath:@"data/list"], YES);
        }
    }];
}

+ (void)getUserInviteCodeWithCallBack:(void (^)(NSDictionary *, BOOL))callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:@"/User/get_qrcode" requestParams:nil networkMethod:GET callback:^(NSDictionary *data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            callback([data getObjectByPath:@"data"], YES);
        }
    }];
}

+ (void)getMyInfoWithCallBack:(void (^)(NSArray *, BOOL))callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/User/get_info") requestParams:nil networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            callback(data, YES);
        }
    }];
}

+ (void)setMyAvatarWithImage:(UIImage *)image callBack:(void (^)(BOOL))callback {
    [[HJDNetAPIManager sharedManager] requestWithMethod:POST url:kAPIURL(@"/User/set_avatar") parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *photo = UIImageJPEGRepresentation(image, 1);
        [formData appendPartWithFileData:photo name:@"avatar" fileName:[NSString stringWithFormat:@"%@.jpg", @"000"] mimeType:@"image/jpg"];
    } progress:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
@end
