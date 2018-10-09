//
//  HJDHomeRoomDiDaiManager.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeRoomDiDaiManager.h"
#import "HJDNetAPIManager.h"

@implementation HJDHomeRoomDiDaiManager

+ (void)getShengListCallBack:(RoomDiDaiHttpCallback)callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/sheng") requestParams:nil networkMethod:GET callback:^(NSDictionary *data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            callback([data getObjectByPath:@"data/list"], YES);
        }
    }];
}

+ (void)getShiListWithShengId:(NSString *)shengId CallBack:(RoomDiDaiHttpCallback)callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/shi") requestParams:@{ @"code" : shengId } networkMethod:GET callback:^(NSDictionary *data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            callback([data getObjectByPath:@"data/child"], YES);
        }
    }];
}

+ (void)getQuListWithShengId:(NSString *)shengId shiId:(NSString *)shiId CallBack:(RoomDiDaiHttpCallback)callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/qu") requestParams:@{@"code" : shengId, @"code_shi" : shiId } networkMethod:GET callback:^(NSDictionary *data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            callback([data getObjectByPath:@"data/child"], YES);
        }
    }];
}

+ (void)getXiaoquListWithShiId:(NSString *)shiId quId:(NSString *)quId keyWord:(NSString *)keyWord CallBack:(RoomDiDaiHttpCallback)callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/community") requestParams:@{ @"shi" : shiId, @"qu" : quId, @"community" : keyWord } networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            callback([data getObjectByPath:@"data/list"], YES);
        }
    }];
}

+ (void)getLouDongListWithModel:(HJDHomeRoomDiDaiModel *)model keyWord:(NSString *)keyWord CallBack:(RoomDiDaiHttpCallback)callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/building") requestParams:@{ @"qu" : model.districtId, @"community_id" : model.communityId, @"building" : keyWord, @"companyStr" : model.communityCompany} networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            callback([data getObjectByPath:@"data/list"], YES);
        }
    }];
}

+ (void)getDanYuanListWithModel:(HJDHomeRoomDiDaiModel *)model keyWord:(NSString *)keyWord CallBack:(RoomDiDaiHttpCallback)callback {
    
}

+ (void)getMenPaiListWithModel:(HJDHomeRoomDiDaiModel *)model keyWord:(NSString *)keyWord CallBack:(RoomDiDaiHttpCallback)callback {
    
}

+ (void)postRoomEvaluateWithModel:(HJDHomeRoomDiDaiModel *)model callBack:(RoomDiDaiHttpCallback)callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/evaluate") requestParams:[model getRoomEvaluateParams] networkMethod:POST callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            callback([data getObjectByPath:@"data/list"], YES);
        }
    }];
}
@end
