//
//  HJDMyInviteCodeView.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/6.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMyInviteCodeView.h"
@interface HJDMyShareButton : UIButton
@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UILabel *label;
@end

@implementation HJDMyShareButton
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textColor = kBlack;
        _label.font = kFont14;
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.imgView];
        [self addSubview:self.label];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(@40);
        }];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.imgView.mas_bottom).offset(5);
            make.height.equalTo(@20);
        }];
    }
    return self;
}
@end

@interface HJDMyInviteCodeView()
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) HJDMyShareButton *weixinButton;
@property(nonatomic, strong) HJDMyShareButton *circelButton;
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

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = kBlack;
        _nameLabel.font = kFont16;
    }
    return _nameLabel;
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

- (HJDMyShareButton *)weixinButton {
    if (!_weixinButton) {
        _weixinButton = [HJDMyShareButton buttonWithType:UIButtonTypeCustom];
        _weixinButton.imgView.image = kImage(@"qr.png");
        _weixinButton.label.text = @"微信";
        [_weixinButton addTarget:self action:@selector(weixinButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weixinButton;
}

- (HJDMyShareButton *)circelButton {
    if (!_circelButton) {
        _circelButton = [HJDMyShareButton buttonWithType:UIButtonTypeCustom];
        _circelButton.imgView.image = kImage(@"qr.png");
        _circelButton.label.text = @"朋友圈";
        [_circelButton addTarget:self action:@selector(circelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _circelButton;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kRGBA_Color(80, 80, 80, 0.3);
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [self addGestureRecognizer:tapGesture];
        
        [self setUpUI];
        
        self.bgView.layer.masksToBounds = YES;
        self.bgView.layer.cornerRadius = 8.f;
    }
    return self;
}

- (void)setUpUI {
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.headImgView];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.cityLabel];
    [self.bgView addSubview:self.QrCodeImgView];
    [self.bgView addSubview:self.weixinButton];
    [self.bgView addSubview:self.circelButton];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(65);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.height.equalTo(@(20 + 50 + 25 + (kScreenWidth - 90 - 40) + 20 + 65 + 15));
    }];
    
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(20);
        make.top.equalTo(self.bgView).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImgView.mas_right).offset(8);
        make.top.equalTo(self.headImgView).offset(10);
        make.right.equalTo(self.bgView).offset(-10);
        make.height.equalTo(@15);
    }];
    
    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImgView.mas_right).offset(8);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.right.equalTo(self.bgView).offset(-10);
        make.height.equalTo(@20);
    }];
    
    [self.QrCodeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(45);
        make.right.equalTo(self.bgView).offset(-45);
        make.top.equalTo(self.headImgView.mas_bottom).offset(25);
        make.height.equalTo(@(kScreenWidth - 90 - 40));
    }];
    
    [self.weixinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_centerX).offset(-20);
        make.top.equalTo(self.QrCodeImgView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(45, 65));
    }];
    
    [self.circelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView.mas_centerX).offset(20);
        make.top.equalTo(self.QrCodeImgView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(45, 65));
    }];
    
}

- (void)weixinButtonClick:(id)sender {
    [self removeFromSuperview];
}

- (void)circelButtonClick:(id)sender {
    [self removeFromSuperview];
}

- (void)tapClick:(id)sender {
    [self removeFromSuperview];
}

@end
