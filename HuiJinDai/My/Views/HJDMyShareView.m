//
//  HJDMyShareView.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMyShareView.h"

@interface HJDMyShareButton : UIButton
@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UILabel *label;
@end

@implementation HJDMyShareButton
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textColor = kBlack;
        _label.font = kFont14;
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.imgView];
        [self addSubview:self.label];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(@50);
        }];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.imgView.mas_bottom).offset(5);
            make.height.equalTo(@20);
        }];
    }
    return self;
}
@end

@implementation HJDMyShareView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 135)];
    topView.backgroundColor = kRGB_Color(239, 239, 239);
    [self addSubview:topView];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 20)];
    topLabel.backgroundColor = [UIColor clearColor];
    topLabel.text = @"分享到";
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.font = kFont14;
    [topView addSubview:topLabel];
    
    HJDMyShareButton *leftButton = [HJDMyShareButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(kScreenWidth/2 - 70, 40, 50, 80);
    leftButton.imgView.image = kImage(@"qr.png");
    leftButton.label.text = @"微信";
    [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:leftButton];
    
    HJDMyShareButton *rightButton = [HJDMyShareButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(kScreenWidth/2 + 20, 40, 50, 80);
    rightButton.imgView.image = kImage(@"qr.png");
    rightButton.label.text = @"朋友圈";
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:rightButton];
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 135, kScreenWidth, 45)];
    bottomLabel.backgroundColor = kWithe;
    bottomLabel.text = @"取消";
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    bottomLabel.font = kFont14;
    [self addSubview:bottomLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel:)];
    bottomLabel.userInteractionEnabled = YES;
    [bottomLabel addGestureRecognizer:tap];
}

- (void)cancel:(UITapGestureRecognizer *)gesture {
    [self removeFromSuperview];
}

- (void)leftButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareView:didSelectedIndex:)]) {
        [self.delegate shareView:self didSelectedIndex:0];
    }
    [self removeFromSuperview];
}

- (void)rightButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareView:didSelectedIndex:)]) {
        [self.delegate shareView:self didSelectedIndex:1];
    }
    [self removeFromSuperview];
}
@end
