//
//  HJDMyNavTextFieldSearchView.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMyNavTextFieldSearchView.h"

@interface HJDMyNavTextFieldSearchView()
@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) UIButton *clearButton;
@property(nonatomic, strong) UIButton *backButton;
@property(nonatomic, strong) UIButton *sureButton;
@end

@implementation HJDMyNavTextFieldSearchView

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setImage:kImage(@"返回按钮") forState:UIControlStateNormal];
        [_backButton setImage:kImage(@"返回按钮") forState:UIControlStateSelected];
    }
    return _backButton;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = kFont14;
        _textField.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _textField.backgroundColor = [UIColor clearColor];
    }
    return _textField;
}

- (UIButton *)clearButton {
    if (!_clearButton) {
        _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearButton setBackgroundImage:kImage(@"订单管理页搜索删除") forState:UIControlStateNormal];
        [_clearButton addTarget:self action:@selector(clearButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _clearButton.titleLabel.font = kFont12;
        _clearButton.hidden = YES;
    }
    return _clearButton;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:kRGB_Color(0x33, 0x33, 0x33) forState:UIControlStateNormal];
        _sureButton.titleLabel.font = kFont15;
        [_sureButton addTarget:self action:@selector(sureButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

- (void)setUpUI {
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 4.f;
    [self addSubview:bgView];
    
    [self addSubview:self.backButton];
    [self addSubview:self.sureButton];
    
    [bgView addSubview:self.textField];
    [bgView addSubview:self.clearButton];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(20, 44));
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backButton.mas_right).offset(16);
        make.right.equalTo(self.sureButton.mas_left).offset(-16);
        make.height.equalTo(@32);
        make.centerY.equalTo(self);
    }];
    
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-16);
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.centerY.equalTo(self);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(12);
        make.top.bottom.equalTo(bgView);
        make.right.equalTo(self.clearButton.mas_left).offset(-12);
    }];
    
    [self.clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView);
        make.right.equalTo(bgView).offset(-12);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kControllerBackgroundColor;
        _isHaveSureButton = YES;
        [self setUpUI];
        
        @weakify(self);
        [[self.textField rac_textSignal] subscribeNext:^(NSString *x) {
            @strongify(self);
            if ([NSString hjd_isBlankString:x]) {
                self.clearButton.hidden = YES;
            } else {
                self.clearButton.hidden = NO;
                if (!self.isHaveSureButton) {
                    if (self.delegate && [self.delegate respondsToSelector:@selector(searchView:keyWord:sureButton:)]) {
                        [self.delegate searchView:self keyWord:self.textField.text sureButton:nil];
                    }
                }
            }
        }];
    }
    return self;
}

- (void)setIsHaveSureButton:(BOOL)isHaveSureButton {
    _isHaveSureButton = isHaveSureButton;
    [self.sureButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0, 0));
    }];
    
}

- (void)backButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchView:backButton:)]) {
        [self.delegate searchView:self backButton:sender];
    }
}

- (void)clearButtonClick:(id)sender {
    self.textField.text = @"";
    self.clearButton.hidden = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchView:clearButton:)]) {
        [self.delegate searchView:self clearButton:sender];
    }
}

- (void)sureButtonClicked:(id)sender {
    if ([NSString hjd_isBlankString:self.textField.text]) {
        return;
    }
    [self.textField endEditing:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchView:keyWord:sureButton:)]) {
        [self.delegate searchView:self keyWord:self.textField.text sureButton:sender];
    }
}

- (void)setPlaceholderStr:(NSString *)placeholderStr {
    _placeholderStr = placeholderStr;
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderStr attributes:@{ NSFontAttributeName : kFont14, NSForegroundColorAttributeName : kRGB_Color(0xd4, 0xd4, 0xd4)}];
}
@end
