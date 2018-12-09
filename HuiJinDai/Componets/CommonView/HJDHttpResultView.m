//
//  HJDHttpResultView.m
//  HuiJinDai
//
//  Created by GXW on 2018/10/27.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHttpResultView.h"

@interface HJDHttpResultView()
@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UILabel *textLabel;
@property(nonatomic, strong) UILabel *subLabel;
@end

@implementation HJDHttpResultView

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithImage:kImage(@"暂无数据_03")];
    }
    return _imgView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.text = @"暂无数据";
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _textLabel.font = [UIFont boldSystemFontOfSize:17];
    }
    return _textLabel;
}

- (UILabel *)subLabel {
    if (!_subLabel) {
        _subLabel = [[UILabel alloc] init];
        _subLabel.text = @"点击刷新网络";
        _subLabel.textAlignment = NSTextAlignmentCenter;
        _subLabel.textColor = kMainColor;
        _subLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _subLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
        [self addSubview:self.imgView];
        [self addSubview:self.textLabel];
        [self addSubview:self.subLabel];
        
        @weakify(self);
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.size.mas_equalTo(CGSizeMake(97, 103));
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-20);
        }];
        
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.right.equalTo(self);
            make.height.equalTo(@17);
            make.top.equalTo(self.imgView.mas_bottom).offset(20);
        }];
        
        [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.right.equalTo(self);
            make.height.equalTo(@15);
            make.top.equalTo(self.textLabel.mas_bottom).offset(12);
        }];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [self.subLabel addGestureRecognizer:tapGes];
    }
    return self;
}

- (void)tapClick:(UITapGestureRecognizer *)sender {
    if (self.callBack) {
        self.callBack();
    }
}

- (void)setShowType:(HJDHttpResultType)showType {
    _showType = showType;
    if (showType == HJDHttpResultNoData) {
        self.imgView.image = kImage(@"暂无数据_03");
        self.textLabel.text = @"暂无数据";
        self.subLabel.hidden = YES;
    } else {
        self.imgView.image = kImage(@"暂无网络");
        self.textLabel.text = @"暂无网络";
        self.subLabel.hidden = NO;
    }
}

@end
