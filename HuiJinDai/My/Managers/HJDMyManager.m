//
//  HJDMyManager.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMyManager.h"

@implementation HJDMyManager

+ (NSArray *)getMyCustomerManagerArray {
    NSMutableArray *mut = [NSMutableArray array];
    
    HJDMyAgentModel *model = [[HJDMyAgentModel alloc] init];
    model.name = @"李铭";
    model.phone = @"13567892345";
    
    for (int i = 0; i < 5; i++) {
        [mut addObject:model];
    }
    
    return mut;
}

+ (NSArray *)getMyAgentArray {
    NSMutableArray *mut = [NSMutableArray array];
    
    HJDMyAgentModel *model = [[HJDMyAgentModel alloc] init];
    model.name = @"王世明";
    model.phone = @"15367892345";
    
    for (int i = 0; i < 5; i++) {
        [mut addObject:model];
    }
    
    return mut;
}

@end
