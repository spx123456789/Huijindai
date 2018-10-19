//
//  HJDMyManager.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJDMyAgentModel.h"
#import "HJDUserDefaultsManager.h"
#import "HJDUserModel.h"

@interface HJDMyManager : NSObject

//获取我的客户经理数据
+ (void)getMyCustomerManagerWithCallBack:(void(^)(NSArray *arr, BOOL result))callback;

//获取我的经纪人数据
+ (void)getMyAgentWithCallBack:(void(^)(NSArray *arr, BOOL result))callback;

//获取用户邀请码
+ (void)getUserInviteCodeWithCallBack:(void(^)(NSDictionary *dic, BOOL result))callback;

//获取我的信息
+ (void)getMyInfoWithCallBack:(void(^)(NSDictionary *dic, BOOL result))callback;

//设置头像信息
+ (void)setMyAvatarWithImage:(UIImage *)image callBack:(void(^)(NSString *path, BOOL result))callback;

//修改个人信息
+ (void)modifyMyInfoWithParams:(NSDictionary *)params callBack:(void(^)(BOOL result))callback;

//重新更新一下我的信息
+ (void)reUpdateMyInfo:(void(^)(BOOL result))callback;;
@end
