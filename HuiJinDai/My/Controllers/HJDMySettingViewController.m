//
//  HJDMySettingViewController.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMySettingViewController.h"
#import "HJDTextFieldView.h"
#import "HJDCityPickerView.h"
#import "HJDLoginViewController.h"
#import "AppDelegate.h"
#import "HJDUserDefaultsManager.h"
#import "HJDMyManager.h"
#import "HJDNetAPIManager.h"

@interface HJDMySettingViewController ()<HJDCityPickerViewDelegate>
@property(nonatomic, strong) TPKeyboardAvoidingScrollView *bgView;
@property(nonatomic, strong) HJDTextFieldView *nameView;
@property(nonatomic, strong) HJDTextFieldView *phoneView;
@property(nonatomic, strong) HJDTextFieldView *cityView;
@property(nonatomic, strong) UIButton *cityNextButton;
@property(nonatomic, strong) UIButton *logoutButton;
@property(nonatomic, strong) HJDCityPickerView *cityPickerView;
@property(nonatomic, strong) HJDUserModel *userModel;
@property(nonatomic, strong) HJDCityModel *selectCityModel;
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
    _nameView.textField.text = self.userModel.rename;
    [self.bgView addSubview:_nameView];
    
    topHeight += 60;
    _phoneView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth, 60) text:@"手机号" fieldPlaceholder:@"" tag:11];
    _phoneView.textLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
    _phoneView.textField.text = self.userModel.phone;
    _phoneView.fieldCanEdit = NO;
    [self.bgView addSubview:_phoneView];
    
    topHeight += 60;
    _cityView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth, 60) text:@"城市" fieldPlaceholder:@"" tag:13];
    _cityView.textLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
    NSDictionary *addressDic = self.userModel.addr_office_tree;
    _cityView.textField.text = [NSString stringWithFormat:@"%@ %@", addressDic[@"sheng_name"], addressDic[@"shi_name"]];
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
    
    self.userModel = (HJDUserModel *)[[HJDUserDefaultsManager shareInstance] loadObject:kUserModelKey];
    
    [self setNavTitle:@"设置"];
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack:(UIButton *)sender {
    BOOL isEqualName = [_nameView.textField.text isEqualToString:self.userModel.rename];
    NSDictionary *addressDic = self.userModel.addr_office_tree;
    BOOL isEqualCity = [addressDic[@"shi"] isEqualToString:self.selectCityModel.pid];
    if (self.selectCityModel == nil) {
        isEqualCity = YES;
    }
    
    if (isEqualName && isEqualCity) {
        [super goBack:sender];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否保存修改信息" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [super goBack:nil];
        }];
        @weakify(self);
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            @strongify(self);
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            if (!isEqualName) {
                NSString *name = [NSString hjd_isBlankString:self.nameView.textField.text] ? @"" : self.nameView.textField.text;
                [params setObject:name forKey:@"rename"];
            } else {
                [params setObject:self.userModel.rename forKey:@"rename"];
            }
            
            if (!isEqualCity) {
                [params setObject:self.selectCityModel.pid forKey:@"addr_office"];
            } else {
                [params setObject:addressDic[@"shi"] forKey:@"addr_office"];
            }
            [self modifyInfo:params];
        }];
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)modifyInfo:(NSDictionary *)params {
    [MBProgressHUD showMessage:@"正在修改..."];
    [HJDMyManager modifyMyInfoWithParams:params callBack:^(BOOL result) {
        if (result) {
            [HJDMyManager reUpdateMyInfo:^(BOOL result) {
                [MBProgressHUD hideHUD];
                [super goBack:nil];
            }];
        } else {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"修改失败"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [super goBack:nil];
            });
        }
    }];
}

- (void)selectCity:(id)selector {
    [self.cityPickerView show];
}

- (void)logoutButtonClick:(id)selector {
    
    [[HJDNetAPIManager sharedManager] setAuthorization:nil];
    [[NSUserDefaults standardUserDefaults] setObject:@(2) forKey:HJDLoginSuccess];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserModelKey];
   //退出登录 进入登录界面
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[[HJDLoginViewController alloc] init]];
    [UIApplication sharedApplication].delegate.window.rootViewController = navi;
}

#pragma mark - HJDCityPickerViewDelegate
- (void)pickerView:(HJDCityPickerView *)pickerView didSelectedCity:(HJDCityModel *)city {
    self.selectCityModel = city;
    self.cityView.textField.text = city.name;
    self.cityPickerView = nil;
}

@end
