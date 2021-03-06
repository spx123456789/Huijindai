//
//  HJDHomeManager.h
//  HuiJinDai
//
//  Created by GXW on 2018/9/4.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJDOrderListModel.h"

@interface HJDHomeManager : NSObject

+ (void)getHomeBannerCallBack:(void(^)(NSDictionary *data, BOOL result))callBack;

+ (void)getOrderAuditListWithKeyWord:(NSString *)keyWord callBack:(void(^)(NSArray *data, BOOL result))callBack;

+ (void)getBankOrderListWithOrderNum:(NSString *)orderNum callBack:(void(^)(NSArray *data, BOOL result))callBack;

+ (void)getOrderAuditListChannelOrAgentWithUid:(NSString *)uid keyWord:(NSString *)keyWord page:(NSInteger)page callBack:(void(^)(NSArray *data, BOOL result))callBack;

+ (void)getOrderManageListWithKeyWord:(NSString *)keyWord callBack:(void(^)(NSDictionary *data, BOOL result))callBack;

+ (void)getOrderManageListChannelOrAgentWithUid:(NSString *)uid status:(NSString *)status keyWord:(NSString *)keyWord step:(NSString *)step page:(NSInteger)page callBack:(void(^)(NSArray *data, BOOL result))callBack;

#pragma mark - 计算器
//+ (void)getEndDateWithStartTime:(NSString *)startTime month:(NSString *)month callBack:(void(^)(NSString *dataStr, BOOL result))callBack;

+ (void)getJiSuanResultWithStartTime:(NSString *)startTime month:(NSString *)month money:(NSString *)money callBack:(void(^)(NSDictionary *dataDic, BOOL result))callBack;

#pragma mark - 消息数
+ (void)getOrderMessageUnreadCount:(void(^)(NSInteger manageCount, NSInteger auditCount))callBack;

@end
