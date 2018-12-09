//
//  HJDTextFieldView.m
//  HuiJinDai
//
//  Created by GXW on 2018/8/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDTextFieldView.h"

@implementation HJDTextFieldView

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = kFont15;
        _textLabel.textColor = kRGB_Color(0x66, 0x66, 0x66);
    }
    return _textLabel;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = kFont15;
        _textField.textColor = kRGB_Color(0x33, 0x33, 0x33);
    }
    return _textField;
}

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text fieldPlaceholder:(NSString *)placeholder tag:(NSInteger)fieldTag {
    self = [super initWithFrame:frame];
    if (self) {
        self.fieldCanEdit = YES;
        self.backgroundColor = kWithe;
        [self addSubview:self.textLabel];
        [self addSubview:self.textField];
        self.textLabel.text = text;
        self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{ NSFontAttributeName : kFont15, NSForegroundColorAttributeName : kRGB_Color(0xd4, 0xd4, 0xd4)}];
        self.textField.tag = fieldTag;
        
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(24);
            make.top.equalTo(self).offset(30);
            make.size.mas_equalTo(CGSizeMake(47, 16));
        }];
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.textLabel.mas_right).offset(30);
            make.top.bottom.equalTo(self.textLabel);
            make.right.equalTo(self).offset(-24);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(24);
            make.right.equalTo(self).offset(-24);
            make.height.equalTo(@1);
            make.bottom.equalTo(self).offset(-1);
        }];
    }
    return self;
}

- (void)setFieldPlaceholder:(NSString *)fieldPlaceholder {
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:fieldPlaceholder attributes:@{ NSFontAttributeName : kFont15, NSForegroundColorAttributeName : kRGB_Color(0xd4, 0xd4, 0xd4)}];
}

- (void)setFieldCanEdit:(BOOL)fieldCanEdit {
    _fieldCanEdit = fieldCanEdit;
    self.textField.userInteractionEnabled = fieldCanEdit;
}

@end

#pragma mark - HJDRegisterAgreementView
@interface HJDRegisterAgreementView()
@property(nonatomic, strong) UIButton *selectButton;
@property(nonatomic, strong) UILabel *label;
@end

@implementation HJDRegisterAgreementView

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.text = @"同意惠金小贷用户注册协议";
        _label.textColor = kRGB_Color(0x99, 0x99, 0x99);
        _label.font = kFont12;
    }
    return _label;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:kImage(@"注册页对勾.png") forState:UIControlStateNormal];
        [_selectButton addTarget:self action:@selector(tapClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.selected = NO;
        [self addSubview:self.selectButton];
        self.selectButton.hidden = YES;
        [self addSubview:self.label];
        
        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(1);
            make.centerY.equalTo(self);
            make.width.equalTo(@25);
            make.height.equalTo(@25);
        }];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.selectButton.mas_right).offset(1);
            make.centerY.equalTo(self);
            make.right.equalTo(self);
            make.height.equalTo(@25);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapClick:(id)selector {
    _selected = !self.selected;
    self.selectButton.hidden = !_selected;
}

@end
