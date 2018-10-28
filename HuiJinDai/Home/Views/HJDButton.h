//
//  HJDButton.h
//  HuiJinDai
//
//  Created by SHANPX on 2018/9/6.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJDButton : UIView
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, assign) NSInteger unreadCount;
@end
