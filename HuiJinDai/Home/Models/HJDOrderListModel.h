//
//  HJDOrderListModel.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/4.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJDOrderListModel : NSObject
@property(nonatomic, copy) NSString *orderNumber;
@property(nonatomic, copy) NSString *orderTime;
@property(nonatomic, copy) NSString *locationAddress;
@property(nonatomic, copy) NSString *customerName;
@property(nonatomic, copy) NSString *money;
@property(nonatomic, copy) NSString *auditStatus;
@end
