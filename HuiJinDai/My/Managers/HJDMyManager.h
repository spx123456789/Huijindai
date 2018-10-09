//
//  HJDMyManager.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJDMyAgentModel.h"
#import "HJDUserModel.h"

@interface HJDMyManager : NSObject

//获取我的客户经理数据
+ (void)getMyCustomerManagerWithCallBack:(void(^)(NSArray *arr))callback;

//获取我的经纪人数据
+ (void)getMyAgentWithCallBack:(void(^)(NSArray *arr))callback;

//获取用户邀请码
+ (void)getUserInviteCodeWithCallBack:(void(^)(NSArray *arr))callback;

//获取我的信息
+ (void)getMyInfoWithCallBack:(void(^)(NSArray *arr))callback;

//设置头像信息
+ (void)setMyAvatarWithImage:(UIImage *)image callBack:(void(^)(BOOL result))callback;
@end
