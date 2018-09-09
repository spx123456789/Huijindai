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
#import "HJDCustomerServiceView.h"
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
        _bgView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight)];
        _bgView.showsVerticalScrollIndicator = NO;
    }
    return _bgView;
}

- (UIButton *)verifiCodeButton {
    if (!_verifiCodeButton) {
        _verifiCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_verifiCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verifiCodeButton setTitleColor:kRGB_Color(0x66, 0x66, 0x66) forState:UIControlStateNormal];
        _verifiCodeButton.titleLabel.font = kFont15;
    }
    return _verifiCodeButton;
}

- (UIButton *)cityNextButton {
    if (!_cityNextButton) {
        _cityNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cityNextButton setImage:kImage(@"进入") forState:UIControlStateNormal];
        [_cityNextButton addTarget:self action:@selector(selectCity:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cityNextButton;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:kRGB_Color(0xff, 0xff, 0xff) forState:UIControlStateNormal];
        [_registerButton setBackgroundColor:kMainColor];
        _registerButton.titleLabel.font = kFont15;
        _registerButton.layer.masksToBounds = YES;
        _registerButton.layer.cornerRadius = 4.f;
        [_registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"已有账号立即登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:kRGB_Color(0x99, 0x99, 0x99) forState:UIControlStateNormal];
        [_loginButton setBackgroundColor:kControllerBackgroundColor];
        _loginButton.titleLabel.font = kFont15;
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 4.f;
        _loginButton.layer.borderWidth = 1.f;
        _loginButton.layer.borderColor = kRGB_Color(0x99, 0x99, 0x99).CGColor;
        [_loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (HJDCityPickerView *)cityPickerView {
    if (!_cityPickerView) {
        _cityPickerView = [[HJDCityPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _cityPickerView.delegate = self;
    }
    return _cityPickerView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showNavigationBar];
}

- (void)setUpUI {
    [self.view addSubview:self.bgView];
    
    CGFloat topHeight = 22;
    _nameView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth, 63) text:@"姓名" fieldPlaceholder:@"请输入姓名" tag:10];
    [self.bgView addSubview:_nameView];
    
    topHeight += 63;
    _phoneView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth, 63) text:@"手机号" fieldPlaceholder:@"请输入手机号码" tag:11];
    [self.bgView addSubview:_phoneView];
  
    self.verifiCodeButton.frame = CGRectMake(kScreenWidth - 105, topHeight + 28, 80, 20);
    [self.bgView addSubview:self.verifiCodeButton];
    
    topHeight += 63;
    _verifiCodeView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth, 63) text:@"验证码" fieldPlaceholder:@"请输入验证码" tag:12];
    [self.bgView addSubview:_verifiCodeView];
    
    topHeight += 63;
    _cityView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth, 63) text:@"城市" fieldPlaceholder:@"请选择城市" tag:13];
    _cityView.fieldCanEdit = NO;
    [self.bgView addSubview:_cityView];
    
    self.cityNextButton.frame = CGRectMake(kScreenWidth - 45, topHeight + 22, 30, 30);
    [self.bgView addSubview:self.cityNextButton];
    
    topHeight += 63;
    _inviteCodeView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth, 63) text:@"邀请码" fieldPlaceholder:@"请输入邀请码" tag:14];
    [self.bgView addSubview:_inviteCodeView];
    
    topHeight += (63 + 12);
    _agreementView = [[HJDRegisterAgreementView alloc] initWithFrame:CGRectMake(24, topHeight, 260, 15)];
    [self.bgView addSubview:_agreementView];
    
    topHeight += 40;
    self.registerButton.frame = CGRectMake(24, topHeight, kScreenWidth - 48, 44);
    [self.bgView addSubview:self.registerButton];
    
    topHeight += (44 + 12);
    self.loginButton.frame = CGRectMake(24, topHeight, kScreenWidth - 48, 44);
    [self.bgView addSubview:self.loginButton];

    topHeight += (44 + 24);
    _customServiceView = [[HJDCustomerServiceView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 70, topHeight, 100, 30)];
    [self.bgView addSubview:_customServiceView];
    
    self.bgView.contentSize = CGSizeMake(kScreenWidth, topHeight + 58);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTitle:@"账号注册"];
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectCity:(id)selector {
    [self.cityPickerView show];
}

- (void)loginButtonClick:(id)selector {
    HJDLoginViewController *loginController = [[HJDLoginViewController alloc] init];
    [self.navigationController pushViewController:loginController animated:YES];
}

- (void)registerButtonClick:(id)sender {
    
}

#pragma mark - HJDCityPickerViewDelegate
- (void)didSelectedCity:(NSString *)city {
    self.cityView.textField.text = city;
    self.cityPickerView = nil;
}

@end
