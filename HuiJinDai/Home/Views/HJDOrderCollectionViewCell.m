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
        _nameLabel.textColor = kControllerBackgroundColor;
        _nameLabel.font = kFont14;
    }
    return _nameLabel;
}

- (UILabel *)unreadLabel {
    if (!_unreadLabel) {
        _unreadLabel = [[UILabel alloc] init];
        _unreadLabel.textColor = kWithe;
        _unreadLabel.backgroundColor = [UIColor redColor];
        _unreadLabel.font = kFont14;
    }
    return _unreadLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.headImgView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.unreadLabel];
    }
    return self;
}
@end
