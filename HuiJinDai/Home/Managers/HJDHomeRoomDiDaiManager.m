//
//  HJDHomeRoomDiDaiManager.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeRoomDiDaiManager.h"
#import "HJDNetAPIManager.h"

@implementation HJDHomeRoomDiDaiManager

+ (void)getShengListCallBack:(RoomDiDaiHttpCallback)callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/sheng") requestParams:nil networkMethod:GET callback:^(NSDictionary *data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            callback([data getObjectByPath:@"data/list"], YES);
        }
    }];
}

+ (void)getShiListWithShengId:(NSString *)shengId CallBack:(RoomDiDaiHttpCallback)callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/shi") requestParams:@{ @"code" : shengId } networkMethod:GET callback:^(NSDictionary *data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            callback([data getObjectByPath:@"data/child"], YES);
        }
    }];
}

+ (void)getQuListWithShengId:(NSString *)shengId shiId:(NSString *)shiId CallBack:(RoomDiDaiHttpCallback)callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/qu") requestParams:@{@"code" : shengId, @"code_shi" : shiId } networkMethod:GET callback:^(NSDictionary *data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            callback([data getObjectByPath:@"data/child"], YES);
        }
    }];
}

+ (void)getXiaoquListWithShiId:(NSString *)shiId quId:(NSString *)quId keyWord:(NSString *)keyWord CallBack:(RoomDiDaiHttpCallback)callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/community") requestParams:@{ @"shi" : shiId, @"qu" : quId, @"community" : keyWord } networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            callback([data getObjectByPath:@"data/list"], YES);
        }
    }];
}

+ (void)getLouDongListWithModel:(HJDHomeRoomDiDaiModel *)model keyWord:(NSString *)keyWord CallBack:(RoomDiDaiHttpCallback)callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/building") requestParams:@{ @"qu" : model.districtId, @"community_id" : model.communityId, @"building" : keyWord, @"companyStr" : model.communityCompany } networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            callback([data getObjectByPath:@"data/list"], YES);
        }
    }];
}

+ (void)getDanYuanListWithModel:(HJDHomeRoomDiDaiModel *)model keyWord:(NSString *)keyWord CallBack:(RoomDiDaiHttpCallback)callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/unit") requestParams:@{ @"qu" : model.districtId, @"community_id" : model.communityId, @"building_id" : model.buildingUnitId, @"unit" : keyWord, @"companyStr" : model.buildingCompany } networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            callback([data getObjectByPath:@"data/list"], YES);
        }
    }];
}

+ (void)getMenPaiListWithModel:(HJDHomeRoomDiDaiModel *)model keyWord:(NSString *)keyWord CallBack:(RoomDiDaiHttpCallback)callback {
    /*
     unit_id    string 单元编号[选填]
     unit    string 单元名称[选填]
     companyStr 字段有问题
     */
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/house") requestParams:@{ @"qu" : model.districtId, @"community_id" : model.communityId, @"building_id" : model.buildingUnitId, @"building" : model.buildingUnitName, @"house" : keyWord, @"companyStr" : model.communityCompany } networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            callback([data getObjectByPath:@"data/list"], YES);
        }
    }];
}

+ (void)postRoomEvaluateWithModel:(HJDHomeRoomDiDaiModel *)model callBack:(RoomDiDaiHttpCallback)callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/evaluate") requestParams:[model getRoomEvaluateParams] networkMethod:POST callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            callback([data getObjectByPath:@"data/list"], YES);
        }
    }];
}

+ (void)getRoomEvaluateListWithCallBack:(RoomDiDaiHttpCallback)callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/get_list") requestParams:nil networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            callback([data getObjectByPath:@"data/list"], YES);
        }
    }];
}

+ (void)getRoomEvaluateInfoWithXunid:(NSString *)xun_id callBack:(RoomDiDaiHttpCallback)callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/get_price") requestParams:@{ @"xun_id" : xun_id } networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            callback([data getObjectByPath:@"data/list"], YES);
        }
    }];
}

#pragma mark - 工单
+ (void)getOrderIdWithCallBack:(void (^)(NSDictionary *, BOOL))callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Loan/sq") requestParams:nil networkMethod:GET callback:^(NSDictionary *data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            callback([data getObjectByPath:@"data"], YES);
        }
    }];
}

+ (void)postRoomDeclarationWithModel:(HJDDeclarationModel *)model callBack:(void (^)(NSDictionary *, BOOL))callback {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (![NSString hjd_isBlankString:model.evaluation_id]) {
        [params setObject:model.evaluation_id forKey:@"evaluation_id"];
    }
    if (model.loan_variety == HJDLoanVarietyHouse_2) {
        [params setObject:model.loan_first forKey:@"loan_first"];
    }
    [params addEntriesFromDictionary:@{ @"loan_id" : model.loan_id, @"name" : model.name, @"certificate_type" : @(model.certificate_type), @"certificate_number" : model.certificate_number, @"indiv_marital" : @(model.indiv_marital), @"loan_variety" : @(model.loan_variety), @"loan_money" : model.loan_money, @"loan_time" : model.loan_time, @"loan_time_type" : @(model.loan_time_type) }];
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Loan/create") requestParams:params networkMethod:POST callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            NSLog(@"====文字成功");
            [HJDHomeRoomDiDaiManager uploadPictureWithModel:model callBack:callback];
        }
    }];
}

+ (void)getOrderDetailWithID:(NSString *)uid callBack:(void (^)(NSDictionary *, BOOL))callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Loan/get_info") requestParams:@{ @"loan_id" : uid } networkMethod:GET callback:^(id data, NSError *error) {
        
    }];
}

#pragma mark - 上传图片
+ (void)uploadPictureWithModel:(HJDDeclarationModel *)model callBack:(void (^)(NSDictionary *, BOOL))callback {
    NSMutableArray *imageArray = [NSMutableArray array];
    NSString *pic_type = @"";
    if (model.idCardArray && model.idCardArray.count != 0) {
        [imageArray addObjectsFromArray:model.idCardArray];
        pic_type = @"1";
    }
    
    if (model.bookArray && model.bookArray.count != 0) {
        [imageArray addObjectsFromArray:model.bookArray];
        pic_type = @"2";
    }
    
    if (model.creditReportArray && model.creditReportArray.count != 0) {
        [imageArray addObjectsFromArray:model.creditReportArray];
        pic_type = @"3";
    }
    
    if (model.marriageArray && model.marriageArray.count != 0) {
        [imageArray addObjectsFromArray:model.marriageArray];
        pic_type = @"4";
    }
    
    if (model.houseArry && model.houseArry.count != 0) {
        [imageArray addObjectsFromArray:model.houseArry];
        pic_type = @"5";
    }
    
    if (imageArray.count == 0) {
        callback(nil, YES);
    }
    
    __block NSInteger totalCount = 0;
    __block NSInteger uploadCount = 0;
    for (NSDictionary *dic in imageArray) {
        UIImage *image = dic[UIImagePickerControllerEditedImage];
        NSData *photo = UIImageJPEGRepresentation(image, 1);
        NSDictionary *params = @{ @"loan_id" : model.loan_id, @"type_id" : pic_type };
        [[HJDNetAPIManager sharedManager] POST:kAPIURL(@"/Loan/upload_file") parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:photo name:@"file" fileName:@"file" mimeType:@"image/jpg"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            totalCount += 1;
            uploadCount += 1;
            if (totalCount == imageArray.count) {
                if (totalCount == uploadCount) {
                    callback(nil, YES);
                } else {
                    callback(nil, NO);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            totalCount += 1;
            if (totalCount == imageArray.count) {
                callback(nil, NO);
            }
        }];
    }
    
}
@end
