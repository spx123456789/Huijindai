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
@property(nonatomic, strong) UILabel *nameTextLabel;
@property(nonatomic, strong) UILabel *phoneLabel;
@property(nonatomic, strong) UILabel *phoneTextLabel;
@property(nonatomic, strong) UIImageView *imgView;
@end

@implementation HJDMyAgentTableViewCell

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = kWithe;
    }
    return _bgView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"姓名：";
        _nameLabel.textColor = kBlack;
        _nameLabel.font = kFont12;
    }
    return _nameLabel;
}

- (UILabel *)nameTextLabel {
    if (!_nameTextLabel) {
        _nameTextLabel = [[UILabel alloc] init];
        _nameTextLabel.text = @"";
        _nameTextLabel.textColor = kBlack;
        _nameTextLabel.font = kFont12;
    }
    return _nameTextLabel;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.text = @"联系电话：";
        _phoneLabel.textColor = kBlack;
        _phoneLabel.font = kFont12;
    }
    return _phoneLabel;
}

- (UILabel *)phoneTextLabel {
    if (!_phoneTextLabel) {
        _phoneTextLabel = [[UILabel alloc] init];
        _phoneTextLabel.text = @"";
        _phoneTextLabel.textColor = kBlack;
        _phoneTextLabel.font = kFont12;
    }
    return _phoneTextLabel;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithImage:kImage(@"3.png")];
    }
    return _imgView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = kRGB_Color(242, 242, 242);
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.nameTextLabel];
    [self.bgView addSubview:self.phoneLabel];
    [self.bgView addSubview:self.phoneTextLabel];
    [self.bgView addSubview:self.imgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(8);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(10);
        make.top.equalTo(self.bgView).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 25));
    }];
    
    [self.nameTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(8);
        make.top.equalTo(self.nameLabel);
        make.right.equalTo(self.bgView).offset(-60);
        make.bottom.equalTo(self.nameLabel);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(10);
        make.bottom.equalTo(self.bgView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 25));
    }];
    
    [self.phoneTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneLabel.mas_right).offset(8);
        make.top.equalTo(self.phoneLabel);
        make.right.equalTo(self.bgView).offset(-60);
        make.bottom.equalTo(self.phoneLabel);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-10);
        make.centerY.equalTo(self.bgView);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
}

- (void)setName:(NSString *)name {
    _name = name;
    self.nameTextLabel.text = name;
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
