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
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 88 - 20, 44)];
        _bgView.backgroundColor = kGray;
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
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth - 88 - 20 - 40, 30)];
        _textField.placeholder = @"请输入姓名和手机号搜索";
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
