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
        _bgView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    return _bgView;
}

- (UIButton *)cityNextButton {
    if (!_cityNextButton) {
        _cityNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cityNextButton setImage:kImage(@"2.png") forState:UIControlStateNormal];
        [_cityNextButton addTarget:self action:@selector(selectCity:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cityNextButton;
}

- (UIButton *)logoutButton {
    if (!_logoutButton) {
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logoutButton setTitleColor:kWithe forState:UIControlStateNormal];
        [_logoutButton setBackgroundColor:kRGB_Color(0, 194, 157)];
        _logoutButton.layer.masksToBounds = YES;
        _logoutButton.layer.cornerRadius = 5.f;
        [_logoutButton addTarget:self action:@selector(logoutButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
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
    
    self.title = @"我的信息";
    [self.view addSubview:self.bgView];
    
    CGFloat topHeight = 20;
    _nameView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth, 30) text:@"姓名:" fieldPlaceholder:@"李思然" tag:10];
    [self.bgView addSubview:_nameView];
    
    _phoneView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight + 40, kScreenWidth, 30) text:@"手机号码:" fieldPlaceholder:@"13355668899" tag:11];
    [self.bgView addSubview:_phoneView];
    
    _cityView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight + 80, kScreenWidth - 10 - 30, 30) text:@"城市:" fieldPlaceholder:@"北京" tag:13];
    [self.bgView addSubview:_cityView];
    
    self.cityNextButton.frame = CGRectMake(kScreenWidth - 40, topHeight + 80, 30, 30);
    [self.bgView addSubview:self.cityNextButton];
    
    self.logoutButton.frame = CGRectMake(25, topHeight + 200, kScreenWidth - 50, 40);
    [self.bgView addSubview:self.logoutButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectCity:(id)selector {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.cityPickerView];
}

- (void)logoutButtonClick:(id)selector {
   //退出登录
}

#pragma mark - HJDCityPickerViewDelegate
- (void)didSelectedCity:(NSString *)city {
    self.cityView.fieldText = city;
}

@end
