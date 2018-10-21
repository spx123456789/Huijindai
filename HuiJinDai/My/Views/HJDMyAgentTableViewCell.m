//
//  HJDMyAgentTableViewCell.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMyAgentTableViewCell.h"

@interface HJDMyAgentTableViewCell()
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UIImageView *phoneImgView;
@property(nonatomic, strong) UILabel *phoneTextLabel;
@property(nonatomic, strong) UIImageView *rightImgView;
@end

@implementation HJDMyAgentTableViewCell

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = kRGB_Color(0xff, 0xff, 0xff);
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 8.f;
    }
    return _bgView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"姓名：";
        _nameLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _nameLabel.font = [UIFont boldSystemFontOfSize:17];
    }
    return _nameLabel;
}

- (UIImageView *)phoneImgView {
    if (!_phoneImgView) {
        _phoneImgView = [[UIImageView alloc] init];
        _phoneImgView.image = kImage(@"我的经纪人电话小图标");
    }
    return _phoneImgView;
}

- (UILabel *)phoneTextLabel {
    if (!_phoneTextLabel) {
        _phoneTextLabel = [[UILabel alloc] init];
        _phoneTextLabel.textColor = kRGB_Color(0x99, 0x99, 0x99);
        _phoneTextLabel.font = kFont14;
    }
    return _phoneTextLabel;
}

- (UIImageView *)rightImgView {
    if (!_rightImgView) {
        _rightImgView = [[UIImageView alloc] initWithImage:kImage(@"我的经纪人拨打电话")];
        _rightImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [_rightImgView addGestureRecognizer:tap];
    }
    return _rightImgView;
}

- (void)tapGesture:(UITapGestureRecognizer *)tap {
    if (self.delegate && [self.delegate respondsToSelector:@selector(myAgentCell:didClickPhone:)]) {
        [self.delegate myAgentCell:self didClickPhone:tap];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.phoneImgView];
    [self.bgView addSubview:self.phoneTextLabel];
    [self.bgView addSubview:self.rightImgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView).offset(12);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(16);
        make.top.equalTo(self.bgView).offset(16);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    [self.phoneImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(16);
        make.bottom.equalTo(self.bgView).offset(-16);
        make.size.mas_equalTo(CGSizeMake(8, 12));
    }];
    
    [self.phoneTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneImgView.mas_right).offset(3);
        make.centerY.equalTo(self.phoneImgView);
        make.right.equalTo(self.bgView).offset(-160);
        make.height.equalTo(@16);
    }];
    
    [self.rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-16);
        make.centerY.equalTo(self.bgView);
        make.size.mas_equalTo(CGSizeMake(23, 23));
    }];
}

- (void)setName:(NSString *)name {
    _name = name;
    self.nameLabel.text = [NSString stringWithFormat:@"姓名：%@", name];
}

- (void)setPhone:(NSString *)phone {
    _phone = phone;
    self.phoneTextLabel.text = phone;
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
