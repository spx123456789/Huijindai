//
//  HJDHomeRoomDiDaiManager.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeRoomDiDaiManager.h"
#import "HJDNetAPIManager.h"
#import "HJDNetAPIManager2.h"
#import "UIImage+HJD.h"
#import "HJDUserDefaultsManager.h"
#import "HJDUserModel.h"

@implementation HJDHomeRoomDiDaiManager

+ (void)getShengListCallBack:(RoomDiDaiHttpCallback)callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/sheng") requestParams:nil networkMethod:GET callback:^(NSDictionary *data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            NSString *code = [data getObjectByPath:@"code"];
            if (code.integerValue == 0) {
                callback([data getObjectByPath:@"data/list"], YES);
            } else {
                callback(nil, NO);
            }
        }
    }];
}

+ (void)getShiListWithShengId:(NSString *)shengId CallBack:(RoomDiDaiHttpCallback)callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/shi") requestParams:@{ @"code" : shengId } networkMethod:GET callback:^(NSDictionary *data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            NSString *code = [data getObjectByPath:@"code"];
            if (code.integerValue == 0) {
                callback([data getObjectByPath:@"data/child"], YES);
            } else {
                callback(nil, NO);
            }
        }
    }];
}

+ (void)getQuListWithShengId:(NSString *)shengId shiId:(NSString *)shiId CallBack:(RoomDiDaiHttpCallback)callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/qu") requestParams:@{@"code" : shengId, @"code_shi" : shiId } networkMethod:GET callback:^(NSDictionary *data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            NSString *code = [data getObjectByPath:@"code"];
            if (code.integerValue == 0) {
                callback([data getObjectByPath:@"data/child"], YES);
            } else {
                callback(nil, NO);
            }
        }
    }];
}

+ (NSURLSessionDataTask *)getXiaoquListWithShiId:(NSString *)shiId quId:(NSString *)quId keyWord:(NSString *)keyWord CallBack:(RoomDiDaiHttpCallback)callback {
    return [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/community") requestParams:@{ @"shi" : shiId, @"qu" : quId, @"community" : keyWord } networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            NSString *code = [data getObjectByPath:@"code"];
            if (code.integerValue == 0) {
                callback([data getObjectByPath:@"data/list"], YES);
            } else {
                callback(nil, NO);
            }
        }
    }];
}

+ (NSURLSessionDataTask *)getLouDongListWithModel:(HJDHomeRoomDiDaiModel *)model keyWord:(NSString *)keyWord CallBack:(RoomDiDaiHttpCallback)callback {
    return [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/building") requestParams:@{ @"qu" : model.districtId, @"community_id" : model.communityId, @"building" : keyWord, @"companyStr" : model.communityCompany } networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            NSString *code = [data getObjectByPath:@"code"];
            if (code.integerValue == 0) {
                callback([data getObjectByPath:@"data/list"], YES);
            } else {
                callback(nil, NO);
            }
        }
    }];
}

+ (NSURLSessionDataTask *)getDanYuanListWithModel:(HJDHomeRoomDiDaiModel *)model keyWord:(NSString *)keyWord CallBack:(RoomDiDaiHttpCallback)callback {
    return [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/unit") requestParams:@{ @"qu" : model.districtId, @"community_id" : model.communityId, @"building_id" : model.buildingId, @"unit" : keyWord, @"companyStr" : model.communityCompany } networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            NSString *code = [data getObjectByPath:@"code"];
            if (code.integerValue == 0) {
                callback([data getObjectByPath:@"data/list"], YES);
            } else {
                callback(nil, NO);
            }
        }
    }];
}

+ (NSURLSessionDataTask *)getMenPaiListWithModel:(HJDHomeRoomDiDaiModel *)model keyWord:(NSString *)keyWord CallBack:(RoomDiDaiHttpCallback)callback {
    
    NSMutableDictionary *mutParam = [NSMutableDictionary dictionaryWithDictionary:@{ @"qu" : model.districtId, @"community_id" : model.communityId, @"building_id" : model.buildingId, @"building" : model.buildingName, @"house" : keyWord, @"companyStr" : model.communityCompany }];
    
    if (![NSString hjd_isBlankString:model.unitId]) {
        [mutParam setObject:model.unitId forKey:@"unit_id"];
    }
    
    if (![NSString hjd_isBlankString:model.unitName]) {
        [mutParam setObject:model.unitName forKey:@"unit"];
    }
    
    return [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/house") requestParams:mutParam networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            NSString *code = [data getObjectByPath:@"code"];
            if (code.integerValue == 0) {
                callback([data getObjectByPath:@"data/list"], YES);
            } else {
                callback(nil, NO);
            }
        }
    }];
}

+ (void)postRoomEvaluateWithModel:(HJDHomeRoomDiDaiModel *)model callBack:(void (^)(NSDictionary *, BOOL))callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/evaluate") requestParams:[model getRoomEvaluateParams] networkMethod:POST callback:^(NSDictionary *data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            NSString *code = [data getObjectByPath:@"code"];
            if (code.integerValue == 0) {
                callback(data, YES);
            } else {
                if ([[data getObjectByPath:@"string_code"] isEqualToString:@"ERROR_USER"]) {
                    callback( @{ @"1" : @"ERROR_USER" }, NO);
                } else {
                    callback(nil, NO);
                }
            }
        }
    }];
}

+ (void)getRoomEvaluateListWithPage:(NSInteger)page callBack:(RoomDiDaiHttpCallback)callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/get_list") requestParams:@{ @"p0" : [NSString stringWithFormat:@"%ld", (long)page]} networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            NSString *code = [data getObjectByPath:@"code"];
            if (code.integerValue == 0) {
                callback([data getObjectByPath:@"data/list"], YES);
            } else {
                callback(nil, NO);
            }
        }
    }];
}

+ (void)getRoomEvaluateInfoWithXunid:(NSString *)xun_id callBack:(void (^)(NSDictionary *, BOOL))callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/get_price") requestParams:@{ @"xun_id" : xun_id } networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            NSString *code = [data getObjectByPath:@"code"];
            if (code.integerValue == 0) {
                callback([data getObjectByPath:@"data"], YES);
            } else {
                callback(nil, NO);
            }
        }
    }];
}

+ (void)getNewRoomEvaluateInfoWithXunid:(NSString *)xun_id company:(NSString *)company callBack:(void (^)(NSDictionary *, BOOL))callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Assessment/get_newprice") requestParams:@{ @"xun_id" : xun_id, @"companyStr" : company } networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            NSArray *dataArray = [data getObjectByPath:@"data/list"];
            if (dataArray && dataArray.count > 0) {
                callback(data, YES);
            } else {
                if ([[data getObjectByPath:@"string_code"] isEqualToString:@"ERROR_USER"]) {
                    callback( @{ @"1" : @"ERROR_USER" }, NO);
                } else {
                    callback(nil, NO);
                }
            }
        }
    }];
}

#pragma mark - 工单
+ (void)getOrderIdWithCallBack:(void (^)(NSDictionary *, BOOL))callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Loan/sq") requestParams:nil networkMethod:GET callback:^(NSDictionary *data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            NSString *code = [data getObjectByPath:@"code"];
            if (code.integerValue == 0) {
                callback([data getObjectByPath:@"data"], YES);
            } else {
                callback(nil, NO);
            }
        }
    }];
}

+ (void)getOrderFileWithCallBack:(void (^)(NSArray *, BOOL))callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Loan/get_file_type") requestParams:nil networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            NSString *code = [data getObjectByPath:@"code"];
            if (code.integerValue == 0) {
                callback([data getObjectByPath:@"data/list"], YES);
            } else {
                callback(nil, NO);
            }
        }
    }];
}

+ (void)postRoomDeclarationWithModel:(HJDDeclarationModel *)model callBack:(void (^)(NSDictionary *, BOOL))callback {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSDictionary *needDic = @{ @"loan_id" : model.loan_id,
                            @"loan_variety" : @(model.loan_variety),
                            @"loan_money" : model.loan_money,
                            @"loan_time" : model.loan_time,
                            @"loan_time_type" : @(model.loan_time_type) };
    [params addEntriesFromDictionary:needDic];
    
    
    if (model.loan_variety == HJDLoanVarietyHouse_2) {
        [params setObject:model.loan_first forKey:@"loan_first"];
    }
    
    /*
     evaluation_id [选填]寻值编号[Default：0]
     name [选填]客户姓名
     certificate_type [选填]证件类型，1身份证，2营业执照，3护照，4军官证，5士兵证，6港澳居民来往内地通行证，台湾居民来往大陆通行证，8其他证件
     certificate_number [选填]证件号码
     indiv_marital [选填]婚姻情况，1未婚，2已婚有子女，3已婚无子女，4丧偶，5离异，6再婚
     */
    if (![NSString hjd_isBlankString:model.evaluation_id]) {
        [params setObject:model.evaluation_id forKey:@"evaluation_id"];
    }
    
    if (![NSString hjd_isBlankString:model.name]) {
        [params setObject:model.name forKey:@"name"];
    }
    
    if (model.certificate_type == 0) {
        [params setObject:@(model.certificate_type) forKey:@"certificate_type"];
    }
    
    if (![NSString hjd_isBlankString:model.certificate_number]) {
        [params setObject:model.certificate_number forKey:@"certificate_number"];
    }
    
    if (model.indiv_marital == 0) {
        [params setObject:@(model.indiv_marital) forKey:@"indiv_marital"];
    }
    
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Loan/create") requestParams:params networkMethod:POST callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            NSString *code = [data getObjectByPath:@"code"];
            if (code.integerValue == 0) {
                NSLog(@"====文字成功 %@", params);
                [HJDHomeRoomDiDaiManager uploadPictureWithModel:model callBack:callback];
            } else {
                callback(nil, NO);
            }
        }
    }];
}

+ (void)getOrderDetailWithID:(NSString *)uid from:(NSString *)from callBack:(void (^)(NSDictionary *, BOOL))callback {
    HJDUserModel *userModel = (HJDUserModel *)[[HJDUserDefaultsManager shareInstance] loadObject:kUserModelKey];
    [[HJDNetAPIManager2 sharedManager] setAuthorization:userModel.token];
    [[HJDNetAPIManager2 sharedManager] requestWithPath:kAPIURL(@"/Loan/get_info") requestParams:@{ @"loan_id" : uid, @"loan_from" : from } networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            NSString *code = [data getObjectByPath:@"code"];
            if (code.integerValue == 0) {
                callback([data getObjectByPath:@"data"], YES);
            } else {
                callback(nil, NO);
            }
        }
    }];
}

+ (void)auditOrderWithID:(NSString *)uid step:(NSString *)step content:(NSString *)content managerId:(NSString *)managerId callBack:(void (^)(NSString *, BOOL))callback {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{ @"loan_id" : uid, @"step" : step }];
    if (step.integerValue == 2) {
        [params setObject:content forKey:@"content"];
    }
    
    if (![NSString hjd_isBlankString:managerId]) {
        [params setObject:managerId forKey:@"jingli_id"];
    }
    
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/Loan/examine") requestParams:params networkMethod:GET callback:^(id data, NSError *error) {
        if (error) {
            callback(nil, NO);
        } else {
            NSString *code = [data getObjectByPath:@"code"];
            if (code.integerValue == 0) {
                callback(nil, YES);
            } else {
                callback([data getObjectByPath:@"error_msg"] ,NO);
            }
        }
    }];
}

#pragma mark - 上传图片
static NSString *key1 = @"pictype";
static NSString *key2 = @"imageInfo";
+ (void)uploadPictureWithModel:(HJDDeclarationModel *)model callBack:(void (^)(NSDictionary *, BOOL))callback {
    //@[ @{ @"pictype" : pictype, @"imageInfo" : imageInfo } ]
    NSMutableArray *imageArray = [NSMutableArray array];
    
    for (NSDictionary *tempDic in model.fileMutArray) {
        NSMutableArray *tempImageArray = tempDic[kDeclarationLoanFileImage];
        if (tempImageArray.count > 0) {
            for (NSDictionary *imageInfo in tempImageArray) {
                [imageArray addObject:@{ key1 : tempDic[kDeclarationLoanFileType], key2 : imageInfo }];
            }
        }
    }
    
    NSLog(@"====开始上传图片 %lu", (unsigned long)imageArray.count);
    if (imageArray.count == 0) {
        callback(nil, YES);
    }
    
    __block NSInteger totalCount = 0;
    __block NSInteger uploadCount = 0;
    for (NSDictionary *dic in imageArray) {
        NSDictionary *imageInfo = dic[key2];
        UIImage *image = imageInfo[UIImagePickerControllerEditedImage];
        [HJDHomeRoomDiDaiManager uploadSinglePicture:image loanId:model.loan_id picType:dic[key1] uploadResult:^(BOOL result) {
            totalCount += 1;
            if (result) {
                uploadCount += 1;
                if (totalCount == imageArray.count) {
                    if (totalCount == uploadCount) {
                        NSLog(@"====上传图片成功 %lu", (unsigned long)uploadCount);
                        callback(nil, YES);
                    } else {
                        NSLog(@"====上传图片失败 %lu", (unsigned long)uploadCount);
                        callback(nil, NO);
                    }
                }
            } else {
                if (totalCount == imageArray.count) {
                    NSLog(@"====开始上传图片失败 %lu", (unsigned long)uploadCount);
                    callback(nil, NO);
                }
            }
        }];
    }
}

+ (void)uploadSinglePicture:(UIImage *)image loanId:(NSString *)loanId picType:(NSString *)picType uploadResult:(void (^)(BOOL result))callback {
    NSData *photoData = [image compressedImage];
    NSDictionary *params = @{ @"loan_id" : loanId, @"type_id" : picType };
    
    [[HJDNetAPIManager sharedManager] POST:kAPIURL(@"/Loan/upload_file") parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString * fileName = [NSString stringWithFormat:@"%@.jpg",[NSDate date]];
        [formData appendPartWithFileData:photoData name:@"file" fileName:fileName mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传成功----%@", responseObject);
        callback(YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(NO);
    }];
}

@end
