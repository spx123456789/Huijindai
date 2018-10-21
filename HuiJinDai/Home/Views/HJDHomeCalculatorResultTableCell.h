//
//  HJDHomeCalculatorResultTableCell.h
//  HuiJinDai
//
//  Created by GXW on 2018/9/24.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeOrderDetailTableViewCell.h"

@interface HJDHomeCalculatorResultTableCell : HJDHomeOrderDetailTableViewCell
@property(nonatomic, strong) UILabel *firstLabel;
@property(nonatomic, strong) UILabel *firstLabel_1;
@property(nonatomic, strong) UILabel *twoLabel;
@property(nonatomic, strong) UILabel *twoLabel_1;
@property(nonatomic, strong) UILabel *threeLabel;
@property(nonatomic, strong) UILabel *threeLabel_1;
@property(nonatomic, strong) UILabel *fourLabel;
@property(nonatomic, strong) UILabel *fourLabel_1;
//默认隐藏
@property(nonatomic, strong) UILabel *statusLabel;
@property(nonatomic, strong) UIImageView *nextImgView;

- (void)setCellOfNumber:(NSInteger)number;

- (void)setStatusLabelSuccess:(BOOL)success;
@end
