//
//  HJDHomeManager.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/4.
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
    if (keyWord != nil) {
        param = @{ @"rename" : keyWord };
    }
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Loan/get_shenhe") requestParams:param networkMethod:GET callback:^(NSDictionary *data, NSError *error) {
        if (error) {
            callBack(nil, NO);
        } else {
            callBack([data getObjectByPath:@"data/list"], YES);
        }
    }];
}

+ (void)getOrderAuditListChannelOrAgentWithUid:(NSString *)uid callBack:(void (^)(NSArray *, BOOL))callBack {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Loan/get_ulist") requestParams:@{ @"uid" : uid, @"status" : @"100" } networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callBack(nil, NO);
        } else {
            callBack([data getObjectByPath:@"data"], YES);
        }
    }];
}

+ (void)getOrderManageListWithKeyWord:(NSString *)keyWord callBack:(void (^)(NSDictionary *, BOOL))callBack {
    NSDictionary *param = nil;
    if (keyWord != nil) {
        param = @{ @"rename" : keyWord };
    }
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Loan/manage") requestParams:param networkMethod:GET callback:^(NSDictionary *data, NSError *error) {
        if (error) {
            callBack(nil, NO);
        } else {
            callBack([data getObjectByPath:@"data"], YES);
        }
    }];
}

+ (NSArray *)getOrderListArray {
    HJDOrderListModel *model = [[HJDOrderListModel alloc] init];
    model.orderNumber = @"20170912-00450";
    model.orderTime = @"2017-09-12 11:30";
    model.locationAddress = @"新世嘉家园";
    model.customerName = @"董冰";
    model.money = @"500万元";
    model.auditStatus = @"0";
    
    NSMutableArray *mut = [NSMutableArray array];
    for (int i = 0; i < 8; i ++) {
        [mut addObject:model];
    }
    return mut;
}

+ (NSArray *)getOrderProcessArray {
    HJDOrderListModel *model = [[HJDOrderListModel alloc] init];
    model.orderNumber = @"20170912-00450";
    model.orderTime = @"2017-09-12 11:30";
    model.locationAddress = @"大兴区兴泰街5号";
    model.customerName = @"董冰";
    model.money = @"500万元";
    model.auditStatus = @"0";
    
    NSMutableArray *mut = [NSMutableArray array];
    for (int i = 0; i < 8; i ++) {
        [mut addObject:model];
    }
    return mut;
}
@end
