//
//  HJDHomeNavSearchView.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/9.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeNavSearchView.h"

@interface HJDHomeNavSearchView()<UITextFieldDelegate>
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIImageView *deleteImgView;
@end

@implementation HJDHomeNavSearchView

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 117 - 21, 40)];
        _bgView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 4.f;
    }
    return _bgView;
}

- (UIImageView *)deleteImgView {
    if (!_deleteImgView) {
        _deleteImgView = [[UIImageView alloc] initWithImage:kImage(@"订单管理页搜索删除")];
        _deleteImgView.frame = CGRectMake(kScreenWidth - 100, 14, 12, 12);
    }
    return _deleteImgView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(12, 10, kScreenWidth - 117 - 36 - 21, 20)];
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _textField.font = kFont14;
        _textField.delegate = self;
    }
    return _textField;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.textField];
        [self.bgView addSubview:self.deleteImgView];
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{ NSFontAttributeName : kFont14, NSForegroundColorAttributeName : kRGB_Color(0xd4, 0xd4, 0xd4)}];
}
@end
