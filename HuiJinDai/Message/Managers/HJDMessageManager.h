//
//  HJDMessageManager.h
//  HuiJinDai
//
//  Created by GXW on 2018/9/14.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJDMessageModel.h"

@interface HJDMessageManager : NSObject

//查询的站内信类型，1站内信，3渠道站内信
+ (void)getMyMessageWithType:(NSString *)type callBack:(void(^)(NSArray *data, BOOL result))callBack;

+ (void)deleteMyMessageWithMsgId:(NSString *)msgId callBack:(void(^)(BOOL result))callback;
@end
