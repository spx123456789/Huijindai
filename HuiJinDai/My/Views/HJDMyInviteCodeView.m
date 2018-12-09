//
//  HJDMyInviteCodeView.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/6.
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
        _label.textColor = kRGB_Color(0x66, 0x66, 0x66);
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
            make.centerX.top.equalTo(self);
            make.height.equalTo(@40);
            make.width.equalTo(@40);
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
@property(nonatomic, strong) UILabel *inviteCodeLabel;
//@property(nonatomic, strong) HJDMyShareButton *weixinButton;
//@property(nonatomic, strong) HJDMyShareButton *circelButton;
@property(nonatomic, strong) UIButton *copyButton;
@end

@implementation HJDMyInviteCodeView

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = kRGB_Color(0xff, 0xff, 0xff);
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
        _nameLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _nameLabel.font = [UIFont boldSystemFontOfSize:17];
    }
    return _nameLabel;
}

- (UILabel *)cityLabel {
    if (!_cityLabel) {
        _cityLabel = [[UILabel alloc] init];
        _cityLabel.textColor = kRGB_Color(0x99, 0x99, 0x99);
        _cityLabel.font = kFont15;
    }
    return _cityLabel;
}

- (UILabel *)inviteCodeLabel {
    if (!_inviteCodeLabel) {
        _inviteCodeLabel = [[UILabel alloc] init];
        _inviteCodeLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _inviteCodeLabel.font = [UIFont boldSystemFontOfSize:17];
        _inviteCodeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _inviteCodeLabel;
}

- (UIButton *)copyButton {
    if (!_copyButton) {
        _copyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_copyButton setTitle:@"复制分享链接" forState:UIControlStateNormal];
        [_copyButton setTitleColor:kRGB_Color(0xff, 0xff, 0xff) forState:UIControlStateNormal];
        [_copyButton setBackgroundColor:kMainColor];
        _copyButton.titleLabel.font = kFont15;
        _copyButton.layer.masksToBounds = YES;
        _copyButton.layer.cornerRadius = 4.f;
        [_copyButton addTarget:self action:@selector(copyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _copyButton;
}
//- (HJDMyShareButton *)weixinButton {
//    if (!_weixinButton) {
//        _weixinButton = [HJDMyShareButton buttonWithType:UIButtonTypeCustom];
//        _weixinButton.imgView.image = kImage(@"邀请码微信");
//        _weixinButton.label.text = @"微信";
//        [_weixinButton addTarget:self action:@selector(weixinButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _weixinButton;
//}
//
//- (HJDMyShareButton *)circelButton {
//    if (!_circelButton) {
//        _circelButton = [HJDMyShareButton buttonWithType:UIButtonTypeCustom];
//        _circelButton.imgView.image = kImage(@"邀请码朋友圈");
//        _circelButton.label.text = @"朋友圈";
//        [_circelButton addTarget:self action:@selector(circelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _circelButton;
//}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kRGBA_Color(0x00, 0x00, 0x00, 0.4);
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
    [self.bgView addSubview:self.inviteCodeLabel];
    [self.bgView addSubview:self.copyButton];
    //[self.bgView addSubview:self.weixinButton];
    //[self.bgView addSubview:self.circelButton];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(130);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(292, 309));
    }];
    
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(24);
        make.top.equalTo(self.bgView).offset(24);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImgView.mas_right).offset(16);
        make.top.equalTo(self.headImgView).offset(8);
        make.right.equalTo(self.bgView).offset(-24);
        make.height.equalTo(@20);
    }];
    
    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImgView.mas_right).offset(16);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(12);
        make.right.equalTo(self.bgView).offset(-24);
        make.height.equalTo(@20);
    }];
    
    [self.inviteCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(24);
        make.right.equalTo(self.bgView).offset(-24);
        make.centerY.equalTo(self.bgView);
        make.height.equalTo(@20);
    }];
    
    [self.copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(35);
        make.right.equalTo(self.bgView).offset(-35);
        make.bottom.equalTo(self.bgView).offset(-32);
        make.height.equalTo(@36);
    }];
    
//    [self.weixinButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.bgView.mas_centerX).offset(-30);
//        make.bottom.equalTo(self.bgView).offset(-25);
//        make.size.mas_equalTo(CGSizeMake(40, 65));
//    }];
//
//    [self.circelButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.bgView.mas_centerX).offset(30);
//        make.bottom.equalTo(self.weixinButton);
//        make.size.mas_equalTo(CGSizeMake(50, 65));
//    }];
    
}

- (void)setInviteCode:(NSString *)inviteCode {
    _inviteCode = inviteCode;
    self.inviteCodeLabel.text = inviteCode;
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

- (void)copyButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(myInviteCodeView:didSelectIndex:)]) {
        [self.delegate myInviteCodeView:self didSelectIndex:0];
    }
    
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        [self removeFromSuperview];
    });
}
@end
