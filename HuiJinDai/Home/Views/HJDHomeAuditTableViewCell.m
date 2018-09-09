//
//  HJDHomeAuditTableViewCell.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/9.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeAuditTableViewCell.h"

@interface HJDHomeAuditTableViewCell()
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIImageView *headImgView;
@property(nonatomic, strong) UIImageView *rightImgView;
@end

@implementation HJDHomeAuditTableViewCell

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = kRGB_Color(0xff, 0xff, 0xff);
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 8.f;
    }
    return _bgView;
}

- (UIImageView *)headImgView {
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc] initWithImage:kImage(@"工单审核（渠道权限）经纪人")];
    }
    return _headImgView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _nameLabel.font = kFont15;
    }
    return _nameLabel;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.backgroundColor = kRGB_Color(0xff, 0x52, 0x52);
        _numberLabel.textColor = kRGB_Color(0xff, 0xff, 0xff);
        _numberLabel.font = kFont10;
        _numberLabel.layer.masksToBounds = YES;
        _numberLabel.layer.cornerRadius = 8.f;
        _numberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numberLabel;
}

- (UIImageView *)rightImgView {
    if (!_rightImgView) {
        _rightImgView = [[UIImageView alloc] initWithImage:kImage(@"进入")];
    }
    return _rightImgView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
        
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.headImgView];
        [self.bgView addSubview:self.nameLabel];
        [self.bgView addSubview:self.numberLabel];
        [self.bgView addSubview:self.rightImgView];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.right.equalTo(self.contentView).offset(-16);
            make.height.equalTo(@44);
            make.bottom.equalTo(self.contentView);
        }];
        
        [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(16);
            make.centerY.equalTo(self.bgView);
            make.size.mas_equalTo(CGSizeMake(16, 16));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgView.mas_right).offset(16);
            make.centerY.equalTo(self.bgView);
            make.height.equalTo(@20);
            make.right.equalTo(self.numberLabel.mas_left).offset(-16);
        }];
        
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rightImgView.mas_left).offset(-12);
            make.centerY.equalTo(self.bgView);
            make.size.mas_equalTo(CGSizeMake(16, 16));
        }];
        
        [self.rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bgView).offset(-16);
            make.centerY.equalTo(self.bgView);
            make.size.mas_equalTo(CGSizeMake(9, 16));
        }];
    }
    return self;
}

- (void)setViewRoundingCorners:(UIRectCorner)corners {
    CGRect frame = CGRectMake(16, 1, kScreenWidth - 32, 44);
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:corners cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = frame;
    maskLayer.path = maskPath.CGPath;
    self.bgView.layer.mask = maskLayer;
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
