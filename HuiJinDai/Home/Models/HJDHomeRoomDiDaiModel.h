//
//  HJDHomeRoomDiDaiModel.h
//  HuiJinDai
//
//  Created by GXW on 2018/9/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDBaseModel.h"

typedef enum : NSUInteger {
    HJDRoomUse_house = 1,    //住宅
    HJDRoomUse_villa,       //别墅
} HJDRoomUseType;

typedef enum : NSUInteger {
    HJDRoomModelClear_communit = 0,
    HJDRoomModelClear_building,
    HJDRoomModelClear_unit,
    HJDRoomModelClear_house,
} HJDRoomModelClearType;

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
@property(nonatomic, copy) NSString *buildingId;
//楼栋名称
@property(nonatomic, copy) NSString *buildingName;
//楼栋来源
@property(nonatomic, copy) NSString *buildingCompany;

//单元Id
@property(nonatomic, copy) NSString *unitId;
//单元名称
@property(nonatomic, copy) NSString *unitName;
//单元来源
@property(nonatomic, copy) NSString *unitCompany;

//房间 Id
@property(nonatomic, copy) NSString *houseId;
//门牌号，如：1702
@property(nonatomic, copy) NSString *houseNo;
@property(nonatomic, copy) NSString *houseCompany;
//建筑面积
@property(nonatomic, copy) NSString *houseSpace;
//询值类型， 01-世联,02-仁达,03-首佳  (当前只询世联一家)
@property(nonatomic, copy) NSString *companyStr;
//规划用途 1住宅 2别墅[Default: 1]
@property(nonatomic, assign) HJDRoomUseType planning;

- (NSDictionary *)getRoomEvaluateParams;

- (void)clearRoomModelType:(HJDRoomModelClearType)clearType;
@end
