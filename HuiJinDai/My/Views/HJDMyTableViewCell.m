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
@property(nonatomic, strong) UIImageView *rowImgView;
@end

@implementation HJDMyTableViewCell

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = kRGB_Color(248, 248, 248);
    }
    return _bgView;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

- (UIImageView *)rowImgView {
    if (!_rowImgView) {
        _rowImgView = [[UIImageView alloc] init];
        _rowImgView.image = kImage(@"进入");
    }
    return _rowImgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _titleLabel.font = kFont15;
    }
    return _titleLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = kControllerBackgroundColor;
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.imgView];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.rowImgView];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.height.equalTo(@50);
        }];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(16);
            make.centerY.equalTo(self.bgView);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(16);
            make.centerY.equalTo(self.bgView);
            make.right.equalTo(self.bgView).offset(-80);
            make.height.equalTo(@20);
        }];
        
        [self.rowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bgView).offset(-16);
            make.centerY.equalTo(self.bgView);
            make.size.mas_equalTo(CGSizeMake(9, 16));
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
@property(nonatomic, strong) UIView *headBgView;
@end

@implementation HJDMyTableHeaderView
- (UIImageView *)bgView {
    if (!_bgView) {
        _bgView = [[UIImageView alloc] init];
        _bgView.image = kImage(@"我的页背景");
    }
    return _bgView;
}

- (UIView *)headBgView {
    if (!_headBgView) {
        _headBgView = [[UIView alloc] init];
        _headBgView.backgroundColor = kRGB_Color(0xff, 0xff, 0xff);
    }
    return _headBgView;
}

- (UIImageView *)headImgView {
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc] init];
        _headImgView.userInteractionEnabled = YES;
    }
    return _headImgView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _nameLabel.font = [UIFont boldSystemFontOfSize:17];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kControllerBackgroundColor;
        [self addSubview:self.bgView];
        [self addSubview:self.headBgView];
        [self addSubview:self.headImgView];
        [self addSubview:self.nameLabel];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(@210);
        }];
        
        [self.headBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.bgView.mas_bottom).offset(-34);
            make.size.mas_equalTo(CGSizeMake(68, 68));
        }];
        
        [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.bgView.mas_bottom).offset(-32);
            make.size.mas_equalTo(CGSizeMake(64, 64));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.headImgView.mas_bottom).offset(12);
            make.size.mas_equalTo(CGSizeMake(68, 20));
        }];
    }
    return self;
}
@end
