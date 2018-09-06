//
//  HJDMyInviteCodeView.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/6.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMyInviteCodeView.h"

@interface HJDMyInviteCodeView()
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIImageView *headImgView;
@property(nonatomic, strong) UILabel *channelLabel;
@property(nonatomic, strong) UILabel *cityLabel;
@property(nonatomic, strong) UIImageView *QrCodeImgView;
@end

@implementation HJDMyInviteCodeView

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = kWithe;
    }
    return _bgView;
}

- (UIImageView *)headImgView {
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc] init];
    }
    return _headImgView;
}

- (UILabel *)channelLabel {
    if (!_channelLabel) {
        _channelLabel = [[UILabel alloc] init];
        _channelLabel.textColor = kBlack;
        _channelLabel.font = kFont16;
    }
    return _channelLabel;
}

- (UILabel *)cityLabel {
    if (!_cityLabel) {
        _cityLabel = [[UILabel alloc] init];
        _cityLabel.textColor = kBlack;
        _cityLabel.font = kFont14;
    }
    return _cityLabel;
}

- (UIImageView *)QrCodeImgView {
    if (!_QrCodeImgView) {
        _QrCodeImgView = [[UIImageView alloc] init];
    }
    return _QrCodeImgView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setUpUI {
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.headImgView];
    [self.bgView addSubview:self.channelLabel];
    [self.bgView addSubview:self.cityLabel];
    [self.bgView addSubview:self.QrCodeImgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@(10 + 60 + 35 + (kScreenWidth - 50 - 20) + 35));
    }];
    
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(20);
        make.top.equalTo(self.bgView).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.channelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImgView.mas_right).offset(8);
        make.top.equalTo(self.headImgView).offset(10);
        make.right.equalTo(self.bgView).offset(-10);
        make.height.equalTo(@15);
    }];
    
    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImgView.mas_right).offset(8);
        make.top.equalTo(self.channelLabel.mas_bottom).offset(10);
        make.right.equalTo(self.bgView).offset(-10);
        make.height.equalTo(@20);
    }];
    
    [self.QrCodeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(55);
        make.right.equalTo(self.bgView).offset(-55);
        make.top.equalTo(self.headImgView.mas_bottom).offset(25);
        make.height.equalTo(@(kScreenWidth - 110 - 80));
    }];
    
    
}

@end
