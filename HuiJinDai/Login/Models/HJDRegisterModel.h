//
//  HJDRegisterModel.h
//  HuiJinDai
//
//  Created by GXW on 2018/8/31.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDBaseModel.h"

@interface HJDRegisterModel : NSObject

@end

@interface HJDCityModel : HJDBaseModel
@property(nonatomic, copy) NSString *pid;
@property(nonatomic, copy) NSString *code;
@property(nonatomic, copy) NSString *name;

@end
