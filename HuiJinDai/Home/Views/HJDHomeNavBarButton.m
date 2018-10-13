//
//  HJDHomeNavBarButton.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/10/10.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeNavBarButton.h"

@interface HJDHomeNavBarButton()
@property(nonatomic, strong) UILabel *label;
@property(nonatomic, strong) UIImageView *imgView;
@end

@implementation HJDHomeNavBarButton
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _label.font = kFont15;
    }
    return _label;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithImage:kImage(@"首页选择城市")];
    }
    return _imgView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.label];
        [self addSubview:self.imgView];
        self.label.frame = CGRectMake(0, 0, 30, frame.size.height);
    }
    return self;
}

- (void)setHjd_title:(NSString *)hjd_title {
    _hjd_title = hjd_title;
    self.label.text = hjd_title;
    
    CGRect oldFrame = self.label.frame;
    [self.label sizeToFit];
    
    CGRect newFrame = self.label.frame;
    self.label.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, newFrame.size.width, oldFrame.size.height);
    self.imgView.frame = CGRectMake(newFrame.origin.x + newFrame.size.width + 8, oldFrame.size.height/2 - 3, 11, 6);
}

@end
