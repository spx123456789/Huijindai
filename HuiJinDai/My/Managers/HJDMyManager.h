//
//  HJDMyManager.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJDMyAgentModel.h"

@interface HJDMyManager : NSObject

//获取我的客户经理数据
+ (NSArray *)getMyCustomerManagerArray;

//获取我的经纪人数据
+ (NSArray *)getMyAgentArray;


@end
