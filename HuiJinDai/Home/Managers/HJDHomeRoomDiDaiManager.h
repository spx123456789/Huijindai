//
//  HJDHomeRoomDiDaiManager.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJDHomeRoomDiDaiModel.h"

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
@end
