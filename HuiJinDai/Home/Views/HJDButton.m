//
//  HJDButton.m
//  HuiJinDai
//
//  Created by SHANPX on 2018/9/6.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDButton.h"

@interface HJDButton()
@property(nonatomic, strong) UILabel *unreadCountLabel;
@end

@implementation HJDButton

- (UILabel *)unreadCountLabel {
    if (!_unreadCountLabel) {
        _unreadCountLabel = [[UILabel alloc] init];
        _unreadCountLabel.text = @"99";
        _unreadCountLabel.textColor = kRGB_Color(0xff, 0xff, 0xff);
        _unreadCountLabel.font = kFont10;
        _unreadCountLabel.backgroundColor = [UIColor redColor];
        _unreadCountLabel.textAlignment = NSTextAlignmentCenter;
        _unreadCountLabel.layer.masksToBounds = YES;
        _unreadCountLabel.layer.cornerRadius = 8.f;
    }
    return _unreadCountLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.height.mas_equalTo(44);
            make.top.mas_equalTo(self.mas_top).offset(20);
        }];
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(frame.size.width);
            make.height.mas_equalTo(14);
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(12);
        }];
        
        [self addSubview:self.unreadCountLabel];
        [self.unreadCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.imageView.mas_top).offset(7);
            make.left.equalTo(self.imageView.mas_right).offset(-9);
            make.size.mas_equalTo(CGSizeMake(16, 16));
        }];
        
        self.unreadCountLabel.hidden = YES;
    }
    return self;
}

- (void)setUnreadCount:(NSInteger)unreadCount {
    _unreadCount = unreadCount;
    if (unreadCount == 0) {
        self.unreadCountLabel.hidden = YES;
    } else {
        self.unreadCountLabel.hidden = NO;
        if (unreadCount > 99) {
            self.unreadCountLabel.text = @"..";
        } else {
            self.unreadCountLabel.text = [NSString stringWithFormat:@"%ld", (long)unreadCount];
        }
    }
}
@end
