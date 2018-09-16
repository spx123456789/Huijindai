//
//  HJDMessageManager.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/14.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMessageManager.h"

@implementation HJDMessageManager

+ (NSArray *)getMyMessage {
    HJDMessageModel *message = [[HJDMessageModel alloc] init];
    message.number = @"20170912-00930";
    message.type = @"房抵押";
    message.status = @"风控分配成功";
    message.time = @"1536930273";
    
    NSMutableArray *mut = [NSMutableArray arrayWithObjects:message, message, message, nil];
    NSArray *arr = [NSArray arrayWithObjects:mut, mut, mut, nil];
    return arr;
}

+ (NSArray *)getChannelMessage {
    HJDMessageModel *message = [[HJDMessageModel alloc] init];
    message.number = @"20170912-00930";
    message.type = @"房抵押";
    message.status = @"风控分配成功";
    message.time = @"1536930273";
    
    NSMutableArray *mut = [NSMutableArray arrayWithObjects:message, message, nil];
    NSArray *arr = [NSArray arrayWithObjects:mut, mut, mut, nil];
    return arr;
}
@end
