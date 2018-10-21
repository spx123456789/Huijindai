//
//  HJDHomeQueryValueDetailModel.h
//  HuiJinDai
//
//  Created by GXW on 2018/10/21.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDBaseModel.h"

@interface HJDHomeQueryValueDetailModel : HJDBaseModel
@property(nonatomic, strong) NSArray *list;
@property(nonatomic, copy) NSString *provinceName;
@property(nonatomic, copy) NSString *cityName;
@property(nonatomic, copy) NSString *districtName;
@property(nonatomic, copy) NSString *communityName;
@property(nonatomic, copy) NSString *address;
@property(nonatomic, copy) NSString *planning;
@property(nonatomic, copy) NSString *houseSpace;
@property(nonatomic, copy) NSString *frequency;
/*
 "list":[
 {
 "totalPrice":"4480000",// 房间总价，单位：元
 "unitPrice":"44797",// 房间单价，单位：元
 "assessCompany":"01",// 查询到的所属来源， 01-世联,02-仁达,03-首佳
 },
 {
 "assessCompany":"02",
 "totalPrice":"4480000",
 "unitPrice":"44797"
 }
 ],
 "provinceName": "北京市",// 省
 "cityName": "市辖区",// 市
 "districtName": "西城区",// 区
 "communityName": "榆树馆西里",// 小区名称
 "address": "北京市市辖区西城区榆树馆西里",// 房屋地址
 "planning": "1",// 规划用途
 "houseSpace": "188",// 建筑面积，单位：㎡
 "frequency": "5"// 今天剩余寻值次数
 */
@end

