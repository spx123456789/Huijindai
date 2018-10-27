//
//  HJDHomeRoomDiDaiModel.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeRoomDiDaiModel.h"

@implementation HJDHomeRoomDiDaiModel

- (NSDictionary *)getRoomEvaluateParams {
    NSDictionary *dictionary = @{ @"provinceId" : self.provinceId,
                                  @"provinceName" : self.provinceName,
                                  @"cityId" : self.cityId,
                                  @"cityName" : self.cityName,
                                  @"districtId" : self.districtId,
                                  @"districtName" : self.districtName,
                                  @"communityId" : self.communityId,
                                  @"communityName" : self.communityName,
                                  @"address" : self.address,
                                  @"buildingUnitId" : self.buildingId,
                                  @"buildingUnitName" : self.buildingName,
                                  @"houseId" : self.houseId,
                                  @"houseNo" : self.houseNo,
                                  @"houseSpace" : self.houseSpace,
                                  @"companyStr" : self.companyStr
                                  };
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    [mutDic addEntriesFromDictionary:dictionary];
    
    if (self.planning != 0) {
        [mutDic setObject:@(self.planning) forKey:@"planning"];
    }
    return mutDic;
}

- (void)clearRoomModelType:(HJDRoomModelClearType)clearType {
    switch (clearType) {
        case HJDRoomModelClear_communit: {
            self.communityId = @"";
            self.communityName = @"";
            self.communityCompany = @"";
        }
        case HJDRoomModelClear_building: {
            self.buildingId = @"";
            self.buildingName = @"";
            self.buildingCompany = @"";
        }
        case HJDRoomModelClear_unit: {
            self.unitId = @"";
            self.unitName = @"";
            self.unitCompany = @"";
        }
        case HJDRoomModelClear_house: {
            self.houseId = @"";
            self.houseNo = @"";
            self.houseCompany = @"";
            break;
        }
        default:
            break;
    }
}
@end
