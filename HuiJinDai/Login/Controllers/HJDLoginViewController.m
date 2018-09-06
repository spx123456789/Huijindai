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
@property(nonatomic, strong) UITextField *phoneView;
@property(nonatomic, strong) UITextField *verifiCodeView;
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
        [_verifiCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_verifiCodeButton setTitleColor:kBlack forState:UIControlStateNormal];
        _verifiCodeButton.titleLabel.font = kFont16;
    }
    return _verifiCodeButton;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:kWithe forState:UIControlStateNormal];
        [_loginButton setBackgroundColor:kMainColor];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 5.f;
        [_loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:kBlack forState:UIControlStateNormal];
        _registerButton.titleLabel.font = kFont14;
        [_registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI {
    [self.view addSubview:self.bgView];
    
    self.registerButton.frame = CGRectMake(kScreenWidth - 50 , 24, 44, 20);
    [self.bgView addSubview:self.registerButton];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 84, kScreenWidth - 40, 50)];
    label1.text = @"手机快捷登录";
    label1.font = [UIFont boldSystemFontOfSize:30];
    [self.bgView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 135, kScreenWidth - 40, 50)];
    label2.text = @"未注册的用户可以点击右上角注册按钮来\n注册您的账号";
    label2.textColor = kGray;
    label2.font = kFont14;
    label2.numberOfLines = 0;
    [self.bgView addSubview:label2];
    
    _phoneView = [self createTextFieldWithFrame:CGRectMake(20, 200, kScreenWidth - 40 - 100, 30) placeholder:@"请输入手机号码"];
    [self.bgView addSubview:_phoneView];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(20, 231, kScreenWidth - 40, 0.5)];
    lineView1.backgroundColor = kGray;
    [self.bgView addSubview:lineView1];
    
    _verifiCodeView = [self createTextFieldWithFrame:CGRectMake(20, 255, kScreenWidth - 40, 30) placeholder:@"请输入短信验证码"];
    [self.bgView addSubview:_verifiCodeView];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(20, 286, kScreenWidth - 40, 0.5)];
    lineView2.backgroundColor = kGray;
    [self.bgView addSubview:lineView2];
    
    self.verifiCodeButton.frame = CGRectMake(kScreenWidth - 120, 200, 100, 30);
    [self.bgView addSubview:self.verifiCodeButton];
    
    self.loginButton.frame = CGRectMake(20, 320, kScreenWidth - 40, 40);
    [self.bgView addSubview:self.loginButton];
    
    _customServiceView = [[HJDCustomerServiceView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 75, kScreenHeight - 80, 150, 45)];
    [self.bgView addSubview:_customServiceView];
    
}

- (UITextField *)createTextFieldWithFrame:(CGRect)rect placeholder:(NSString *)placeholder {
    UITextField *textField = [[UITextField alloc] initWithFrame:rect];
    textField.placeholder = placeholder;
    textField.font = kFont16;
    return textField;
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
