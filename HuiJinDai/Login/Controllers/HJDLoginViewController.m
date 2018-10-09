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
#import "HJDCustomerServiceView.h"
#import "AppDelegate.h"
#import "HJDRegisterHttpManager.h"
#import "HJDUserModel.h"
#import "HJDUserDefaultsManager.h"

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
        [_verifiCodeButton setTitleColor:kRGB_Color(0x66, 0x66, 0x66) forState:UIControlStateNormal];
        _verifiCodeButton.titleLabel.font = kFont15;
        [_verifiCodeButton addTarget:self action:@selector(verifiCodeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verifiCodeButton;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:kRGB_Color(0xff, 0xff, 0xff) forState:UIControlStateNormal];
        [_loginButton setBackgroundColor:kMainColor];
        _loginButton.titleLabel.font = kFont15;
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 4.f;
        [_loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:kRGB_Color(0x33, 0x33, 0x33) forState:UIControlStateNormal];
        _registerButton.titleLabel.font = kFont15;
        [_registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (void)verifiCodeButtonClick:(id)sender {
    NSString *phone = self.phoneView.text;
    if (![phone hjd_isVaildPhoneNumber]) {
        return;
    }
    [HJDRegisterHttpManager getVerifiCodeWithPhone:phone callBack:^(NSDictionary *data, NSError *error, BOOL result) {
        
    }];
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
    
    self.registerButton.frame = CGRectMake(kScreenWidth - 58 , 24, 44, 20);
    [self.bgView addSubview:self.registerButton];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(24, 84, kScreenWidth - 48, 30)];
    label1.text = @"手机快捷登录";
    label1.font = [UIFont boldSystemFontOfSize:28];
    label1.textColor = kRGB_Color(0x33, 0x33, 0x33);
    [self.bgView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(24, 136, kScreenWidth - 48, 40)];
    label2.text = @"未注册的用户可以点击右上角注册按钮来\n注册您的账号";
    label2.textColor = kRGB_Color(0x99, 0x99, 0x99);
    label2.font = kFont15;
    label2.numberOfLines = 0;
    [self.bgView addSubview:label2];
    
    _phoneView = [self createTextFieldWithFrame:CGRectMake(24, 222, kScreenWidth - 48 - 100, 20) placeholder:@"请输入手机号码"];
    [self.bgView addSubview:_phoneView];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(24, 258, kScreenWidth - 48, 1)];
    lineView1.backgroundColor = kLineColor;
    [self.bgView addSubview:lineView1];
    
    _verifiCodeView = [self createTextFieldWithFrame:CGRectMake(24, 288, kScreenWidth - 48, 20) placeholder:@"请输入短信验证码"];
    [self.bgView addSubview:_verifiCodeView];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(24, 324, kScreenWidth - 48, 1)];
    lineView2.backgroundColor = kLineColor;
    [self.bgView addSubview:lineView2];
    
    self.verifiCodeButton.frame = CGRectMake(kScreenWidth - 105, 222, 80, 20);
    [self.bgView addSubview:self.verifiCodeButton];
    
    self.loginButton.frame = CGRectMake(24, 350, kScreenWidth - 48, 44);
    [self.bgView addSubview:self.loginButton];
    
    _customServiceView = [[HJDCustomerServiceView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 70, kScreenHeight - kStatusBarHeight - 60, 140, 30)];
    [self.bgView addSubview:_customServiceView];
    
}

- (UITextField *)createTextFieldWithFrame:(CGRect)rect placeholder:(NSString *)placeholder {
    UITextField *textField = [[UITextField alloc] initWithFrame:rect];
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{ NSFontAttributeName : kFont15, NSForegroundColorAttributeName : kRGB_Color(0xd4, 0xd4, 0xd4)}];
    textField.textColor = kRGB_Color(0x33, 0x33, 0x33);
    textField.font = kFont15;
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
    NSString *phone = self.phoneView.text;
    if (![phone hjd_isVaildPhoneNumber]) {
        return;
    }
    
    NSString *verifiCode = self.verifiCodeView.text;
    if ([NSString hjd_isBlankString:verifiCode]) {
        return;
    }
    
    [MBProgressHUD showMessage:@"登陆中..."];
    [HJDRegisterHttpManager loginWithPhone:phone verifiCode:verifiCode callBack:^(NSDictionary *data, NSError *error, BOOL result) {
        [MBProgressHUD hideHUD];
        if (result) {
            HJDUserModel *userModel = [[HJDUserModel alloc] init];
            [userModel hjd_loadDataFromkeyValues:data];
            [[HJDUserDefaultsManager shareInstance] saveObject:userModel key:kUserModelKey];

            [[HJDNetAPIManager sharedManager] setAuthorization:userModel.token];
            
            AppDelegate *appDelagate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelagate enterHomeController];
            
            [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:HJDLoginSuccess];
        } else {
            [MBProgressHUD showError:@"登录失败"];
            [[NSUserDefaults standardUserDefaults] setObject:@(2) forKey:HJDLoginSuccess];
        }
    }];
}

@end
