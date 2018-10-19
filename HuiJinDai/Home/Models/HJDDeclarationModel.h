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

typedef enum : NSUInteger {
    HJDLoanCertificate_idCard = 1,          //身份证
    HJDLoanCertificate_businessLicense,     //营业执照
    HJDLoanCertificate_passport,            //护照
    HJDLoanCertificate_officer,             //军官证
    HJDLoanCertificate_soldiers,            //士兵证
    HJDLoanCertificate_HongKong,            //港澳居民来往内地通行证
    HJDLoanCertificate_Taiwan,              //台湾居民来往大陆通行证
    HJDLoanCertificate_other,               //其他
} HJDLoanCertificateType;

typedef enum : NSUInteger {
    HJDLoanMarriage_unmarried = 1,  //未婚
    HJDLoanMarriage_hasChildren,    //已婚有子女
    HJDLoanMarriage_noChildren,     //已婚无子女
    HJDLoanMarriage_no,             //丧偶
    HJDLoanMarriage_divorced,       //离异
    HJDLoanMarriage_remarried,      //再婚
} HJDLoanMarriageType;

@interface HJDDeclarationModel : HJDBaseModel
//之前申请的工单唯一标识
@property(nonatomic, copy) NSString *loan_id;
//[选填]寻值编号[Default：0]
@property(nonatomic, copy) NSString *evaluation_id;
//客户姓名
@property(nonatomic, copy) NSString *name;
//证件类型，1身份证，2营业执照，3护照，4军官证，5士兵证，6港澳居民来往内地通行证，台湾居民来往大陆通行证，8其他证件
@property(nonatomic, assign) HJDLoanCertificateType certificate_type;
//证件号码
@property(nonatomic, copy) NSString *certificate_number;
//婚姻情况，1未婚，2已婚有子女，3已婚无子女，4丧偶，5离异，6再婚
@property(nonatomic, assign) HJDLoanMarriageType indiv_marital;
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
