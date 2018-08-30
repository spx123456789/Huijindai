//
//  HJDRegisterViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/8/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDRegisterViewController.h"
#import "HJDTextFieldView.h"

@interface HJDRegisterViewController ()
@property(nonatomic, strong) TPKeyboardAvoidingScrollView *bgView;
@property(nonatomic, strong) HJDTextFieldView *nameView;
@property(nonatomic, strong) HJDTextFieldView *phoneView;
@property(nonatomic, strong) HJDTextFieldView *verifiCodeView;
@property(nonatomic, strong) HJDTextFieldView *cityView;
@property(nonatomic, strong) HJDTextFieldView *inviteCodeView;
@property(nonatomic, strong) UIButton *registerButton;
@end

@implementation HJDRegisterViewController

- (TPKeyboardAvoidingScrollView *)bgView {
    if (!_bgView) {
        _bgView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
    }
    return _bgView;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:kWithe forState:UIControlStateNormal];
        [_registerButton setBackgroundColor:kGreen];
        _registerButton.layer.masksToBounds = YES;
        _registerButton.layer.cornerRadius = 5.f;
    }
    return _registerButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    [self.view addSubview:self.bgView];
    
    CGFloat topHeight = 20;
    _nameView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth, 30) text:@"姓名:" filedPlaceholder:@"请输入姓名" tag:10];
    [self.bgView addSubview:_nameView];
    
    _phoneView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight + 40, kScreenWidth, 30) text:@"手机号码:" filedPlaceholder:@"请输入手机号码" tag:11];
    [self.bgView addSubview:_phoneView];
    
    _verifiCodeView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight + 80, kScreenWidth - 10 - 60, 30) text:@"验证码:" filedPlaceholder:@"" tag:12];
    [self.bgView addSubview:_verifiCodeView];
    
    _cityView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight + 120, kScreenWidth - 10 - 25, 30) text:@"城市:" filedPlaceholder:@"" tag:13];
    [self.bgView addSubview:_cityView];
    
    _inviteCodeView = [[HJDTextFieldView alloc] initWithFrame:CGRectMake(0, topHeight + 160, kScreenWidth, 30) text:@"邀请码:" filedPlaceholder:@"请输入邀请码" tag:14];
    [self.bgView addSubview:_inviteCodeView];
    
    self.registerButton.frame = CGRectMake(25, topHeight + 300, kScreenWidth - 50, 40);
    [self.bgView addSubview:self.registerButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
