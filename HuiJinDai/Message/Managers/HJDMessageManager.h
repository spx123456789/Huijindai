//
//  HJDMessageManager.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/14.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJDMessageModel.h"

@interface HJDMessageManager : NSObject

+ (NSArray *)getMyMessage;

+ (NSArray *)getChannelMessage;

@end
