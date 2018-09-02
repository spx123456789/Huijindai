//
//  HJDMyInviteCodeViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/1.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMyInviteCodeViewController.h"
#import "HJDMyShareView.h"

@interface HJDMyInviteCodeViewController ()<HJDMyShareViewDelegate>
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIImageView *headImgView;
@property(nonatomic, strong) UILabel *channelLabel;
@property(nonatomic, strong) UILabel *cityLabel;
@property(nonatomic, strong) UIImageView *QrCodeImgView;
@property(nonatomic, strong) HJDMyShareView *shareView;
@end

@implementation HJDMyInviteCodeViewController
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
        _channelLabel.font = kFont12;
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

- (HJDMyShareView *)shareView {
    if (!_shareView) {
        _shareView = [[HJDMyShareView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 180, kScreenWidth, 180)];
        _shareView.delegate = self;
    }
    return _shareView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的邀请码";
    [self setUpUI];
    [self setRightNavigationButton:@"分享" backImage:nil highlightedImage:nil frame:CGRectMake(0, 0, 44, 44)];
    
    self.headImgView.image = kImage(@"qr.png");
    self.channelLabel.text = @"渠道姓名";
    self.cityLabel.text = @"北京市";
    self.QrCodeImgView.image = kImage(@"qr.png");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigationRightButtonClicked:(UIButton *)sender {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.shareView];
}

- (void)setUpUI {
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.headImgView];
    [self.bgView addSubview:self.channelLabel];
    [self.bgView addSubview:self.cityLabel];
    [self.bgView addSubview:self.QrCodeImgView];
    
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(10);
        make.top.equalTo(self.bgView).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 60));
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
        make.left.equalTo(self.bgView).offset(25);
        make.right.equalTo(self.bgView).offset(-25);
        make.top.equalTo(self.headImgView.mas_bottom).offset(35);
        make.height.equalTo(@(kScreenWidth - 50 - 20));
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(15);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.equalTo(@(10 + 60 + 35 + (kScreenWidth - 50 - 20) + 35));
    }];
}

#pragma mark - HJDMyShareViewDelegate
- (void)shareView:(HJDMyShareView *)shareView didSelectedIndex:(NSInteger)index {
    switch (index) {
        case 0: //微信
            
            break;
        case 1: //朋友圈
            
            break;
        default:
            break;
    }
}
@end
