//
//  HJDHomeRoomDiDaiManager.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJDHomeRoomDiDaiModel.h"
#import "HJDDeclarationModel.h"

typedef void (^RoomDiDaiHttpCallback)(NSArray *data, BOOL result);

@interface HJDHomeRoomDiDaiManager : NSObject

+ (void)getShengListCallBack:(RoomDiDaiHttpCallback)callback;

+ (void)getShiListWithShengId:(NSString *)shengId CallBack:(RoomDiDaiHttpCallback)callback;

+ (void)getQuListWithShengId:(NSString *)shengId shiId:(NSString *)shiId CallBack:(RoomDiDaiHttpCallback)callback;

+ (void)getXiaoquListWithShiId:(NSString *)shiId quId:(NSString *)quId keyWord:(NSString *)keyWord CallBack:(RoomDiDaiHttpCallback)callback;

+ (void)getLouDongListWithModel:(HJDHomeRoomDiDaiModel *)model keyWord:(NSString *)keyWord CallBack:(RoomDiDaiHttpCallback)callback;

+ (void)getDanYuanListWithModel:(HJDHomeRoomDiDaiModel *)model keyWord:(NSString *)keyWord CallBack:(RoomDiDaiHttpCallback)callback;

+ (void)getMenPaiListWithModel:(HJDHomeRoomDiDaiModel *)model keyWord:(NSString *)keyWord CallBack:(RoomDiDaiHttpCallback)callback;

//评值
+ (void)postRoomEvaluateWithModel:(HJDHomeRoomDiDaiModel *)model callBack:(RoomDiDaiHttpCallback)callback;

//获取评值记录
+ (void)getRoomEvaluateListWithCallBack:(RoomDiDaiHttpCallback)callback;

//获取评值信息
+ (void)getRoomEvaluateInfoWithXunid:(NSString *)xun_id callBack:(RoomDiDaiHttpCallback)callback;

//申请工单号
+ (void)getOrderIdWithCallBack:(void(^)(NSDictionary *data, BOOL result))callback;

//提交工单
+ (void)postRoomDeclarationWithModel:(HJDDeclarationModel *)model callBack:(void(^)(NSDictionary *data, BOOL result))callback;

//工单详情
+ (void)getOrderDetailWithID:(NSString *)uid callBack:(void(^)(NSDictionary *data, BOOL result))callback;
@end
