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
        _logoutButton.titleLabel.font = kFont15;
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

- (void)setUpUI {
    [self.view addSubview:self.bgView];
    
    CGFloat topHeight = 10;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth, 40)];
    topView.backgroundColor = kWithe;
    [self.bgView addSubview:topView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 20)];
    titleLabel.text = @"基本信息";
    titleLabel.font = kFont15;
    titleLabel.textColor = kRGB_Color(0, 194, 157);
    [topView addSubview:titleLabel];
    
    topHeight += 40;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth, 2)];
    lineView.backgroundColor = kControllerBackgroundColor;
    [self.bgView addSubview:lineView];
    
    topHeight += 2;
    _nameView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth, 40) text:@"姓名:" fieldPlaceholder:@"李思然" tag:10];
    _nameView.fieldCanEdit = NO;
    [self.bgView addSubview:_nameView];
    
    topHeight += 40;
    _phoneView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth, 40) text:@"手机号码:" fieldPlaceholder:@"13355668899" tag:11];
    _phoneView.fieldCanEdit = NO;
    [self.bgView addSubview:_phoneView];
    
    topHeight += 40;
    _cityView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth - 10 - 30, 40) text:@"城市:" fieldPlaceholder:@"北京" tag:13];
    _cityView.fieldCanEdit = NO;
    [self.bgView addSubview:_cityView];
    
    self.cityNextButton.frame = CGRectMake(kScreenWidth - 40, topHeight, 40, 40);
    [self.bgView addSubview:self.cityNextButton];
    
    topHeight += 130;
    self.logoutButton.frame = CGRectMake(25, topHeight, kScreenWidth - 50, 40);
    [self.bgView addSubview:self.logoutButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的信息";
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

- (void)logoutButtonClick:(id)selector {
   //退出登录
}

#pragma mark - HJDCityPickerViewDelegate
- (void)didSelectedCity:(NSString *)city {
    self.cityView.fieldPlaceholder = city;
}

@end
