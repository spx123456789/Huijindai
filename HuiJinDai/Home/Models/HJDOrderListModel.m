//
//  HJDOrderListModel.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/4.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDOrderListModel.h"

@implementation HJDOrderListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{ @"order_id" : @"id"};
}

@end
