//
//  HJDHomeRoomDiDaiModel.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeRoomDiDaiModel.h"

@implementation HJDHomeRoomDiDaiModel

//- (NSString *)address {
//    return [NSString stringWithFormat:@"%@%@%@%@%@%@", self.provinceName, self.cityName, self.districtName, self.communityName, self.buildingUnitName, self.houseNo];
//}

- (NSDictionary *)getRoomEvaluateParams {
    return @{ @"provinceId" : self.provinceId, @"provinceName" : self.provinceName, @"cityId" : self.cityId, @"cityName" : self.cityName, @"districtId" : self.districtId, @"districtName" : self.districtName, @"communityId" : self.communityId, @"communityName" : self.communityName, @"address" : self.address, @"buildingUnitId" : self.buildingUnitId, @"buildingUnitName" : self.buildingUnitName, @"houseId" : self.houseId, @"houseNo" : self.houseNo, @"houseSpace" : self.houseSpace, @"companyStr" : self.companyStr
              };
}
@end
