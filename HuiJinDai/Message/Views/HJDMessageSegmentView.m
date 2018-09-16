//
//  HJDMessageSegmentView.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/16.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMessageSegmentView.h"

@interface HJDMessageSegmentView()
@property(nonatomic, strong) UIButton *leftButton;
@property(nonatomic, strong) UIButton *rightButton;
@property(nonatomic, strong) UIButton *selectButton;
@end

@implementation HJDMessageSegmentView

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(2, 2, 118, 28);
        [_leftButton setTitle:@"我的通知" forState:UIControlStateNormal];
        _leftButton.titleLabel.font = kFont14;
        _leftButton.layer.masksToBounds = YES;
        _leftButton.layer.cornerRadius = 8.f;
        [_leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(120, 2, 118, 28);
        [_rightButton setTitle:@"渠道通知" forState:UIControlStateNormal];
        _rightButton.titleLabel.font = kFont14;
        _rightButton.layer.masksToBounds = YES;
        _rightButton.layer.cornerRadius = 8.f;
        [_rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8.f;
        self.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
        
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        
        [self resetButton:self.leftButton];
    }
    return self;
}

- (void)resetButton:(UIButton *)button {
    self.selectButton = button;
    [button setBackgroundColor:kMainColor];
    [button setTitleColor:kRGB_Color(0xff, 0xff, 0xff) forState:UIControlStateNormal];
    if (button == self.leftButton) {
        [self.rightButton setTitleColor:kRGB_Color(0x99, 0x99, 0x99) forState:UIControlStateNormal];
        [self.rightButton setBackgroundColor:[UIColor clearColor]];
    } else {
        [self.leftButton setTitleColor:kRGB_Color(0x99, 0x99, 0x99) forState:UIControlStateNormal];
        [self.leftButton setBackgroundColor:[UIColor clearColor]];
    }
}

- (void)leftButtonClick:(id)sender {
    if (self.selectButton == self.leftButton) {
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentView:didSelectMessageType:)]) {
        [self.delegate segmentView:self didSelectMessageType:HJDMessageTypeMy];
    }
    [self resetButton:self.leftButton];
}

- (void)rightButtonClick:(id)sender {
    if (self.selectButton == self.rightButton) {
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentView:didSelectMessageType:)]) {
        [self.delegate segmentView:self didSelectMessageType:HJDMessageTypeChannel];
    }
    [self resetButton:self.rightButton];
}
@end
