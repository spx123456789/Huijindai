//
//  HJDRegisterViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/8/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDRegisterViewController.h"
#import "HJDLoginViewController.h"
#import "HJDTextFieldView.h"
#import "HJDCityPickerView.h"

@interface HJDRegisterViewController ()<HJDCityPickerViewDelegate>
@property(nonatomic, strong) TPKeyboardAvoidingScrollView *bgView;
@property(nonatomic, strong) HJDTextFieldView *nameView;
@property(nonatomic, strong) HJDTextFieldView *phoneView;
@property(nonatomic, strong) HJDTextFieldView *verifiCodeView;
@property(nonatomic, strong) HJDTextFieldView *cityView;
@property(nonatomic, strong) HJDTextFieldView *inviteCodeView;
@property(nonatomic, strong) UIButton *verifiCodeButton;
@property(nonatomic, strong) UIButton *cityNextButton;
@property(nonatomic, strong) UIButton *registerButton;
@property(nonatomic, strong) UIButton *loginButton;
@property(nonatomic, strong) HJDRegisterAgreementView *agreementView;
@property(nonatomic, strong) HJDCityPickerView *cityPickerView;
@property(nonatomic, strong) HJDCustomerServiceView *customServiceView;
@end

@implementation HJDRegisterViewController

- (TPKeyboardAvoidingScrollView *)bgView {
    if (!_bgView) {
        _bgView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    return _bgView;
}

- (UIButton *)verifiCodeButton {
    if (!_verifiCodeButton) {
        _verifiCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_verifiCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verifiCodeButton setTitleColor:kRGB_Color(0, 194, 157) forState:UIControlStateNormal];
        _verifiCodeButton.titleLabel.font = kFont12;
    }
    return _verifiCodeButton;
}

- (UIButton *)cityNextButton {
    if (!_cityNextButton) {
        _cityNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cityNextButton setImage:kImage(@"2.png") forState:UIControlStateNormal];
        [_cityNextButton addTarget:self action:@selector(selectCity:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cityNextButton;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:kWithe forState:UIControlStateNormal];
        [_registerButton setBackgroundColor:kRGB_Color(0, 194, 157)];
        _registerButton.layer.masksToBounds = YES;
        _registerButton.layer.cornerRadius = 5.f;
    }
    return _registerButton;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"已有账号，立即登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:kBlack forState:UIControlStateNormal];
        _loginButton.titleLabel.font = kFont12;
        [_loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (HJDCityPickerView *)cityPickerView {
    if (!_cityPickerView) {
        _cityPickerView = [[HJDCityPickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 200, kScreenWidth, 200)];
        _cityPickerView.delegate = self;
    }
    return _cityPickerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    [self.view addSubview:self.bgView];
    
    CGFloat topHeight = 20;
    _nameView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth, 30) text:@"姓名:" fieldPlaceholder:@"请输入姓名" tag:10];
    [self.bgView addSubview:_nameView];
    
    _phoneView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight + 40, kScreenWidth, 30) text:@"手机号码:" fieldPlaceholder:@"请输入手机号码" tag:11];
    [self.bgView addSubview:_phoneView];
    
    _verifiCodeView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight + 80, kScreenWidth - 10 - 80, 30) text:@"验证码:" fieldPlaceholder:@"" tag:12];
    [self.bgView addSubview:_verifiCodeView];
    
    _cityView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight + 120, kScreenWidth - 10 - 30, 30) text:@"城市:" fieldPlaceholder:@"" tag:13];
    _cityView.fieldCanEdit = NO;
    [self.bgView addSubview:_cityView];
    
    _inviteCodeView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight + 160, kScreenWidth, 30) text:@"邀请码:" fieldPlaceholder:@"请输入邀请码" tag:14];
    [self.bgView addSubview:_inviteCodeView];
    
    _agreementView = [[HJDRegisterAgreementView alloc] initWithFrame:CGRectMake(10, topHeight + 210, 120, 35)];
    [self.bgView addSubview:_agreementView];
    
    self.verifiCodeButton.frame = CGRectMake(kScreenWidth - 90, topHeight + 80, 80, 30);
    [self.bgView addSubview:self.verifiCodeButton];
    
    self.cityNextButton.frame = CGRectMake(kScreenWidth - 40, topHeight + 120, 30, 30);
    [self.bgView addSubview:self.cityNextButton];
    
    self.loginButton.frame = CGRectMake(kScreenWidth - 130, topHeight + 210, 120, 35);
    [self.bgView addSubview:self.loginButton];
    
    self.registerButton.frame = CGRectMake(25, topHeight + 270, kScreenWidth - 50, 40);
    [self.bgView addSubview:self.registerButton];
    
    _customServiceView = [[HJDCustomerServiceView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 75, topHeight + 350, 150, 45)];
    [self.bgView addSubview:_customServiceView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectCity:(id)selector {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.cityPickerView];
}

- (void)loginButtonClick:(id)selector {
    HJDLoginViewController *loginController = [[HJDLoginViewController alloc] init];
    [self.navigationController pushViewController:loginController animated:YES];
}

#pragma mark - HJDCityPickerViewDelegate
- (void)didSelectedCity:(NSString *)city {
    self.cityView.fieldText = city;
}

@end
