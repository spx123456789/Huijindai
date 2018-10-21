//
//  HJDMessageManager.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/14.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMessageManager.h"
#import "HJDNetAPIManager.h"

@implementation HJDMessageManager

+ (void)getMyMessageWithType:(NSString *)type callBack:(void (^)(NSArray *, BOOL))callBack {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Msg/self") requestParams:@{ @"type" : type } networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callBack(nil, NO);
        } else {
            NSArray *arr = [data getObjectByPath:@"data/list"];
            arr = [HJDMessageManager fakeData];
            NSMutableArray *resultArray = [NSMutableArray array];
            for (int k = 0; k < arr.count; k++) {
                HJDMessageModel *message = [[HJDMessageModel alloc] init];
                [message hjd_loadDataFromkeyValues:arr[k]];
                if (k == 0) {
                    NSMutableArray *mutArr = [NSMutableArray array];
                    [mutArr addObject:message];
                    [resultArray addObject:mutArr];
                } else {
                    NSMutableArray *lastMut = resultArray.lastObject;
                    HJDMessageModel *lastMessage = lastMut.lastObject;
                    if ([HJDMessageManager isTheSameDay:message.create_time otherDay:lastMessage.create_time]) {
                        [lastMut addObject:message];
                    } else {
                        NSMutableArray *mutArray = [NSMutableArray array];
                        [mutArray addObject:message];
                        [resultArray addObject:mutArray];
                    }
                }
            }
            callBack(resultArray, YES);
        }
    }];
}

+ (void)deleteMyMessageWithMsgId:(NSString *)msgId callBack:(void (^)(BOOL))callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Msg/myself_delete") requestParams:@{ @"mid" : msgId } networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callback(NO);
        } else {
            callback(YES);
        }
    }];
}

+ (BOOL)isTheSameDay:(NSString *)oneDay otherDay:(NSString *)otherDay {
    NSString *oneDay2 = [HJDMessageManager changeTime:oneDay];
    NSString *otherDay2 = [HJDMessageManager changeTime:otherDay];
    if ([oneDay2 isEqualToString:otherDay2]) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSString *)changeTime:(NSString *)time {
    //2018-10-20 22:34:39
    NSString *year = [time substringWithRange:NSMakeRange(0, 4)];
    NSString *month = [time substringWithRange:NSMakeRange(5, 2)];
    NSString *day = [time substringWithRange:NSMakeRange(8, 2)];
    
    NSMutableString *mut = [NSMutableString stringWithString:year];
    [mut appendFormat:@"年%@月%@日", month, day];
    return mut;
}


///fake data
+ (NSArray *)fakeData {
   NSDictionary *dic = @{ @"id": @"1",// 消息ID，删除时需要
    @"type": @"1",// 传入的type类型值
    @"title": @"测试消息提醒",// 消息标题
    @"title_child": @"这是测试消息",// 消息子标题
    @"lid": @"102",// 关联工单编号
    @"loan_num": @"20181012-76043",// 工单号
    @"loan_status": @"1",// 工单状态
    @"create_time": @"2018-10-20 22:34:39",// 消息创建时间
    @"loan_type": @"房屋抵押贷款",// 工单状态信息
                         @"loan_status_num": @"渠道审核成功"};// 工单状态对应的中文描述
    
    NSDictionary *dic1 = @{ @"id": @"1",// 消息ID，删除时需要
                           @"type": @"1",// 传入的type类型值
                           @"title": @"测试消息提醒",// 消息标题
                           @"title_child": @"这是测试消息",// 消息子标题
                           @"lid": @"102",// 关联工单编号
                           @"loan_num": @"20181012-76043",// 工单号
                           @"loan_status": @"1",// 工单状态
                           @"create_time": @"2018-10-22 22:34:39",// 消息创建时间
                           @"loan_type": @"房屋抵押贷款",// 工单状态信息
                           @"loan_status_num": @"渠道审核成功"};// 工单状态对应的中文描述
    
    NSDictionary *dic2 = @{ @"id": @"1",// 消息ID，删除时需要
                           @"type": @"1",// 传入的type类型值
                           @"title": @"测试消息提醒",// 消息标题
                           @"title_child": @"这是测试消息",// 消息子标题
                           @"lid": @"102",// 关联工单编号
                           @"loan_num": @"20181012-76043",// 工单号
                           @"loan_status": @"1",// 工单状态
                           @"create_time": @"2018-09-20 22:34:39",// 消息创建时间
                           @"loan_type": @"房屋抵押贷款",// 工单状态信息
                           @"loan_status_num": @"渠道审核成功"};// 工单状态对应的中文描述
    
    return @[ dic2, dic2, dic2, dic1, dic, dic ];
    
}
@end
