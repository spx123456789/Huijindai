//
//  HJDHomeOrderListTableViewCell.h
//  HuiJinDai
//
//  Created by GXW on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HJDOrderAuditStatus_To = 0,
    HJDOrderAuditStatus_In,
    HJDOrderAuditStatus_End,
} HJDOrderAuditStatus;

@interface HJDHomeOrderListTableViewCell : UITableViewCell
@property(nonatomic, copy) NSString *orderNumber;
@property(nonatomic, copy) NSString *orderTime;
@property(nonatomic, copy) NSString *locationAddress;
@property(nonatomic, copy) NSString *customerName;
@property(nonatomic, copy) NSString *money;
@property(nonatomic, copy) NSString *status;
@end
