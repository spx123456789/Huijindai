//
//  HJDMyManager.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMyManager.h"
#import "HJDNetAPIManager.h"

@implementation HJDMyManager

+ (void)getMyCustomerManagerWithCallBack:(void (^)(NSArray *))callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:@"/User/get_customer" requestParams:nil networkMethod:GET callback:^(id data, NSError *error) {
        
    }];
}

+ (void)getMyAgentWithCallBack:(void (^)(NSArray *))callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:@"/User/get_agent" requestParams:nil networkMethod:GET callback:^(id data, NSError *error) {
        
    }];
}

+ (void)getUserInviteCodeWithCallBack:(void (^)(NSArray *))callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:@"/User/get_qrcode" requestParams:nil networkMethod:GET callback:^(id data, NSError *error) {
        
    }];
}

+ (void)getMyInfoWithCallBack:(void (^)(NSArray *))callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/User/get_info") requestParams:nil networkMethod:GET callback:^(id data, NSError *error) {
        
    }];
}
@end
