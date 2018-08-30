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
        _textField.font = [UIFont systemFontOfSize:13];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _textField;
}

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text filedPlaceholder:(NSString *)placeholder tag:(NSInteger)fieldTag {
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
@end
