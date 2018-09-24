//
//  HJDHomeRoomDiDaiTableViewCell.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/24.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJDHomeRoomDiDaiTableViewCell : UITableViewCell
//输入框
@property(nonatomic, strong) UITextField *textField;
//左侧标题
@property(nonatomic, strong) UILabel *leftLabel;
//右侧图片
@property(nonatomic, strong) UIImageView *rightImgView;
//右侧label
@property(nonatomic, strong) UILabel *rightLabel;

@property(nonatomic, strong) UIView *lineView;

@property(nonatomic, copy) NSString *placeholderString;
@end
