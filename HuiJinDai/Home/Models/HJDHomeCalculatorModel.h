//
//  HJDHomeCalculatorModel.h
//  HuiJinDai
//
//  Created by GXW on 2018/10/21.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDBaseModel.h"

@interface HJDHomeCalculatorModel : HJDBaseModel
@property(nonatomic, copy) NSString *money;
@property(nonatomic, copy) NSString *month;
@property(nonatomic, copy) NSString *start_date;
@property(nonatomic, copy) NSString *end_date;
@property(nonatomic, copy) NSString *lilv; //利率
@property(nonatomic, copy) NSString *lixi; //利息
@end

