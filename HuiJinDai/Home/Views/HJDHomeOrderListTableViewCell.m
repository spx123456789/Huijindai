//
//  HJDHomeOrderListTableViewCell.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeOrderListTableViewCell.h"

@interface HJDHomeOrderListTableViewCell()
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UILabel *numberLabel;
@property(nonatomic, strong) UILabel *statusLabel;
@property(nonatomic, strong) UIImageView *rightImgView;
@property(nonatomic, strong) UILabel *timeLabel;
@property(nonatomic, strong) UILabel *timeLabel_1;
@property(nonatomic, strong) UILabel *addressLabel;
@property(nonatomic, strong) UILabel *addressLabel_1;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *nameLabel_1;
@property(nonatomic, strong) UILabel *moneyLabel;
@property(nonatomic, strong) UILabel *moneyLabel_1;
@end

@implementation HJDHomeOrderListTableViewCell

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = kWithe;
    }
    return _bgView;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _numberLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _numberLabel;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.backgroundColor = kRGB_Color(0xfd, 0xea, 0xcc);
        _statusLabel.textColor = kMainColor;
        _statusLabel.font = kFont13;
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.layer.masksToBounds = YES;
        _statusLabel.layer.cornerRadius = 5.f;
    }
    return _statusLabel;
}

- (UIImageView *)rightImgView {
    if (!_rightImgView) {
        _rightImgView = [[UIImageView alloc] initWithImage:kImage(@"进入")];
    }
    return _rightImgView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [self createLabel];
        _timeLabel.text = @"报单时间：";
    }
    return _timeLabel;
}

- (UILabel *)timeLabel_1 {
    if (!_timeLabel_1) {
        _timeLabel_1 = [self createLabel_1];
    }
    return _timeLabel_1;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [self createLabel];
        _addressLabel.text = @"房屋地址：";
    }
    return _addressLabel;
}

- (UILabel *)addressLabel_1 {
    if (!_addressLabel_1) {
        _addressLabel_1 = [self createLabel_1];
    }
    return _addressLabel_1;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [self createLabel];
        _nameLabel.text = @"客户姓名：";
    }
    return _nameLabel;
}

- (UILabel *)nameLabel_1 {
    if (!_nameLabel_1) {
        _nameLabel_1 = [self createLabel_1];
    }
    return _nameLabel_1;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [self createLabel];
        _moneyLabel.text = @"申请金额：";
    }
    return _moneyLabel;
}

- (UILabel *)moneyLabel_1 {
    if (!_moneyLabel_1) {
        _moneyLabel_1 = [[UILabel alloc] init];
        _moneyLabel_1.textColor = kRGB_Color(0xff, 0x52, 0x52);
        _moneyLabel_1.font = [UIFont boldSystemFontOfSize:14];
    }
    return _moneyLabel_1;
}

- (UILabel *)createLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = kRGB_Color(0x99, 0x99, 0x99);
    label.font = kFont14;
    return label;
}

- (UILabel *)createLabel_1 {
    UILabel *label_1 = [[UILabel alloc] init];
    label_1.textColor = kRGB_Color(0x33, 0x33, 0x33);
    label_1.font = kFont14;
    return label_1;
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
    [self.bgView addSubview:self.numberLabel];
    [self.bgView addSubview:self.statusLabel];
    [self.bgView addSubview:self.rightImgView];
    [self.bgView addSubview:self.timeLabel];
    [self.bgView addSubview:self.addressLabel];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.moneyLabel];
    [self.bgView addSubview:self.timeLabel_1];
    [self.bgView addSubview:self.addressLabel_1];
    [self.bgView addSubview:self.nameLabel_1];
    [self.bgView addSubview:self.moneyLabel_1];
    
    UIView *color_line = [[UIView alloc] init];
    color_line.backgroundColor = kMainColor;
    [self.bgView addSubview:color_line];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = kLineColor;
    [self.bgView addSubview:lineView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(4);
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(16);
        make.top.equalTo(self.bgView);
        make.width.equalTo(@200);
        make.height.equalTo(@44);
    }];
    
    [color_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView);
        make.size.mas_equalTo(CGSizeMake(3, 15));
        make.centerY.equalTo(self.numberLabel);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numberLabel.mas_right).offset(10);
        make.centerY.equalTo(self.numberLabel);
        make.width.equalTo(@49);
        make.height.equalTo(@14);
    }];
    
    [self.rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.numberLabel);
        make.right.equalTo(self.bgView).offset(-16);
        make.size.mas_equalTo(CGSizeMake(9, 16));
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bgView);
        make.top.equalTo(self.numberLabel.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(16);
        make.width.equalTo(@75);
        make.top.equalTo(lineView.mas_bottom).offset(16);
        make.height.equalTo(@15);
    }];
    
    [self.timeLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_right).offset(12);
        make.right.equalTo(self.bgView).offset(-16);
        make.top.equalTo(self.timeLabel);
        make.height.equalTo(@15);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.timeLabel);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(12);
        make.height.equalTo(@15);
    }];
    
    [self.addressLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.timeLabel_1);
        make.top.equalTo(self.addressLabel);
        make.height.equalTo(@15);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.timeLabel);
        make.top.equalTo(self.addressLabel.mas_bottom).offset(12);
        make.height.equalTo(@15);
    }];
    
    [self.nameLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.timeLabel_1);
        make.top.equalTo(self.nameLabel);
        make.height.equalTo(@15);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.timeLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(12);
        make.height.equalTo(@15);
    }];
    
    [self.moneyLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.timeLabel_1);
        make.top.equalTo(self.moneyLabel);
        make.height.equalTo(@15);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setOrderNumber:(NSString *)orderNumber {
    _orderNumber = orderNumber;
    self.numberLabel.text = [NSString stringWithFormat:@"报单编号:%@", orderNumber];
}

- (void)setAuditStatus:(HJDOrderAuditStatus)auditStatus {
    _auditStatus = auditStatus;
    NSString *str = @"";
    switch (auditStatus) {
        case HJDOrderAuditStatus_To:
            str = @"待审核";
            break;
        case HJDOrderAuditStatus_In:
            str = @"审核中";
            break;
        case HJDOrderAuditStatus_End:
            str = @"审核完成";
            break;
        default:
            break;
    }
    self.statusLabel.text = str;
}

- (void)setOrderTime:(NSString *)orderTime {
    _orderTime = orderTime;
    self.timeLabel_1.text = orderTime;
}

- (void)setLocationAddress:(NSString *)locationAddress {
    _locationAddress = locationAddress;
    self.addressLabel_1.text = locationAddress;
}

- (void)setCustomerName:(NSString *)customerName {
    _customerName = customerName;
    self.nameLabel_1.text = customerName;
}

- (void)setMoney:(NSString *)money {
    _money = money;
    self.moneyLabel_1.text = money;
}
@end
