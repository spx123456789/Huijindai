//
//  HJDMySearchFieldView.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMySearchFieldView.h"

@interface HJDMySearchFieldView()
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIImageView *imgView;
@end

@implementation HJDMySearchFieldView

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 30)];
        _bgView.backgroundColor = kWithe;
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 5.f;
    }
    return _bgView;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithImage:kImage(@"5.png")];
        _imgView.frame = CGRectMake(20, 5, 20, 20);
    }
    return _imgView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 5, kScreenWidth - 20 - 55 - 20, 20)];
        _textField.placeholder = @"请输入姓名与手机号";
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.font = kFont12;
    }
    return _textField;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.imgView];
        [self.bgView addSubview:self.textField];
    }
    return self;
}

@end
