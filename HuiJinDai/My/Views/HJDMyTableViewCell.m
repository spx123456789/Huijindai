//
//  HJDMyTableViewCell.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/1.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMyTableViewCell.h"

@interface HJDMyTableViewCell()
@property(nonatomic, strong) UIView *bgView;
@end

@implementation HJDMyTableViewCell

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = kRGB_Color(255, 255, 255);
    }
    return _bgView;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlack;
        _titleLabel.font = kFont12;
    }
    return _titleLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = kRGB_Color(242, 242, 242);
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.imgView];
        [self.bgView addSubview:self.titleLabel];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(@50);
        }];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(10);
            make.centerY.equalTo(self.bgView);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(10);
            make.centerY.equalTo(self.bgView);
            make.right.equalTo(self.bgView);
            make.height.equalTo(@30);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

#pragma mark - HJDMyTableHeaderView
@interface HJDMyTableHeaderView()
@property(nonatomic, strong) UIImageView *bgView;
@end

@implementation HJDMyTableHeaderView
- (UIImageView *)bgView {
    if (!_bgView) {
        _bgView = [[UIImageView alloc] init];
        _bgView.image = kImage(@"bg.jpg");
    }
    return _bgView;
}

- (UIImageView *)headImgView {
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc] init];
    }
    return _headImgView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = kBlack;
        _nameLabel.font = kFont12;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kRGB_Color(242, 242, 242);
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.headImgView];
        [self.bgView addSubview:self.nameLabel];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(self).offset(10);
        }];
        
        [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgView);
            make.top.equalTo(self.bgView).offset(15);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgView);
            make.top.equalTo(self.headImgView.mas_bottom).offset(8);
            make.size.mas_equalTo(CGSizeMake(80, 20));
        }];
    }
    return self;
}
@end
