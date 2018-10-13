//
//  HJDDeclarationModel.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/10/13.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDBaseModel.h"

typedef enum : NSUInteger {
    HJDLoanVarietyHouse = 1,    //房屋抵押贷款
    HJDLoanVarietyHouse_2,      //房屋抵押贷款（加案）
    HJDLoanVarietyCar,          //车辆抵押贷款
} HJDLoanVariety;

typedef enum : NSUInteger {
    HJDLoanTimeMonth = 1,
    HJDLoanTimeDay,
} HJDLoanTimeType;

@interface HJDDeclarationModel : HJDBaseModel
//之前申请的工单唯一标识
@property(nonatomic, copy) NSString *loan_id;
//[选填]寻值编号[Default：0]
@property(nonatomic, copy) NSString *evaluation_id;
//贷款品种，1房屋抵押贷款，2房屋抵押贷款（加案），3车辆抵押贷款
@property(nonatomic, assign) HJDLoanVariety loan_variety;
//贷款金额，单位：元，必须大于0
@property(nonatomic, copy) NSString *loan_money;
//借款时长 单位为loan_time_type的类型
@property(nonatomic, copy) NSString *loan_time;
//借款单位，1月，2天
@property(nonatomic, assign) HJDLoanTimeType loan_time_type;
//一抵余额，单位：元
@property(nonatomic, copy) NSString *loan_first;

//身份证图片
@property(nonatomic, strong) NSArray *idCardArray;
//户口本图片
@property(nonatomic, strong) NSArray *bookArray;
//征信报告
@property(nonatomic, strong) NSArray *creditReportArray;
//婚姻证明
@property(nonatomic, strong) NSArray *marriageArray;
//房产证图片
@property(nonatomic, strong) NSArray *houseArry;

@end
