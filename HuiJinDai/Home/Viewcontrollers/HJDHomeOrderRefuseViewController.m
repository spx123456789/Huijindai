//
//  HJDHomeOrderRefuseViewController.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/16.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeOrderRefuseViewController.h"
#import "HJDHomeRoomDiDaiManager.h"

@interface HJDHomeOrderRefuseViewController ()
@property(nonatomic, strong) UIView *topView;
@property(nonatomic, strong) UIButton *sureButton;
@property(nonatomic, strong) UITextView *textView;
@end

@implementation HJDHomeOrderRefuseViewController

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = kWithe;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 80, 44)];
        titleLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
        titleLabel.font = [UIFont boldSystemFontOfSize:15];
        titleLabel.text = @"意见";
        [_topView addSubview:titleLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, 1)];
        lineView.backgroundColor = kLineColor;
        [_topView addSubview:lineView];
        
        UIView *color_line = [[UIView alloc] initWithFrame:CGRectMake(0, 14, 3, 16)];
        color_line.backgroundColor = kMainColor;
        [_topView addSubview:color_line];
    }
    return _topView;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
    }
    return _textView;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.backgroundColor = kMainColor;
        _sureButton.layer.masksToBounds = YES;
        _sureButton.layer.cornerRadius = 4.f;
        _sureButton.titleLabel.font = kFont15;
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:kRGB_Color(0xff, 0xff, 0xff) forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

- (void)sureButtonClick:(id)sender {
    if ([NSString hjd_isBlankString:self.textView.text]) {
        [self showToast:@"请填写拒绝原因"];
        return;
    }
    
    @weakify(self);
    [MBProgressHUD showMessage:@"正在提交..."];
    [HJDHomeRoomDiDaiManager auditOrderWithID:self.order_id step:@"2" content:self.textView.text managerId:nil callBack:^(NSString *msg, BOOL result) {
        [MBProgressHUD hideHUD];
        if (result) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kHJDOrderAuditNotificationName object:nil];
            [MBProgressHUD showSuccess:@"提交成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                @strongify(self);
                [self.navigationController popViewControllerAnimated:YES];
            });
        } else {
            if (msg) {
                [MBProgressHUD showError:msg];
            } else {
                [MBProgressHUD showError:@"提交失败"];
            }
        }
    }];
}

- (void)setUpUI {
    [self.view addSubview:self.topView];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = kWithe;
    [self.view addSubview:bgView];
    
    [bgView addSubview:self.textView];
    [self.view addSubview:self.sureButton];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(4);
        make.height.equalTo(@45);
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom);
        make.height.equalTo(@200);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(16);
        make.right.equalTo(bgView).offset(-16);
        make.top.equalTo(bgView).offset(12);
        make.bottom.equalTo(bgView).offset(-12);
    }];
    
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.top.equalTo(bgView.mas_bottom).offset(20);
        make.height.equalTo(@46);
    }];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isView = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTitle:@"拒单"];
    
    self.view.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    
    [self setUpUI];
    
    if (self.isView) {
        self.textView.text = self.refuseContent;
        self.sureButton.hidden = YES;
        self.textView.userInteractionEnabled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
