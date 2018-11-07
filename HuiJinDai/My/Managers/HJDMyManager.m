//
//  HJDMyManager.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMyManager.h"
#import "HJDNetAPIManager.h"
#import "AFURLRequestSerialization.h"

@implementation HJDMyManager

+ (void)getMyRelationWithUrl:(NSString *)url keyWork:(NSString *)keyWord callBack:(void (^)(NSArray *, BOOL))callback {
    NSDictionary *param = nil;
    if (keyWord != nil) {
        param = @{ @"keywords" : keyWord };
    }
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(url) requestParams:param networkMethod:GET callback:^(NSDictionary *data, NSError *error) {
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

+ (void)getUserInviteCodeWithCallBack:(void (^)(NSDictionary *, BOOL))callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/User/get_qrcode") requestParams:nil networkMethod:GET callback:^(NSDictionary *data, NSError *error) {
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

+ (void)getMyInfoWithCallBack:(void (^)(NSDictionary *, BOOL))callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/User/get_info") requestParams:nil networkMethod:GET callback:^(NSDictionary *data, NSError *error) {
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

+ (void)setMyAvatarWithImage:(UIImage *)image callBack:(void (^)(NSString *, BOOL))callback {
    NSData *photo = UIImageJPEGRepresentation(image, 1);
    [[HJDNetAPIManager sharedManager] POST:kAPIURL(@"/User/set_avatar") parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:photo name:@"avatar" fileName:@"avatar" mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDic = (NSDictionary *)responseObject;
        callback([dataDic getObjectByPath:@"data/path"], YES);
        NSLog(@"===success %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(nil, NO);
        NSLog(@"===%@", error.userInfo);
    }];
}

+ (void)modifyMyInfoWithParams:(NSDictionary *)params callBack:(void (^)(BOOL))callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/User/set_info") requestParams:params networkMethod:POST callback:^(id data, NSError *error) {
        if (error) {
            callback(NO);
        } else {
            NSString *code = [data getObjectByPath:@"code"];
            if (code.integerValue == 0) {
                callback(YES);
            } else {
                callback(NO);
            }
        }
    }];
}

+ (void)postGeTuiCid:(NSString *)cid callback:(void (^)(BOOL))callback {
    [[HJDNetAPIManager sharedManager] requestWithPath:kAPIURL(@"/User/set_cid") requestParams:@{ @"client_id" : cid, @"phone" : @"13500001111" } networkMethod:POST callback:^(id data, NSError *error) {
        if (error) {
            callback(NO);
        } else {
            NSString *code = [data getObjectByPath:@"code"];
            if (code.integerValue == 0) {
                callback(YES);
            } else {
                callback(NO);
            }
        }
    }];
}

#pragma mark - 重新更新一下我的信息
+ (void)reUpdateMyInfo:(void (^)(BOOL))callback {
    [HJDMyManager getMyInfoWithCallBack:^(NSDictionary *dic, BOOL result) {
        if (result) {
            HJDUserModel *userModel = (HJDUserModel *)[[HJDUserDefaultsManager shareInstance] loadObject:kUserModelKey];
            userModel.avatar = dic[@"avatar"];
            userModel.rename = dic[@"rename"];
            userModel.addr_office_tree = dic[@"addr_office_tree"];
            [[HJDUserDefaultsManager shareInstance] saveObject:userModel key:kUserModelKey];
        }
        if (callback) {
            callback(YES);
        }
    }];
}
@end
