//
//  HJDHomeCalculatorResultTableCell.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/24.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeCalculatorResultTableCell.h"

@interface HJDHomeCalculatorResultTableCell()
@property(nonatomic, strong) UIView *firstLine;
@property(nonatomic, strong) UIView *twoLine;
@property(nonatomic, strong) UIView *threeLine;
@end

@implementation HJDHomeCalculatorResultTableCell

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.layer.masksToBounds = YES;
        _statusLabel.layer.cornerRadius = 6.f;
        _statusLabel.font = kFont10;
        _statusLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _statusLabel;
}

- (UIImageView *)nextImgView {
    if (!_nextImgView) {
        _nextImgView = [[UIImageView alloc] initWithImage:kImage(@"进入")];
    }
    return _nextImgView;
}

- (UIView *)createLineView {
    CAShapeLayer *dotteShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef dotteShapePath =  CGPathCreateMutable();
    //设置虚线颜色
    [dotteShapeLayer setStrokeColor:[kLineColor CGColor]];
    //设置虚线宽度
    dotteShapeLayer.lineWidth = 1 ;
    //10=线的宽度 5=每条线的间距
    NSArray *dotteShapeArr = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:10],[NSNumber numberWithInt:5], nil];
    [dotteShapeLayer setLineDashPattern:dotteShapeArr];
    CGPathMoveToPoint(dotteShapePath, NULL, 0, 0);
    CGPathAddLineToPoint(dotteShapePath, NULL, kScreenWidth - 32, 0);
    [dotteShapeLayer setPath:dotteShapePath];
    CGPathRelease(dotteShapePath);
    
    UIView *view = [[UIView alloc] init];
    [view.layer addSublayer:dotteShapeLayer];
    return view;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCellView];
        
        self.statusLabel.hidden = YES;
        self.nextImgView.hidden = YES;
    }
    return self;
}

- (void)createCellView {
    self.firstLabel = [self createLeftLabelWithTitle:@""];
    self.twoLabel = [self createLeftLabelWithTitle:@""];
    self.threeLabel = [self createLeftLabelWithTitle:@""];
    self.fourLabel = [self createLeftLabelWithTitle:@""];
    
    [self.bgView addSubview:self.firstLabel];
    [self.bgView addSubview:self.twoLabel];
    [self.bgView addSubview:self.threeLabel];
    [self.bgView addSubview:self.fourLabel];
    
    self.firstLabel_1 = [self createRightLabel];
    self.twoLabel_1 = [self createRightLabel];
    self.threeLabel_1 = [self createRightLabel];
    self.fourLabel_1 = [self createRightLabel];
    
    [self.bgView addSubview:self.firstLabel_1];
    [self.bgView addSubview:self.twoLabel_1];
    [self.bgView addSubview:self.threeLabel_1];
    [self.bgView addSubview:self.fourLabel_1];
    
    self.firstLine = [self createLineView];
    self.twoLine = [self createLineView];
    self.threeLine = [self createLineView];
    [self.bgView addSubview:self.firstLine];
    [self.bgView addSubview:self.twoLine];
    [self.bgView addSubview:self.threeLine];
    
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(16);
        make.top.equalTo(self.lineView.mas_bottom).offset(11);
        make.height.equalTo(@14);
        make.width.equalTo(@75);
    }];
    
    [self.firstLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstLabel.mas_right).offset(12);
        make.right.equalTo(self.bgView).offset(-16);
        make.top.height.equalTo(self.firstLabel);
    }];
    
    [self.firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(16);
        make.right.equalTo(self.bgView).offset(-16);
        make.height.equalTo(@1);
        make.top.equalTo(self.firstLabel.mas_bottom).offset(11);
    }];
    
    [self.twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.firstLabel);
        make.top.equalTo(self.firstLine.mas_bottom).offset(11);
    }];
    
    [self.twoLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.firstLabel_1);
        make.top.equalTo(self.twoLabel);
    }];
    
    [self.twoLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.firstLine);
        make.top.equalTo(self.twoLabel.mas_bottom).offset(11);
    }];
    
    [self.threeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.firstLabel);
        make.top.equalTo(self.twoLine.mas_bottom).offset(11);
    }];
    
    [self.threeLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.firstLabel_1);
        make.top.equalTo(self.threeLabel);
    }];
    
    [self.threeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.firstLine);
        make.top.equalTo(self.threeLabel.mas_bottom).offset(11);
    }];
    
    [self.fourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.firstLabel);
        make.top.equalTo(self.threeLine.mas_bottom).offset(11);
    }];
    
    [self.fourLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.firstLabel_1);
        make.top.equalTo(self.fourLabel);
    }];
    
    [self.bgView addSubview:self.statusLabel];
    [self.bgView addSubview:self.nextImgView];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(16);
        make.top.equalTo(self.bgView);
        make.width.equalTo(@210);
        make.height.equalTo(@44);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        make.centerY.equalTo(self.titleLabel);
        make.width.equalTo(@40);
        make.height.equalTo(@14);
    }];
    
    [self.nextImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.right.equalTo(self.bgView).offset(-16);
        make.size.mas_equalTo(CGSizeMake(9, 16));
    }];
}

- (void)setCellOfNumber:(NSInteger)number {
    if (number == 4) {
        self.threeLabel.hidden = NO;
        self.fourLabel.hidden = NO;
        self.threeLabel_1.hidden = NO;
        self.fourLabel_1.hidden = NO;
        self.twoLine.hidden = NO;
        self.threeLine.hidden = NO;
        
    } else if (number == 2) {
        self.threeLabel.hidden = YES;
        self.fourLabel.hidden = YES;
        self.threeLabel_1.hidden = YES;
        self.fourLabel_1.hidden = YES;
        self.twoLine.hidden = YES;
        self.threeLine.hidden = YES;
    }
}

- (void)setStatusLabelSuccess:(BOOL)success {
    if (success) {
        _statusLabel.text = @"成功";
        _statusLabel.backgroundColor = kRGB_Color(0xcf, 0xf4, 0xe2);
        _statusLabel.textColor = kRGB_Color(0x0f, 0xc8, 0x6f);
    } else {
        _statusLabel.text = @"失败";
        _statusLabel.backgroundColor = kRGB_Color(0xff, 0xdc, 0xdc);
        _statusLabel.textColor = kRGB_Color(0xff, 0x52, 0x52);
    }
}
@end
