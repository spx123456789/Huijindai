//
//  HJDHomeOrderDetailTableViewCell.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/16.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeOrderDetailTableViewCell.h"

@implementation HJDHomeOrderDetailTableViewCell

- (UILabel *)createLeftLabelWithTitle:(NSString *)title {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = kRGB_Color(0x99, 0x99, 0x99);
    label.text = title;
    label.font = kFont14;
    return label;
}

- (UILabel *)createRightLabel {
    UILabel *label_1 = [[UILabel alloc] init];
    label_1.textColor = kRGB_Color(0x33, 0x33, 0x33);
    label_1.font = kFont14;
    label_1.textAlignment = NSTextAlignmentLeft;
    return label_1;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = kWithe;
    }
    return _bgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _titleLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kLineColor;
    }
    return _lineView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
        
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.lineView];
        
        UIView *color_line = [[UIView alloc] init];
        color_line.backgroundColor = kMainColor;
        [self.bgView addSubview:color_line];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-4);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(16);
            make.top.equalTo(self.bgView);
            make.right.equalTo(self.bgView).offset(-16);
            make.height.equalTo(@44);
        }];
        
        [color_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView);
            make.size.mas_equalTo(CGSizeMake(3, 16));
            make.centerY.equalTo(self.titleLabel);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgView);
            make.top.equalTo(self.titleLabel.mas_bottom);
            make.height.equalTo(@1);
        }];
    }
    return self;
}

@end

#pragma mark - 询值信息
@interface HJDHomeOrderDetailQueryCell()
@property(nonatomic, strong) UILabel *cityLabel;
@property(nonatomic, strong) UILabel *cityLabel_1;
@property(nonatomic, strong) UILabel *xiaoquLabel;
@property(nonatomic, strong) UILabel *xiaoquLabel_1;
@property(nonatomic, strong) UILabel *addressLabel;
@property(nonatomic, strong) UILabel *addressLabel_1;
@property(nonatomic, strong) UILabel *useLabel;
@property(nonatomic, strong) UILabel *useLabel_1;
@property(nonatomic, strong) UILabel *areaLabel;
@property(nonatomic, strong) UILabel *areaLabel_1;
@end

@implementation HJDHomeOrderDetailQueryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cityLabel = [self createLeftLabelWithTitle:@"城市："];
        self.xiaoquLabel = [self createLeftLabelWithTitle:@"小区名称："];
        self.addressLabel = [self createLeftLabelWithTitle:@"房屋地址："];
        self.useLabel = [self createLeftLabelWithTitle:@"规划用途："];
        self.areaLabel = [self createLeftLabelWithTitle:@"建筑面积："];
        [self.bgView addSubview:self.cityLabel];
        [self.bgView addSubview:self.xiaoquLabel];
        [self.bgView addSubview:self.addressLabel];
        [self.bgView addSubview:self.useLabel];
        [self.bgView addSubview:self.areaLabel];
        
        self.cityLabel_1 = [self createRightLabel];
        self.xiaoquLabel_1 = [self createRightLabel];
        self.addressLabel_1 = [self createRightLabel];
        self.useLabel_1 = [self createRightLabel];
        self.areaLabel_1 = [self createRightLabel];
        [self.bgView addSubview:self.cityLabel_1];
        [self.bgView addSubview:self.xiaoquLabel_1];
        [self.bgView addSubview:self.addressLabel_1];
        [self.bgView addSubview:self.useLabel_1];
        [self.bgView addSubview:self.areaLabel_1];
        
        [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(16);
            make.top.equalTo(self.lineView.mas_bottom).offset(16);
            make.height.equalTo(@14);
            make.width.equalTo(@75);
        }];
        
        [self.cityLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cityLabel.mas_right).offset(12);
            make.right.equalTo(self.bgView).offset(-16);
            make.top.height.equalTo(self.cityLabel);
        }];
        
        [self.xiaoquLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.cityLabel);
            make.top.equalTo(self.cityLabel.mas_bottom).offset(12);
        }];
        
        [self.xiaoquLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.cityLabel_1);
            make.top.equalTo(self.xiaoquLabel);
        }];
        
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.cityLabel);
            make.top.equalTo(self.xiaoquLabel.mas_bottom).offset(12);
        }];
        
        [self.addressLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.cityLabel_1);
            make.top.equalTo(self.addressLabel);
        }];
        
        [self.useLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.cityLabel);
            make.top.equalTo(self.addressLabel.mas_bottom).offset(12);
        }];
        
        [self.useLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.cityLabel_1);
            make.top.equalTo(self.useLabel);
        }];
        
        [self.areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.cityLabel);
            make.top.equalTo(self.useLabel.mas_bottom).offset(12);
        }];
        
        [self.areaLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.cityLabel_1);
            make.top.equalTo(self.areaLabel);
        }];
    }
    return self;
}

- (void)setCellValue:(HJDHomeQueryValueDetailModel *)model {
    self.cityLabel_1.text = [NSString stringWithFormat:@"%@%@%@", model.provinceName, model.cityName, model.districtName];
    self.xiaoquLabel_1.text = model.communityName;
    self.addressLabel_1.text = model.address;
    self.useLabel_1.text = model.planning;
    self.areaLabel_1.text = [NSString stringWithFormat:@"%@m²", model.houseSpace];
}

- (void)setDetailCellValue:(NSDictionary *)dic {
    self.cityLabel_1.text = dic[@"city"];
    self.xiaoquLabel_1.text = dic[@"community_name"];
    self.addressLabel_1.text = @"";
    self.useLabel_1.text = dic[@"guihua"];
    self.areaLabel_1.text = dic[@"area"];
}
@end

#pragma mark - 保单信息
@interface HJDHomeOrderDetailDeclarationCell()
@property(nonatomic, strong) UILabel *typeLabel;
@property(nonatomic, strong) UILabel *typeLabel_1;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *nameLabel_1;
@property(nonatomic, strong) UILabel *idLabel;
@property(nonatomic, strong) UILabel *idLabel_1;
@property(nonatomic, strong) UILabel *idNumberLabel;
@property(nonatomic, strong) UILabel *idNumberLabel_1;
@property(nonatomic, strong) UILabel *moneyLabel;
@property(nonatomic, strong) UILabel *moneyLabel_1;
@property(nonatomic, strong) UILabel *limitTimeLabel;
@property(nonatomic, strong) UILabel *limitTimeLabel_1;
@property(nonatomic, strong) UILabel *yuELabel;
@property(nonatomic, strong) UILabel *yuELabel_1;
@end

@implementation HJDHomeOrderDetailDeclarationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.typeLabel = [self createLeftLabelWithTitle:@"贷款品种："];
        self.nameLabel = [self createLeftLabelWithTitle:@"客户姓名："];
        self.idLabel = [self createLeftLabelWithTitle:@"证件类型："];
        self.idNumberLabel = [self createLeftLabelWithTitle:@"证件号码："];
        self.moneyLabel = [self createLeftLabelWithTitle:@"申请金额："];
        self.limitTimeLabel = [self createLeftLabelWithTitle:@"申请期限："];
        self.yuELabel = [self createLeftLabelWithTitle:@"一抵余额："];
        [self.bgView addSubview:self.typeLabel];
        [self.bgView addSubview:self.nameLabel];
        [self.bgView addSubview:self.idLabel];
        [self.bgView addSubview:self.idNumberLabel];
        [self.bgView addSubview:self.moneyLabel];
        [self.bgView addSubview:self.limitTimeLabel];
        [self.bgView addSubview:self.yuELabel];
        
        
        self.typeLabel_1 = [self createRightLabel];
        self.nameLabel_1 = [self createRightLabel];
        self.idLabel_1 = [self createRightLabel];
        self.idNumberLabel_1 = [self createRightLabel];
        self.moneyLabel_1 = [self createRightLabel];
        self.moneyLabel_1.textColor = kMainColor;
        self.moneyLabel_1.font = [UIFont boldSystemFontOfSize:14];
        self.limitTimeLabel_1 = [self createRightLabel];
        self.yuELabel_1 = [self createRightLabel];
        [self.bgView addSubview:self.typeLabel_1];
        [self.bgView addSubview:self.nameLabel_1];
        [self.bgView addSubview:self.idLabel_1];
        [self.bgView addSubview:self.idNumberLabel_1];
        [self.bgView addSubview:self.moneyLabel_1];
        [self.bgView addSubview:self.limitTimeLabel_1];
        [self.bgView addSubview:self.yuELabel_1];
        
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(16);
            make.top.equalTo(self.lineView.mas_bottom).offset(16);
            make.height.equalTo(@14);
            make.width.equalTo(@75);
        }];
        
        [self.typeLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.typeLabel.mas_right).offset(12);
            make.right.equalTo(self.bgView).offset(-16);
            make.top.height.equalTo(self.typeLabel);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.typeLabel);
            make.top.equalTo(self.typeLabel.mas_bottom).offset(12);
        }];
        
        [self.nameLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.typeLabel_1);
            make.top.equalTo(self.nameLabel);
        }];
        
        [self.idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.typeLabel);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(12);
        }];
        
        [self.idLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.typeLabel_1);
            make.top.equalTo(self.idLabel);
        }];
        
        [self.idNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.typeLabel);
            make.top.equalTo(self.idLabel.mas_bottom).offset(12);
        }];
        
        [self.idNumberLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.typeLabel_1);
            make.top.equalTo(self.idNumberLabel);
        }];
        
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.typeLabel);
            make.top.equalTo(self.idNumberLabel.mas_bottom).offset(12);
        }];
        
        [self.moneyLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.typeLabel_1);
            make.top.equalTo(self.moneyLabel);
        }];
        
        [self.limitTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.typeLabel);
            make.top.equalTo(self.moneyLabel.mas_bottom).offset(12);
        }];
        
        [self.limitTimeLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.typeLabel_1);
            make.top.equalTo(self.limitTimeLabel);
        }];
        
        [self.yuELabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.typeLabel);
            make.top.equalTo(self.limitTimeLabel.mas_bottom).offset(12);
        }];
        
        [self.yuELabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.typeLabel_1);
            make.top.equalTo(self.yuELabel);
        }];
    }
    return self;
}

- (void)setCellDeclarationValue:(NSDictionary *)dic {
    self.typeLabel_1.text = dic[@"loan_type"];
    self.nameLabel_1.text = dic[@"customer_name"];
    self.idLabel_1.text = dic[@"customer_type"];
    self.idNumberLabel_1.text = dic[@"customer_number"];
    self.moneyLabel_1.text = dic[@"loan_money"];
    self.limitTimeLabel_1.text = dic[@"loan_time"];
    self.yuELabel_1.text = dic[@"loan_yd"];
}

@end

#pragma mark - 工单流程
@interface HJDHomeOrderDetailProcessCell()

@end

@implementation HJDHomeOrderDetailProcessCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
    }
    return self;
}

- (void)setProcessArray:(NSArray *)processArray {
    _processArray = processArray;
    CGFloat viewHeight = 12 + 12 + 17 + 8 + 14 + 4 + 12 + 12;
    
    UIView *firstView = nil;
    for (int i = 0; i < processArray.count; i++) {
        NSDictionary *dictionary = processArray[i];
        NSString *agree = dictionary[@"step"];
        NSString *process = @"";
        switch (agree.integerValue) {
            case 1:
                process = @"待审核";
                break;
            case 2:
                process = @"审核中";
                break;
            case 3:
                process = @"审核完成";
                break;
            case 4:
                process = @"审核终止";
                break;
            case 5:
                process = @"审核打回";
                break;
            case 6:
                process = @"审核暂留";
                break;
            default:
                break;
        }
        UIView *view = [self createViewWithTitle:dictionary[@"title"] subTitle:dictionary[@"user"] process:process time:dictionary[@"ad_time"] hideTop:(i == 0) hideBottom:(i == processArray.count - 1) agree:!(agree.integerValue == 4)];
        [self.bgView addSubview:view];
        
        if (firstView == nil) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.bgView);
                make.top.equalTo(self.lineView.mas_bottom).offset(4);
                make.height.equalTo(@(viewHeight));
            }];
        } else {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.bgView);
                make.top.equalTo(firstView.mas_bottom);
                make.height.equalTo(@(viewHeight));
            }];
        }
        firstView = view;
    }
}

- (UIView *)createViewWithTitle:(NSString *)title subTitle:(NSString *)subTitle process:(NSString *)process time:(NSString *)time hideTop:(BOOL)hideTop hideBottom:(BOOL)hideBottom agree:(BOOL)agree {
    UIView *mainView = [[UIView alloc] init];
    mainView.backgroundColor = kWithe;
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = kRGB_Color(0xd1, 0xfc, 0xe7);
    [mainView addSubview:topView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:kImage(@"工单详情对勾")];
    if (!agree) {
        imgView.image = kImage(@"工单详情拒单");
    }
    [mainView addSubview:imgView];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = kRGB_Color(0xd1, 0xfc, 0xe7);
    [mainView addSubview:bottomView];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 8.f;
    bgView.backgroundColor = kRGB_Color(0xf8, 0xf8, 0xf8);
    [mainView addSubview:bgView];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = title;
    label1.textColor = kRGB_Color(0x33, 0x33, 0x33);
    label1.font = [UIFont boldSystemFontOfSize:17];
    [bgView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = subTitle;
    label2.textColor = kRGB_Color(0x66, 0x66, 0x66);
    label2.font = kFont14;
    [bgView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = process;
    label3.textColor = kMainColor;
    label3.font = kFont12;
    [bgView addSubview:label3];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.text = time;
    timeLabel.textColor = kRGB_Color(0x99, 0x99, 0x99);
    timeLabel.font = kFont12;
    timeLabel.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:timeLabel];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainView).offset(23.5);
        make.top.equalTo(mainView);
        make.size.mas_equalTo(CGSizeMake(1, 26));
    }];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainView).offset(16);
        make.top.equalTo(topView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(topView);
        make.top.equalTo(imgView.mas_bottom);
        make.bottom.equalTo(mainView);
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgView.mas_right).offset(16);
        make.right.equalTo(mainView).offset(-16);
        make.bottom.equalTo(mainView);
        make.top.equalTo(mainView).offset(12);
    }];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(12);
        make.left.equalTo(bgView).offset(12);
        make.size.mas_equalTo(CGSizeMake(40, 17));
    }];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(8);
        make.left.equalTo(bgView).offset(12);
        make.right.equalTo(bgView).offset(-12);
        make.height.equalTo(@14);
    }];
    
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2.mas_bottom).offset(4);
        make.left.equalTo(bgView).offset(12);
        make.right.equalTo(bgView).offset(-12);
        make.height.equalTo(@12);
    }];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label1);
        make.left.equalTo(label1.mas_right).offset(12);
        make.right.equalTo(bgView).offset(-12);
        make.height.equalTo(@12);
    }];
    
    topView.hidden = hideTop;
    bottomView.hidden = hideBottom;
    
    return mainView;
}
@end

#pragma mark - 询值结果
@interface HJDHomeOrderDetailQueryValueResultSubCell : UITableViewCell
@property(nonatomic, strong) UILabel *priceLabel;
@property(nonatomic, strong) UILabel *priceLabel_1;
@property(nonatomic, strong) UILabel *totalPriceLabel;
@property(nonatomic, strong) UILabel *totalPriceLabel_1;
@property(nonatomic, strong) UIView *lineView;
@end

@implementation HJDHomeOrderDetailQueryValueResultSubCell

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kLineColor;
    }
    return _lineView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.priceLabel = [self createSubLeftLabelWithTitle:@"仁达单价："];
        self.totalPriceLabel = [self createSubLeftLabelWithTitle:@"仁达总价："];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.totalPriceLabel];
        
        self.priceLabel_1 = [self createSubRightLabel];
        self.priceLabel_1.textColor = kMainColor;
        [self.contentView addSubview:self.priceLabel_1];
        
        self.totalPriceLabel_1 = [self createSubRightLabel];
        self.totalPriceLabel_1.textColor = kRGB_Color(0xff, 0x52, 0x52);
        [self.contentView addSubview:self.totalPriceLabel_1];
        
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.top.equalTo(self.contentView).offset(16);
            make.height.equalTo(@14);
            make.width.equalTo(@75);
        }];
        
        [self.priceLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.priceLabel.mas_right).offset(12);
            make.right.equalTo(self.contentView).offset(-16);
            make.top.height.equalTo(self.priceLabel);
        }];
        
        [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.priceLabel);
            make.top.equalTo(self.priceLabel.mas_bottom).offset(12);
        }];
        
        [self.totalPriceLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.priceLabel_1);
            make.top.equalTo(self.totalPriceLabel);
        }];
        
        [self.contentView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.right.equalTo(self.contentView).offset(-16);
            make.height.equalTo(@1);
            make.bottom.equalTo(self.contentView);
        }];
    }
    return self;
}

- (UILabel *)createSubLeftLabelWithTitle:(NSString *)title {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = kRGB_Color(0x99, 0x99, 0x99);
    label.text = title;
    label.font = kFont14;
    return label;
}

- (UILabel *)createSubRightLabel {
    UILabel *label_1 = [[UILabel alloc] init];
    label_1.textColor = kRGB_Color(0x33, 0x33, 0x33);
    label_1.font = [UIFont boldSystemFontOfSize:14];
    return label_1;
}

@end

@interface HJDHomeOrderDetailQueryValueResultCell()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation HJDHomeOrderDetailQueryValueResultCell
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 52, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - 52) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.bgView addSubview:self.tableView];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.bgView);
            make.top.equalTo(self.lineView.mas_bottom);
        }];
    }
    return self;
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = [NSMutableArray arrayWithArray:dataSource];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 16 + 14 + 12 + 14 + 16;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HJDHomeOrderDetailQueryValueResultSubCell";
    HJDHomeOrderDetailQueryValueResultSubCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[HJDHomeOrderDetailQueryValueResultSubCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic = self.dataSource[indexPath.row];
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
    cell.priceLabel.text = [NSString stringWithFormat:@"%@单价：",title];
    cell.totalPriceLabel.text = [NSString stringWithFormat:@"%@总价：",title];
    cell.priceLabel_1.text = dic[@"unitPrice"];
    cell.totalPriceLabel_1.text = dic[@"totalPrice"];
    if (indexPath.row == self.dataSource.count - 1) {
        cell.lineView.hidden = YES;
    } else {
        cell.lineView.hidden = NO;
    }
    return cell;
}
@end

#pragma mark - 审核
@implementation HJDHomeOrderDetailButtonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIButton *leftBtn = [self createButtonWithTitle:@"拒单" selector:@selector(leftButtonClick:)];
        leftBtn.backgroundColor = kRGB_Color(0xff, 0x52, 0x52);
        [self.contentView addSubview:leftBtn];
        
        UIButton *rightBtn = [self createButtonWithTitle:@"通过" selector:@selector(rightButtonClick:)];
        rightBtn.backgroundColor = kMainColor;
        [self.contentView addSubview:rightBtn];
        
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(12);
            make.right.equalTo(self.contentView.mas_centerX).offset(-6);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(@36);
        }];
        
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_centerX).offset(6);
            make.right.equalTo(self.contentView).offset(-12);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(@36);
        }];
    }
    return self;
}

- (UIButton *)createButtonWithTitle:(NSString *)title selector:(SEL)selector{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:kRGB_Color(0xff, 0xff, 0xff) forState:UIControlStateNormal];
    btn.titleLabel.font = kFont15;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 4.f;
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)leftButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonCell:selectButtonIndex:)]) {
        [self.delegate buttonCell:self selectButtonIndex:0];
    }
}

- (void)rightButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonCell:selectButtonIndex:)]) {
        [self.delegate buttonCell:self selectButtonIndex:1];
    }
}
@end

