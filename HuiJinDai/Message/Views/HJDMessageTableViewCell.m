//
//  HJDMessageTableViewCell.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/9.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMessageTableViewCell.h"

@interface HJDMessageTableViewCell()
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *subLabel;
@property(nonatomic, strong) UIView *color_line;
@property(nonatomic, strong) UIView *line;
@property(nonatomic, strong) UILabel *numberLabel;
@property(nonatomic, strong) UILabel *numberLabel_1;
@property(nonatomic, strong) UILabel *typeLabel;
@property(nonatomic, strong) UILabel *typeLabel_1;
@property(nonatomic, strong) UILabel *statusLabel;
@property(nonatomic, strong) UILabel *statusLabel_1;
@property(nonatomic, strong) UIView *line2;
@property(nonatomic, strong) UIView *line3;
@property(nonatomic, strong) UIImageView *rightImgView;
@end

@implementation HJDMessageTableViewCell

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = kRGB_Color(0xff, 0xff, 0xff);
    }
    return _bgView;
}

- (UIImageView *)rightImgView {
    if (!_rightImgView) {
        _rightImgView = [[UIImageView alloc] initWithImage:kImage(@"进入")];
    }
    return _rightImgView;
}

- (UILabel *)channelLabel {
    if (!_channelLabel) {
        _channelLabel = [[UILabel alloc] init];
        _channelLabel.text = @"渠道";
        _channelLabel.backgroundColor = kRGB_Color(0xd6, 0xe8, 0xff);
        _channelLabel.textColor = kRGB_Color(0x32, 0x8b, 0xff);
        _channelLabel.font = kFont10;
        _channelLabel.textAlignment = NSTextAlignmentCenter;
        _channelLabel.layer.masksToBounds = YES;
        _channelLabel.layer.cornerRadius = 3.f;
    }
    return _channelLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"订单进度处理通知";
        _titleLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _titleLabel;
}

- (UILabel *)subLabel {
    if (!_subLabel) {
        _subLabel = [[UILabel alloc] init];
        _subLabel.text = @"张先生，你好";
        _subLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _subLabel.font = kFont14;
    }
    return _subLabel;
}

- (UIView *)color_line {
    if (!_color_line) {
        _color_line = [[UIView alloc] init];
        _color_line.backgroundColor = kMainColor;
    }
    return _color_line;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    }
    return _line;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.text = @"报单编号";
        _numberLabel.textColor = kRGB_Color(0x99, 0x99, 0x99);
        _numberLabel.font = kFont14;
    }
    return _numberLabel;
}

- (UILabel *)numberLabel_1 {
    if (!_numberLabel_1) {
        _numberLabel_1 = [[UILabel alloc] init];
        _numberLabel_1.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _numberLabel_1.font = kFont14;
        _numberLabel_1.textAlignment = NSTextAlignmentRight;
    }
    return _numberLabel_1;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.text = @"工单类型";
        _typeLabel.textColor = kRGB_Color(0x99, 0x99, 0x99);
        _typeLabel.font = kFont14;
    }
    return _typeLabel;
}

- (UILabel *)typeLabel_1 {
    if (!_typeLabel_1) {
        _typeLabel_1 = [[UILabel alloc] init];
        _typeLabel_1.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _typeLabel_1.font = kFont14;
        _typeLabel_1.textAlignment = NSTextAlignmentRight;
    }
    return _typeLabel_1;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.text = @"报单编号";
        _statusLabel.textColor = kRGB_Color(0x99, 0x99, 0x99);
        _statusLabel.font = kFont14;
    }
    return _statusLabel;
}

- (UILabel *)statusLabel_1 {
    if (!_statusLabel_1) {
        _statusLabel_1 = [[UILabel alloc] init];
        _statusLabel_1.textColor = kMainColor;
        _statusLabel_1.font = kFont14;
        _statusLabel_1.textAlignment = NSTextAlignmentRight;
    }
    return _statusLabel_1;
}

- (UIView *)line2 {
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    }
    return _line2;
}

- (UIView *)line3 {
    if (!_line3) {
        _line3 = [[UIView alloc] init];
        _line3.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    }
    return _line3;
}

- (void)setUpUI {
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.subLabel];
    [self.bgView addSubview:self.channelLabel];
    [self.bgView addSubview:self.rightImgView];
    [self.bgView addSubview:self.color_line];
    [self.bgView addSubview:self.line];
    [self.bgView addSubview:self.numberLabel];
    [self.bgView addSubview:self.numberLabel_1];
    [self.bgView addSubview:self.line2];
    [self.bgView addSubview:self.typeLabel];
    [self.bgView addSubview:self.typeLabel_1];
    [self.bgView addSubview:self.line3];
    [self.bgView addSubview:self.statusLabel];
    [self.bgView addSubview:self.statusLabel_1];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(4);
    }];
    
    [self.color_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView);
        make.top.equalTo(self.bgView).offset(16);
        make.size.mas_equalTo(CGSizeMake(3, 16));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(16);
        make.top.equalTo(self.bgView).offset(16);
        make.size.mas_equalTo(CGSizeMake(130, 15));
    }];
    
    [self.channelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(16);
        make.top.equalTo(self.bgView).offset(16);
        make.size.mas_equalTo(CGSizeMake(40, 14));
    }];
    
    [self .rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-16);
        make.centerY.equalTo(self.bgView.mas_top).offset(26);
        make.size.mas_equalTo(CGSizeMake(9, 16));
    }];
    
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(16);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
        make.size.mas_equalTo(CGSizeMake(160, 14));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView);
        make.right.equalTo(self.bgView);
        make.top.equalTo(self.subLabel.mas_bottom).offset(16);
        make.height.equalTo(@1);
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(16);
        make.top.equalTo(self.line.mas_bottom).offset(14);
        make.size.mas_equalTo(CGSizeMake(60, 14));
    }];
    
    [self.numberLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numberLabel.mas_right).offset(16);
        make.right.equalTo(self.bgView).offset(-16);
        make.top.equalTo(self.numberLabel);
        make.height.equalTo(@14);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(16);
        make.right.equalTo(self.bgView).offset(-16);
        make.top.equalTo(self.numberLabel.mas_bottom).offset(14);
        make.height.equalTo(@1);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.numberLabel);
        make.top.equalTo(self.line2.mas_bottom).offset(14);
    }];
    
    [self.typeLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeLabel.mas_right).offset(16);
        make.right.equalTo(self.bgView).offset(-16);
        make.top.equalTo(self.typeLabel);
        make.height.equalTo(@14);
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(16);
        make.right.equalTo(self.bgView).offset(-16);
        make.top.equalTo(self.typeLabel.mas_bottom).offset(14);
        make.height.equalTo(@1);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.numberLabel);
        make.top.equalTo(self.line3.mas_bottom).offset(14);
    }];
    
    [self.statusLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.statusLabel.mas_right).offset(16);
        make.right.equalTo(self.bgView).offset(-16);
        make.top.equalTo(self.statusLabel);
        make.height.equalTo(@14);
    }];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
        [self setUpUI];
    }
    return self;
}

- (void)setNumber:(NSString *)number {
    _number = number;
    self.numberLabel_1.text = number;
}

- (void)setType:(NSString *)type {
    _type = type;
    self.typeLabel_1.text = type;
}

- (void)setStatus:(NSString *)status {
    _status = status;
    self.statusLabel_1.text = status;
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
