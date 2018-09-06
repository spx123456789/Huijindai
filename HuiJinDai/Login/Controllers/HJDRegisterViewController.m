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
        [_verifiCodeButton setTitleColor:kBlack forState:UIControlStateNormal];
        _verifiCodeButton.titleLabel.font = kFont14;
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
        [_registerButton setBackgroundColor:kMainColor];
        _registerButton.layer.masksToBounds = YES;
        _registerButton.layer.cornerRadius = 5.f;
        [_registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"已有账号立即登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:kGray forState:UIControlStateNormal];
        [_loginButton setBackgroundColor:kControllerBackgroundColor];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 5.f;
        _loginButton.layer.borderWidth = 1.f;
        _loginButton.layer.borderColor = kGray.CGColor;
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showNavigationBar];
}

- (void)setUpUI {
    [self.view addSubview:self.bgView];
    
    CGFloat topHeight = 35;
    _nameView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth, 30) text:@"姓名:" fieldPlaceholder:@"请输入姓名" tag:10];
    [self.bgView addSubview:_nameView];
    
    [self addLineViewWithY:topHeight + 31];
    
    topHeight += 45;
    _phoneView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth - 10 - 80, 30) text:@"手机号码:" fieldPlaceholder:@"请输入手机号码" tag:11];
    [self.bgView addSubview:_phoneView];
    
    [self addLineViewWithY:topHeight + 31];
    
    self.verifiCodeButton.frame = CGRectMake(kScreenWidth - 90, topHeight, 80, 30);
    [self.bgView addSubview:self.verifiCodeButton];
    
    topHeight += 45;
    _verifiCodeView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth, 30) text:@"验证码:" fieldPlaceholder:@"请输入验证码" tag:12];
    [self.bgView addSubview:_verifiCodeView];
    
    [self addLineViewWithY:topHeight + 31];
    
    topHeight += 45;
    _cityView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth - 10 - 30, 30) text:@"城市:" fieldPlaceholder:@"请选择城市" tag:13];
    _cityView.fieldCanEdit = NO;
    [self.bgView addSubview:_cityView];
    
    [self addLineViewWithY:topHeight + 31];
    
    self.cityNextButton.frame = CGRectMake(kScreenWidth - 40, topHeight, 30, 30);
    [self.bgView addSubview:self.cityNextButton];
    
    topHeight += 45;
    _inviteCodeView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth, 30) text:@"邀请码:" fieldPlaceholder:@"请输入邀请码" tag:14];
    [self.bgView addSubview:_inviteCodeView];
    
    [self addLineViewWithY:topHeight + 31];
    
    topHeight += 40;
    _agreementView = [[HJDRegisterAgreementView alloc] initWithFrame:CGRectMake(10, topHeight, 260, 35)];
    [self.bgView addSubview:_agreementView];
    
    topHeight += 50;
    self.registerButton.frame = CGRectMake(20, topHeight, kScreenWidth - 40, 40);
    [self.bgView addSubview:self.registerButton];
    
    topHeight += 55;
    self.loginButton.frame = CGRectMake(20, topHeight, kScreenWidth - 40, 40);
    [self.bgView addSubview:self.loginButton];

    _customServiceView = [[HJDCustomerServiceView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 75, kScreenHeight -kSafeAreaTopHeight - 70, 150, 45)];
    [self.bgView addSubview:_customServiceView];
}

- (void)addLineViewWithY:(CGFloat)Y {
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(20, Y, kScreenWidth - 40, 0.5)];
    lineView2.backgroundColor = kGray;
    [self.bgView addSubview:lineView2];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账号注册";
    [self setUpUI];
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

- (void)registerButtonClick:(id)sender {
    
}

#pragma mark - HJDCityPickerViewDelegate
- (void)didSelectedCity:(NSString *)city {
    self.cityView.fieldText = city;
}

@end
