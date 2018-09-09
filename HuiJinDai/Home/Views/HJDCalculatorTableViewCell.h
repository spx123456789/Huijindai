//
//  HJDCalculatorTableViewCell.h
//  HuiJinDai
//
//  Created by SHANPX on 2018/9/9.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJDCalculatorTableViewCell : UITableViewCell
//输入框
@property (nonatomic, strong) UITextField *textField;
//标题
@property (nonatomic, strong) UILabel *titleLabel;
//右侧图片
@property (nonatomic, strong) UIImageView *moreImageView;
//右侧label
@property (nonatomic, strong) UILabel *subLabel;
@end
