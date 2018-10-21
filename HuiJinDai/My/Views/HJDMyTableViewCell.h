//
//  HJDMyTableViewCell.h
//  HuiJinDai
//
//  Created by GXW on 2018/9/1.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJDMyTableViewCell : UITableViewCell
@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UILabel *titleLabel;
@end

@interface HJDMyTableHeaderView : UIView
@property(nonatomic, strong) UIImageView *headImgView;
@property(nonatomic, strong) UILabel *nameLabel;
@end
