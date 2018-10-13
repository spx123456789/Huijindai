//
//  HJDHomePhotoCollectionViewCell.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/10/13.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomePhotoCollectionViewCell.h"

@implementation HJDHomePhotoCollectionViewCell

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = 0.4f;
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [_imageView addGestureRecognizer:tap];
    }
    return _imageView;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.layer.masksToBounds = YES;
        _deleteButton.layer.cornerRadius = 10.f;
        [_deleteButton setBackgroundImage:kImage(@"报单删除上传图片") forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (void)tapGesture:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoCollectionCell:clickImageView:)]) {
        [self.delegate photoCollectionCell:self clickImageView:sender];
    }
}

- (void)deleteButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoCollectionCell:deleteButton:)]) {
        [self.delegate photoCollectionCell:self deleteButton:sender];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.deleteButton];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.contentView);
        }];
        
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(4);
            make.top.equalTo(self.contentView).offset(-5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
    }
    return self;
}
@end
