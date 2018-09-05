//
//  HJDHomeOrderListSearchView.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/5.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeOrderListSearchView.h"

@interface HJDHomeOrderListSearchView()<UITextFieldDelegate>
@property(nonatomic, strong) UIButton *sureButton;
@property(nonatomic, strong) UIButton *cancelButton;
@property(nonatomic, strong) UITextField *textField;
@end

@implementation HJDHomeOrderListSearchView

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 35)];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.placeholder = @"请输入房产地址/申请人姓名查询";
        _textField.font = kFont14;
        _textField.delegate = self;
        _textField.backgroundColor = kWithe;
    }
    return _textField;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.frame = CGRectMake(kScreenWidth/2, 55, kScreenWidth/2, 40);
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:kBlack forState:UIControlStateNormal];
        _sureButton.titleLabel.font = kFont14;
        _sureButton.layer.borderWidth = 0.5;
        _sureButton.layer.borderColor = kGray.CGColor;
        [_sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(0, 55, kScreenWidth/2, 40);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:kBlack forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = kFont14;
        _cancelButton.layer.borderWidth = 0.5;
        _cancelButton.layer.borderColor = kGray.CGColor;
        [_cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = kGray.CGColor;
        self.backgroundColor = kWithe;
        [self addSubview:self.textField];
        [self addSubview:self.sureButton];
        [self addSubview:self.cancelButton];
    }
    return self;
}

- (void)cancelButtonClick:(id)sender {
    [self removeFromSuperview];
}

- (void)sureButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchView:didSearch:)]) {
        [self.delegate searchView:self didSearch:self.textField.text];
    }
    [self removeFromSuperview];
}
@end
