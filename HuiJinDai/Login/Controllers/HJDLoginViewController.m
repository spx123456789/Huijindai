//
//  HJDLoginViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/1.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDLoginViewController.h"
#import "HJDRegisterViewController.h"
#import "HJDTextFieldView.h"
#import "AppDelegate.h"

@interface HJDLoginViewController ()
@property(nonatomic, strong) TPKeyboardAvoidingScrollView *bgView;
@property(nonatomic, strong) HJDTextFieldView *phoneView;
@property(nonatomic, strong) HJDTextFieldView *verifiCodeView;
@property(nonatomic, strong) UIButton *verifiCodeButton;
@property(nonatomic, strong) UIButton *registerButton;
@property(nonatomic, strong) UIButton *loginButton;
@property(nonatomic, strong) HJDCustomerServiceView *customServiceView;
@end

@implementation HJDLoginViewController

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

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:kWithe forState:UIControlStateNormal];
        [_loginButton setBackgroundColor:kRGB_Color(0, 194, 157)];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 5.f;
        [_loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"没有账号，立即注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:kBlack forState:UIControlStateNormal];
        _registerButton.titleLabel.font = kFont12;
        [_registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    [self.view addSubview:self.bgView];
    
    CGFloat topHeight = 50;
    _phoneView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight + 40, kScreenWidth, 30) text:@"手机号码:" fieldPlaceholder:@"请输入手机号码" tag:11];
    [self.bgView addSubview:_phoneView];
    
    _verifiCodeView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight + 80, kScreenWidth - 10 - 80, 30) text:@"验证码:" fieldPlaceholder:@"" tag:12];
    [self.bgView addSubview:_verifiCodeView];
    
    self.verifiCodeButton.frame = CGRectMake(kScreenWidth - 90, topHeight + 80, 80, 30);
    [self.bgView addSubview:self.verifiCodeButton];
    
    self.registerButton.frame = CGRectMake(kScreenWidth - 130, topHeight + 120, 120, 35);
    [self.bgView addSubview:self.registerButton];
    
    self.loginButton.frame = CGRectMake(25, topHeight + 180, kScreenWidth - 50, 40);
    [self.bgView addSubview:self.loginButton];
    
    _customServiceView = [[HJDCustomerServiceView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 75, topHeight + 260, 150, 45)];
    [self.bgView addSubview:_customServiceView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerButtonClick:(id)selector {
    HJDRegisterViewController *vc = [[HJDRegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loginButtonClick:(id)selector {
    AppDelegate *appDelagate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelagate enterHomeController];
}

@end
