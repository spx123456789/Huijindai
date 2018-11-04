//
//  HJDHomeQueryValueResultTableViewCell.m
//  HuiJinDai
//
//  Created by GXW on 2018/10/13.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeQueryValueResultTableViewCell.h"

@interface HJDHomeQueryValueResultTableViewCell()
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIImageView *iconImgView;
@property(nonatomic, strong) UILabel *priceLabel;
@property(nonatomic, strong) UILabel *priceLabel2;
@property(nonatomic, strong) UILabel *total_priceLabel;
@property(nonatomic, strong) UILabel *total_priceLabel2;
@end

@implementation HJDHomeQueryValueResultTableViewCell

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _titleLabel.font = [UIFont boldSystemFontOfSize:12];
    }
    return _titleLabel;
}

- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
    }
    return _iconImgView;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.textColor = kMainColor;
        _priceLabel.font = [UIFont boldSystemFontOfSize:17];
    }
    return _priceLabel;
}

- (UILabel *)priceLabel2 {
    if (!_priceLabel2) {
        _priceLabel2 = [[UILabel alloc] init];
        _priceLabel2.text = @"评估单价";
        _priceLabel2.textAlignment = NSTextAlignmentCenter;
        _priceLabel2.textColor = kRGB_Color(0x99, 0x99, 0x99);
        _priceLabel2.font = kFont10;
    }
    return _priceLabel2;
}

- (UILabel *)total_priceLabel {
    if (!_total_priceLabel) {
        _total_priceLabel = [[UILabel alloc] init];
        _total_priceLabel.textAlignment = NSTextAlignmentCenter;
        _total_priceLabel.textColor = kRGB_Color(0xff, 0x52, 0x52);
        _total_priceLabel.font = [UIFont boldSystemFontOfSize:17];
    }
    return _total_priceLabel;
}

- (UILabel *)total_priceLabel2 {
    if (!_total_priceLabel2) {
        _total_priceLabel2 = [[UILabel alloc] init];
        _total_priceLabel2.text = @"评估总价";
        _total_priceLabel2.textAlignment = NSTextAlignmentCenter;
        _total_priceLabel2.textColor = kRGB_Color(0x99, 0x99, 0x99);
        _total_priceLabel2.font = kFont10;
    }
    return _total_priceLabel2;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setCellValue:(NSDictionary *)dic {
    NSString *company = dic[@"assessCompany"];
    NSString *title = @"";
    switch (company.integerValue) {
        case 01: {
            title = @"世联";
            break;
        }
        case 02: {
            title = @"仁达";
            break;
        }
        default: {
            title = @"首佳";
            break;
        }
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%@评估", title];
    self.iconImgView.image = kImage(@"我的默认头像");
    self.priceLabel.text = dic[@"unitPrice"];
    self.total_priceLabel.text = dic[@"totalPrice"];
}

- (void)setUpUI {
    UIView *bgView = [[UIView alloc] init];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 8.f;
    bgView.backgroundColor = kRGB_Color(0xf8, 0xf8, 0xf8);
    [self.contentView addSubview:bgView];
    
    [bgView addSubview:self.titleLabel];
    [bgView addSubview:self.iconImgView];
    [bgView addSubview:self.priceLabel];
    [bgView addSubview:self.priceLabel2];
    [bgView addSubview:self.total_priceLabel];
    [bgView addSubview:self.total_priceLabel2];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView).offset(16);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(16);
        make.centerX.equalTo(self.iconImgView);
        make.width.equalTo(@60);
        make.height.equalTo(@12);
    }];
    
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(30);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.bottom.equalTo(bgView).offset(-16);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(40);
        make.size.mas_equalTo(CGSizeMake(90, 17));
        //make.right.equalTo(self.total_priceLabel2.mas_left).offset(-30);
        make.left.equalTo(self.iconImgView.mas_right).offset(20);
    }];
    
    [self.priceLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.priceLabel);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(8);
        make.height.equalTo(@10);
    }];
    
    [self.total_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabel);
        make.size.mas_equalTo(CGSizeMake(120, 17));
        make.right.equalTo(bgView).offset(-20);
    }];
    
    [self.total_priceLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.total_priceLabel);
        make.top.equalTo(self.total_priceLabel.mas_bottom).offset(8);
        make.height.equalTo(@10);
    }];
}

@end

#pragma mark -询值剩余次数
@interface HJDHomeQueryValueResultNumberTableCell()
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *subLabel;
@end

@implementation HJDHomeQueryValueResultNumberTableCell

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = kMainColor;
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _titleLabel;
}

- (UILabel *)subLabel {
    if (!_subLabel) {
        _subLabel = [[UILabel alloc] init];
        _subLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _subLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    UIView *bgView = [[UIView alloc] init];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 8.f;
    bgView.backgroundColor = kRGB_Color(0xf8, 0xf8, 0xf8);
    [self.contentView addSubview:bgView];
    
    UIView *clickView = [[UIView alloc] init];
    clickView.backgroundColor = [UIColor clearColor];
    clickView.layer.masksToBounds = YES;
    clickView.layer.cornerRadius = 4.f;
    clickView.layer.borderWidth = 0.5f;
    clickView.layer.borderColor = kMainColor.CGColor;
    [bgView addSubview:clickView];
    
    [clickView addSubview:self.titleLabel];
    [clickView addSubview:self.subLabel];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView).offset(16);
        make.bottom.equalTo(self.contentView);
    }];
    
    [clickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bgView);
        make.size.mas_equalTo(CGSizeMake(230, 44));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(clickView);
        make.top.equalTo(clickView).offset(5);
        make.height.equalTo(@15);
    }];
    
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(4);
        make.height.equalTo(@10);
    }];
}

- (void)setCompany:(NSString *)company {
    _company = company;
    self.titleLabel.text = [NSString stringWithFormat:@"点击查看%@询值结果", company];
}

- (void)setNumber:(NSString *)number {
    _number = number;
    NSString *str = [NSString stringWithFormat:@"您当前询值次数还剩%@次", number];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{ NSFontAttributeName : kFont10, NSForegroundColorAttributeName : kRGB_Color(0x99, 0x99, 0x99) }];
    [attributeStr setAttributes:@{ NSFontAttributeName : kFont10, NSForegroundColorAttributeName : kRGB_Color(0xff, 0x52, 0x52)} range:NSMakeRange(str.length - 2, 2)];
    self.subLabel.attributedText = attributeStr;
}
@end
