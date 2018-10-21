//
//  HJDMessageModel.h
//  HuiJinDai
//
//  Created by GXW on 2018/9/14.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDBaseModel.h"

@interface HJDMessageModel : HJDBaseModel
@property(nonatomic, copy) NSString *mid;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *title_child;
@property(nonatomic, copy) NSString *lid; //关联工单号
@property(nonatomic, copy) NSString *loan_num; //工单号
//工单状态 9为终止工单，超过10的为失败工单，低于9的大于0的为正常工单
// 工单状态不可能小于0，目前也不会大于20
@property(nonatomic, copy) NSString *loan_status;
@property(nonatomic, copy) NSString *create_time;
@property(nonatomic, copy) NSString *loan_type;
// 工单状态对应的中文描述
@property(nonatomic, copy) NSString *loan_status_num;
@end
