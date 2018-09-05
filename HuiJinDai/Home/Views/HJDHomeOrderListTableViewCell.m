//
//  HJDHomeOrderListTableViewCell.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeOrderListTableViewCell.h"

@interface HJDHomeOrderListTableViewCell()
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UILabel *numberLabel;
@property(nonatomic, strong) UILabel *timeLabel;
@property(nonatomic, strong) UILabel *addressLabel;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *moneyLabel;
@property(nonatomic, strong) UILabel *statusLabel;
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
        _numberLabel.textColor = kBlack;
        _numberLabel.font = kFont14;
    }
    return _numberLabel;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.textColor = kRGB_Color(0, 194, 157);
        _statusLabel.font = kFont14;
        _statusLabel.textAlignment = NSTextAlignmentRight;
    }
    return _statusLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = kGray;
        _timeLabel.font = kFont12;
    }
    return _timeLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.textColor = kGray;
        _addressLabel.font = kFont12;
    }
    return _addressLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = kGray;
        _nameLabel.font = kFont12;
    }
    return _nameLabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textColor = kGray;
        _moneyLabel.font = kFont12;
    }
    return _moneyLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = kControllerBackgroundColor;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.numberLabel];
    [self.bgView addSubview:self.statusLabel];
    [self.bgView addSubview:self.timeLabel];
    [self.bgView addSubview:self.addressLabel];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.moneyLabel];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = kControllerBackgroundColor;
    [self.bgView addSubview:lineView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(10);
        make.right.equalTo(self.bgView).offset(-110);
        make.top.equalTo(self.bgView);
        make.height.equalTo(@30);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-10);
        make.top.equalTo(self.bgView);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bgView);
        make.top.equalTo(self.numberLabel.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(10);
        make.right.equalTo(self.bgView).offset(-10);
        make.top.equalTo(lineView.mas_bottom);
        make.height.equalTo(@30);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(10);
        make.right.equalTo(self.bgView).offset(-10);
        make.top.equalTo(self.timeLabel.mas_bottom);
        make.height.equalTo(@30);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(10);
        make.right.equalTo(self.bgView).offset(-10);
        make.top.equalTo(self.addressLabel.mas_bottom);
        make.height.equalTo(@30);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(10);
        make.right.equalTo(self.bgView).offset(-10);
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.height.equalTo(@30);
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
    self.timeLabel.text = [NSString stringWithFormat:@"报单时间:      %@", orderTime];
}

- (void)setLocationAddress:(NSString *)locationAddress {
    _locationAddress = locationAddress;
    self.addressLabel.text = [NSString stringWithFormat:@"房屋坐落地址: %@", locationAddress];
}

- (void)setCustomerName:(NSString *)customerName {
    _customerName = customerName;
    self.nameLabel.text = [NSString stringWithFormat:@"客户姓名:      %@", customerName];
}

- (void)setMoney:(NSString *)money {
    _money = money;
    self.moneyLabel.text = [NSString stringWithFormat:@"申请金额:      %@", money];
}
@end
