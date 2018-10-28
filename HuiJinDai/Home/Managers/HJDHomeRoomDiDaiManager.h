//
//  HJDHomeRoomDiDaiManager.h
//  HuiJinDai
//
//  Created by GXW on 2018/9/30.
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

#pragma Mark - 评值
//评值
+ (void)postRoomEvaluateWithModel:(HJDHomeRoomDiDaiModel *)model callBack:(void(^)(NSDictionary *dataDic, BOOL result))callback;

//获取评值记录
+ (void)getRoomEvaluateListWithPage:(NSInteger)page callBack:(RoomDiDaiHttpCallback)callback;

//获取评值信息（已询值）
+ (void)getRoomEvaluateInfoWithXunid:(NSString *)xun_id callBack:(void(^)(NSDictionary *dataDic, BOOL result))callback;

//获取评值信息（新询值）
+ (void)getNewRoomEvaluateInfoWithXunid:(NSString *)xun_id company:(NSString *)company callBack:(void(^)(NSDictionary *dataDic, BOOL result))callback;

#pragma mark - 创建工单
//申请工单号
+ (void)getOrderIdWithCallBack:(void(^)(NSDictionary *data, BOOL result))callback;

//获取工单附件类型
+ (void)getOrderFileWithCallBack:(void(^)(NSArray *dataArray, BOOL result))callback;

//提交工单
+ (void)postRoomDeclarationWithModel:(HJDDeclarationModel *)model callBack:(void(^)(NSDictionary *data, BOOL result))callback;

//工单详情
+ (void)getOrderDetailWithID:(NSString *)uid callBack:(void(^)(NSDictionary *data, BOOL result))callback;

//工单审核
+ (void)auditOrderWithID:(NSString *)uid step:(NSString *)step content:(NSString *)content managerId:(NSString *)managerId callBack:(void(^)(BOOL result))callback;

@end
