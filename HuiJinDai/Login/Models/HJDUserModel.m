//
//  HJDUserModel.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/28.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDUserModel.h"

@implementation HJDUserModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{ @"user_id" : @"id"};
}

@end
