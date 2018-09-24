//
//  HJDHomeManager.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/4.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeManager.h"

@implementation HJDHomeManager

+ (NSArray *)getOrderListArray {
    HJDOrderListModel *model = [[HJDOrderListModel alloc] init];
    model.orderNumber = @"20170912-00450";
    model.orderTime = @"2017-09-12 11:30";
    model.locationAddress = @"新世嘉家园";
    model.customerName = @"董冰";
    model.money = @"500万元";
    model.auditStatus = @"0";
    
    NSMutableArray *mut = [NSMutableArray array];
    for (int i = 0; i < 8; i ++) {
        [mut addObject:model];
    }
    return mut;
}

+ (NSArray *)getOrderProcessArray {
    HJDOrderListModel *model = [[HJDOrderListModel alloc] init];
    model.orderNumber = @"20170912-00450";
    model.orderTime = @"2017-09-12 11:30";
    model.locationAddress = @"大兴区兴泰街5号";
    model.customerName = @"董冰";
    model.money = @"500万元";
    model.auditStatus = @"0";
    
    NSMutableArray *mut = [NSMutableArray array];
    for (int i = 0; i < 8; i ++) {
        [mut addObject:model];
    }
    return mut;
}
@end
