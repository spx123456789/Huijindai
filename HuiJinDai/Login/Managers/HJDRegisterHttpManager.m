//
//  HJDRegisterHttpManager.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/27.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDRegisterHttpManager.h"

@implementation HJDRegisterHttpManager

+ (void)getVerifiCodeWithPhone:(NSString *)phone callBack:(HttpCallback)callBack {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/User/get_sms") requestParams:@{ @"phone" : phone } networkMethod:POST callback:^(NSDictionary *data, NSError *error) {
        NSLog(@"\n +++++获取验证码 /n%@", data);
        if (error) {
            callBack(nil, error, NO);
        } else {
            //NSString *randCode = [data getObjectByPath:@"data/rand_code"];
            callBack(data, nil, YES);
        }
    }];
}

+ (void)getCityListWithCodeId:(NSString *)codeID CallBack:(HttpCallback)callBack {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/User/get_city") requestParams:@{ @"code_id" : codeID} networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callBack(nil, error, NO);
        } else {
            callBack(data, nil, YES);
        }
    }];
}

+ (void)postRegisterRequestWithPhone:(NSString *)phone verifiCode:(NSString *)code realName:(NSString *)realName address:(NSString *)address inviteCode:(NSString *)inviteCode callBack:(HttpCallback)callBack {
    NSDictionary *param = @{ @"phone" : phone, @"rand_code" : code, @"rename" : realName, @"addr_office" : address, @"invitation_code" : inviteCode };
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/User/reg") requestParams:param networkMethod:POST callback:^(id data, NSError *error) {
        if (error) {
            callBack(nil, error, NO);
        } else {
            callBack([data getObjectByPath:@"data"], nil, YES);
        }
    }];
}

+ (void)loginWithPhone:(NSString *)phone verifiCode:(NSString *)code callBack:(HttpCallback)callBack {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/User/login") requestParams:@{ @"phone" : phone, @"rand_code" : code} networkMethod:POST callback:^(id data, NSError *error) {
        if (error) {
            callBack(nil, error, NO);
        } else {
            callBack([data getObjectByPath:@"data"], nil, YES);
        }
    }];
}
@end
