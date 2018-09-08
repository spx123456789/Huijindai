//
//  HJDCustomerServiceView.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/8.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDCustomerServiceView.h"

@interface HJDCustomerServiceView()
@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UILabel *phoneLabel;
@end

@implementation HJDCustomerServiceView
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithImage:kImage(@"客服电话")];
    }
    return _imgView;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.text = @"400-250-1234";
        _phoneLabel.textColor = kMainColor;
        _phoneLabel.font = kFont16;
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
            make.size.mas_equalTo(CGSizeMake(18, 22));
        }];
        
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(12);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(110, 20));
        }];
    }
    return self;
}
@end
