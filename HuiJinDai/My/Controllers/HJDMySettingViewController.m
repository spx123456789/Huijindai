//
//  HJDMySettingViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMySettingViewController.h"
#import "HJDTextFieldView.h"
#import "HJDCityPickerView.h"
#import "HJDLoginViewController.h"
#import "AppDelegate.h"

@interface HJDMySettingViewController ()<HJDCityPickerViewDelegate>
@property(nonatomic, strong) TPKeyboardAvoidingScrollView *bgView;
@property(nonatomic, strong) HJDTextFieldView *nameView;
@property(nonatomic, strong) HJDTextFieldView *phoneView;
@property(nonatomic, strong) HJDTextFieldView *cityView;
@property(nonatomic, strong) UIButton *cityNextButton;
@property(nonatomic, strong) UIButton *logoutButton;
@property(nonatomic, strong) HJDCityPickerView *cityPickerView;
@end

@implementation HJDMySettingViewController

- (TPKeyboardAvoidingScrollView *)bgView {
    if (!_bgView) {
        _bgView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight)];
    }
    return _bgView;
}

- (UIButton *)cityNextButton {
    if (!_cityNextButton) {
        _cityNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cityNextButton setImage:kImage(@"进入") forState:UIControlStateNormal];
        [_cityNextButton addTarget:self action:@selector(selectCity:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cityNextButton;
}

- (UIButton *)logoutButton {
    if (!_logoutButton) {
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logoutButton setTitleColor:kRGB_Color(0xff, 0xff, 0xff) forState:UIControlStateNormal];
        [_logoutButton setBackgroundColor:kMainColor];
        _logoutButton.titleLabel.font = kFont15;
        _logoutButton.layer.masksToBounds = YES;
        _logoutButton.layer.cornerRadius = 4.f;
        [_logoutButton addTarget:self action:@selector(logoutButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}

- (HJDCityPickerView *)cityPickerView {
    if (!_cityPickerView) {
        _cityPickerView = [[HJDCityPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _cityPickerView.delegate = self;
    }
    return _cityPickerView;
}

- (void)setUpUI {
    [self.view addSubview:self.bgView];
    
    CGFloat topHeight = 25;
    _nameView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth, 60) text:@"姓名" fieldPlaceholder:@"" tag:10];
    _nameView.textLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
    _nameView.textField.text = @"李思然";
    _nameView.fieldCanEdit = NO;
    [self.bgView addSubview:_nameView];
    
    topHeight += 60;
    _phoneView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth, 60) text:@"手机号" fieldPlaceholder:@"" tag:11];
    _phoneView.textLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
    _phoneView.textField.text = @"13355668899";
    _phoneView.fieldCanEdit = NO;
    [self.bgView addSubview:_phoneView];
    
    topHeight += 60;
    _cityView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth, 60) text:@"城市" fieldPlaceholder:@"" tag:13];
    _cityView.textLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
    _cityView.textField.text = @"北京";
    _cityView.fieldCanEdit = NO;
    [self.bgView addSubview:_cityView];
    
    self.cityNextButton.frame = CGRectMake(kScreenWidth - 45, topHeight + 22, 30, 30);
    [self.bgView addSubview:self.cityNextButton];
    
    topHeight += (60 + 32);
    self.logoutButton.frame = CGRectMake(24, topHeight, kScreenWidth - 48, 44);
    [self.bgView addSubview:self.logoutButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTitle:@"设置"];
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectCity:(id)selector {
    [self.cityPickerView show];
}

- (void)logoutButtonClick:(id)selector {
   //退出登录 进入登录界面
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[[HJDLoginViewController alloc] init]];
    [UIApplication sharedApplication].delegate.window.rootViewController = navi;
}

#pragma mark - HJDCityPickerViewDelegate
- (void)didSelectedCity:(NSString *)city {
    self.cityView.textField.text = city;
    self.cityPickerView = nil;
}

@end
