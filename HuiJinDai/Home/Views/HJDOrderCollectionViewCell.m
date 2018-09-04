//
//  HJDOrderCollectionViewCell.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDOrderCollectionViewCell.h"

@implementation HJDOrderCollectionViewCell

- (UIImageView *)headImgView {
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc] init];
    }
    return _headImgView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.font = kFont14;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UILabel *)unreadLabel {
    if (!_unreadLabel) {
        _unreadLabel = [[UILabel alloc] init];
        _unreadLabel.textColor = kWithe;
        _unreadLabel.backgroundColor = [UIColor redColor];
        _unreadLabel.font = kFont14;
        _unreadLabel.textAlignment = NSTextAlignmentCenter;
        _unreadLabel.layer.masksToBounds = YES;
        _unreadLabel.layer.cornerRadius = 10.f;
    }
    return _unreadLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.headImgView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.unreadLabel];
        
        [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.contentView).offset(10);
            make.height.equalTo(@(kScreenWidth/3 - 20));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.headImgView);
            make.top.equalTo(self.headImgView.mas_bottom).offset(8);
            make.height.equalTo(@20);
        }];
        
        [self.unreadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self.headImgView);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
    }
    return self;
}
@end
