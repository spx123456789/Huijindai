//
//  HJDHomeManager.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/4.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeManager.h"
#import "HJDNetAPIManager.h"

@implementation HJDHomeManager

+ (void)getHomeBannerCallBack:(void (^)(NSArray *, BOOL))callBack {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/System/home_page") requestParams:nil networkMethod:GET callback:^(NSDictionary *data, NSError *error) {
        if (error) {
            callBack(nil, NO);
        } else {
            NSArray *bannerArray = [data getObjectByPath:@"data/banner"];
            callBack(bannerArray, YES);
        }
    }];
}

+ (void)getOrderAuditListWithKeyWord:(NSString *)keyWord callBack:(void (^)(NSArray *, BOOL))callBack {
    NSDictionary *param = nil;
    if (![NSString hjd_isBlankString:keyWord]) {
        param = @{ @"rename" : keyWord };
    }
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Loan/get_shenhe") requestParams:param networkMethod:GET callback:^(NSDictionary *data, NSError *error) {
        if (error) {
            callBack(nil, NO);
        } else {
            NSString *code = [data getObjectByPath:@"code"];
            if (code.integerValue == 0) {
                callBack([data getObjectByPath:@"data/list"], YES);
            } else {
                callBack(nil, NO);
            }
        }
    }];
}

+ (void)getOrderAuditListChannelOrAgentWithUid:(NSString *)uid keyWord:(NSString *)keyWord page:(NSInteger)page callBack:(void (^)(NSArray *, BOOL))callBack {
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:@{ @"uid" : uid, @"status" : @"100", @"p0" : @(page) }];
    if (![NSString hjd_isBlankString:keyWord]) {
        [param addEntriesFromDictionary:@{ @"address" : keyWord }];;
    }
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Loan/get_ulist") requestParams:param networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callBack(nil, NO);
        } else {
            NSString *code = [data getObjectByPath:@"code"];
            if (code.integerValue == 0) {
                callBack([data getObjectByPath:@"data/list"], YES);
            } else {
                callBack(nil, NO);
            }
        }
    }];
}

+ (void)getOrderManageListWithKeyWord:(NSString *)keyWord callBack:(void (^)(NSDictionary *, BOOL))callBack {
    NSDictionary *param = nil;
    if (![NSString hjd_isBlankString:keyWord]) {
        param = @{ @"rename" : keyWord };
    }
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Loan/manage") requestParams:param networkMethod:GET callback:^(NSDictionary *data, NSError *error) {
        if (error) {
            callBack(nil, NO);
        } else {
            NSString *code = [data getObjectByPath:@"code"];
            if (code.integerValue == 0) {
                callBack([data getObjectByPath:@"data"], YES);
            } else {
                callBack(nil, NO);
            }
        }
    }];
}

+ (void)getOrderManageListChannelOrAgentWithUid:(NSString *)uid status:(NSString *)status keyWord:(NSString *)keyWord step:(NSString *)step page:(NSInteger)page callBack:(void (^)(NSArray *, BOOL))callBack {
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:@{ @"uid" : uid, @"status" : status, @"p0" : @(page) }];
    if (![NSString hjd_isBlankString:keyWord]) {
        [param addEntriesFromDictionary:@{ @"address" : keyWord }];;
    }
    
    if (![NSString hjd_isBlankString:step]) {
        [param addEntriesFromDictionary:@{ @"step" : step }];;
    }
    
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Loan/list_manage") requestParams:param networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callBack(nil, NO);
        } else {
            NSString *code = [data getObjectByPath:@"code"];
            if (code.integerValue == 0) {
                callBack([data getObjectByPath:@"data/list"], YES);
            } else {
                callBack(nil, NO);
            }
        }
    }];
}

#pragma mark - 计算器
+ (void)getEndDateWithStartTime:(NSString *)startTime month:(NSString *)month callBack:(void (^)(NSString *, BOOL))callBack {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Loan/finance_data") requestParams:@{ @"start_date" : startTime, @"month" : month } networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callBack(nil, NO);
        } else {
            callBack([data getObjectByPath:@"data/end_date"], YES);
        }
    }];
}

+ (void)getJiSuanResultWithStartTime:(NSString *)startTime month:(NSString *)month money:(NSString *)money callBack:(void (^)(NSDictionary *, BOOL))callBack {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Loan/finance_submit") requestParams:@{ @"start_date" : startTime, @"month" : month, @"money" : money } networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callBack(nil, NO);
        } else {
            NSString *code = [data getObjectByPath:@"code"];
            if (code.integerValue == 0) {
                callBack([data getObjectByPath:@"data"], YES);
            } else {
                callBack(nil, NO);
            }
        }
    }];
}

#pragma mark - 消息数
+ (void)getOrderMessageUnreadCount:(void (^)(NSInteger, NSInteger))callBack {
    [HJDHomeManager getOrderManageMessageCount:^(NSInteger managecount) {
        [HJDHomeManager getOrderAuditMessageCount:^(NSInteger auditcount) {
            callBack(managecount, auditcount);
        }];
    }];
}

+ (void)getOrderManageMessageCount:(void(^)(NSInteger count))callBack {
    [HJDHomeManager getOrderManageListWithKeyWord:nil callBack:^(NSDictionary *data, BOOL result) {
        if (result) {
            NSInteger total_count = 0;
            NSArray *selfArray = [data objectForKey:@"self"];
            NSArray *subArray = [data objectForKey:@"sub"];
            
            for (NSDictionary *dic in selfArray) {
                NSString *number = dic[@"count"];
                total_count += number.integerValue;
            }
            
            for (NSDictionary *dic in subArray) {
                NSString *number = dic[@"count"];
                total_count += number.integerValue;
            }
            callBack(total_count);
        } else {
            callBack(0);
        }
    }];
}

+ (void)getOrderAuditMessageCount:(void (^)(NSInteger count))callBack {
    [HJDHomeManager getOrderAuditListWithKeyWord:nil callBack:^(NSArray *data, BOOL result) {
        if (result) {
            NSInteger total_count = 0;
            for (NSDictionary *dic in data) {
                NSString *number = dic[@"new_count"];
                total_count += number.integerValue;
            }
            callBack(total_count);
        } else {
            callBack(0);
        }
        
    }];
}
@end
