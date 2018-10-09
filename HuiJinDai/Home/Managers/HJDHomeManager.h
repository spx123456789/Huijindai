//
//  HJDHomeManager.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/4.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJDOrderListModel.h"

@interface HJDHomeManager : NSObject

+ (void)getHomeBannerCallBack:(void(^)(NSArray *data, BOOL result))callBack;

+ (NSArray *)getOrderListArray;

+ (NSArray *)getOrderProcessArray;


@end
