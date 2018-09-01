//
//  HJDTextFieldView.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/8/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDTextFieldView.h"

@interface HJDTextFieldView()
@property(nonatomic, strong) UILabel *textLabel;
@property(nonatomic, strong) UITextField *textField;
@end

@implementation HJDTextFieldView

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = kFont16;
        _textLabel.textColor = kBlack;
    }
    return _textLabel;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = kFont13;
        _textField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _textField;
}

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text fieldPlaceholder:(NSString *)placeholder tag:(NSInteger)fieldTag {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.textLabel];
        [self addSubview:self.textField];
        self.textLabel.text = text;
        self.textField.placeholder = placeholder;
        self.textField.tag = fieldTag;
        
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.bottom.equalTo(self);
            make.width.equalTo(@80);
        }];
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.textLabel.mas_right).offset(5);
            make.top.bottom.equalTo(self);
            make.right.equalTo(self).offset(-10);
        }];
    }
    return self;
}

- (void)setFieldText:(NSString *)fieldText {
    self.textField.text = fieldText;
}

@end

@interface HJDRegisterAgreementView()
@property(nonatomic, strong) UIButton *selectButton;
@property(nonatomic, strong) UILabel *label;
@end

@implementation HJDRegisterAgreementView

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.text = @"同意用户协议";
        _label.textColor = kBlack;
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

@interface HJDCustomerServiceView()
@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UILabel *phoneLabel;
@end

@implementation HJDCustomerServiceView
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithImage:kImage(@"3.png")];
    }
    return _imgView;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.text = @"400-250-1234";
        _phoneLabel.textColor = kRGB_Color(0, 194, 157);
        _phoneLabel.font = kFont14;
    }
    return _phoneLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imgView];
        [self addSubview:self.phoneLabel];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
        
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(2);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(100, 30));
        }];
    }
    return self;
}
@end
