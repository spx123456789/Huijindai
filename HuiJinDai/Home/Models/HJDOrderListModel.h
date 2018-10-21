//
//  HJDOrderListModel.h
//  HuiJinDai
//
//  Created by GXW on 2018/9/4.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDBaseModel.h"

@interface HJDOrderListModel : HJDBaseModel
@property(nonatomic, copy) NSString *order_id;
@property(nonatomic, copy) NSString *ad_time;
@property(nonatomic, copy) NSString *address;
@property(nonatomic, copy) NSString *customer_name;
@property(nonatomic, copy) NSString *is_fast;
@property(nonatomic, copy) NSString *loan_first;
@property(nonatomic, copy) NSString *loan_guarantee;
@property(nonatomic, copy) NSString *loan_money;
@property(nonatomic, copy) NSString *loan_num;
@property(nonatomic, copy) NSString *loan_purpose;
@property(nonatomic, copy) NSString *loan_purpose_msg;
@property(nonatomic, copy) NSString *loan_status;
@property(nonatomic, copy) NSString *loan_status_name;
@property(nonatomic, copy) NSString *loan_time;
@property(nonatomic, copy) NSString *loan_time_type;
@property(nonatomic, copy) NSString *loan_variety;
@property(nonatomic, copy) NSString *uid;
@end
