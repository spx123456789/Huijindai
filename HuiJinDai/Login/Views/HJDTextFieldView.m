//
//  HJDTextFieldView.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/8/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDTextFieldView.h"

@interface HJDTextFieldView()<UITextFieldDelegate>
@property(nonatomic, strong) UILabel *textLabel;
@property(nonatomic, strong) UITextField *textField;
@end

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
        _textField.delegate = self;
        _textField.textColor = kRGB_Color(0x33, 0x33, 0x33);
    }
    return _textField;
}

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text fieldPlaceholder:(NSString *)placeholder tag:(NSInteger)fieldTag {
    self = [super initWithFrame:frame];
    if (self) {
        _fieldCanEdit = YES;
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

- (void)setFieldText:(NSString *)fieldText {
    self.textField.text = fieldText;
}

- (void)setFieldPlaceholder:(NSString *)fieldPlaceholder {
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:fieldPlaceholder attributes:@{ NSFontAttributeName : kFont15, NSForegroundColorAttributeName : kRGB_Color(0xd4, 0xd4, 0xd4)}];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return self.fieldCanEdit;
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
        _label.text = @"同意亚投行金服用户协议";
        _label.textColor = kRGB_Color(0x99, 0x99, 0x99);
        _label.font = kFont12;
    }
    return _label;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:kImage(@"1.png") forState:UIControlStateNormal];
        [_selectButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.selectButton];
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
    }
    return self;
}

- (void)clickButton:(id)selector {
    _selected = !self.selected;
    UIImage *image = _selected ? kImage(@"1.png") : kImage(@"1.png");
    [_selectButton setImage:image forState:UIControlStateNormal];
}

@end
