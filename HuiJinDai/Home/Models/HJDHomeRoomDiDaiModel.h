//
//  HJDHomeRoomDiDaiModel.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDBaseModel.h"

@interface HJDHomeRoomDiDaiModel : HJDBaseModel
//省份ID
@property(nonatomic, copy) NSString *provinceId;
//省份名称
@property(nonatomic, copy) NSString *provinceName;
//城市 Id
@property(nonatomic, copy) NSString *cityId;
//城市名称
@property(nonatomic, copy) NSString *cityName;
//区ID
@property(nonatomic, copy) NSString *districtId;
//区名称
@property(nonatomic, copy) NSString *districtName;
//小区ID
@property(nonatomic, copy) NSString *communityId;
//小区名称
@property(nonatomic, copy) NSString *communityName;
//小区来源
@property(nonatomic, copy) NSString *communityCompany;

//详细地址
@property(nonatomic, copy) NSString *address;
//楼栋Id
@property(nonatomic, copy) NSString *buildingUnitId;
//楼栋名称
@property(nonatomic, copy) NSString *buildingUnitName;
//楼栋来源
@property(nonatomic, copy) NSString *buildingCompany;

//房间 Id
@property(nonatomic, copy) NSString *houseId;
//门牌号，如：1702
@property(nonatomic, copy) NSString *houseNo;
//建筑面积
@property(nonatomic, copy) NSString *houseSpace;
//询值类型， 01-世联,02-仁达,03-首佳
@property(nonatomic, copy) NSString *companyStr;


- (NSDictionary *)getRoomEvaluateParams;
@end