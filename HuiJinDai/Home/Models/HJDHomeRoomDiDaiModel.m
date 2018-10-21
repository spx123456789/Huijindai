//
//  HJDHomeRoomDiDaiModel.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/30.
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
                                  @"houseSpace" : self.houseSpace,
                                  @"companyStr" : self.companyStr
                                  };
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    [mutDic addEntriesFromDictionary:dictionary];
    
    if ([NSString hjd_isBlankString:self.buildingUnitId]) {
        [mutDic setObject:@"1" forKey:@"buildingUnitId"];
        [mutDic setObject:@"一单元" forKey:@"buildingUnitName"];
    } else {
        [mutDic setObject:self.buildingUnitId forKey:@"buildingUnitId"];
        [mutDic setObject:self.buildingUnitName forKey:@"buildingUnitName"];
    }
    
    if ([NSString hjd_isBlankString:self.houseId]) {
        [mutDic setObject:@"1" forKey:@"houseId"];
        [mutDic setObject:@"1" forKey:@"houseNo"];
    } else {
        [mutDic setObject:self.houseId forKey:@"houseId"];
        [mutDic setObject:self.houseNo forKey:@"houseNo"];
    }
    
    if (self.planning != 0) {
        [mutDic setObject:@(self.planning) forKey:@"planning"];
    }
    return mutDic;
}
@end
