//
//  HJDCalculatorResultViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/22.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDCalculatorResultViewController.h"
#import "HJDHomeOrderDetailTableViewCell.h"

@interface HJDCalculatorResultTableCell : HJDHomeOrderDetailTableViewCell
@property(nonatomic, strong) UILabel *firstLabel;
@property(nonatomic, strong) UILabel *firstLabel_1;
@property(nonatomic, strong) UILabel *twoLabel;
@property(nonatomic, strong) UILabel *twoLabel_1;
@property(nonatomic, strong) UILabel *threeLabel;
@property(nonatomic, strong) UILabel *threeLabel_1;
@property(nonatomic, strong) UILabel *fourLabel;
@property(nonatomic, strong) UILabel *fourLabel_1;
@property(nonatomic, strong) UIView *firstLine;
@property(nonatomic, strong) UIView *twoLine;
@property(nonatomic, strong) UIView *threeLine;

- (void)setCellOfNumber:(NSInteger)number;
@end

@implementation HJDCalculatorResultTableCell
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
    }
    return self;
}

- (void)createCellView {
    self.firstLabel = [self createLeftLabelWithTitle:@"借款金额"];
    self.twoLabel = [self createLeftLabelWithTitle:@"申请期限"];
    self.threeLabel = [self createLeftLabelWithTitle:@"放款日期"];
    self.fourLabel = [self createLeftLabelWithTitle:@"到期日期"];
    
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
}

- (void)setCellOfNumber:(NSInteger)number {
    if (number == 4) {
        self.threeLabel.hidden = NO;
        self.fourLabel.hidden = NO;
        self.threeLabel_1.hidden = NO;
        self.fourLabel_1.hidden = NO;
        self.twoLine.hidden = NO;
        self.threeLine.hidden = NO;
        self.firstLabel.text = @"借款金额";
        self.twoLabel.text = @"申请期限";
        self.threeLabel.text = @"放款日期";
        self.fourLabel.text = @"到期日期";
    } else if (number == 2) {
        self.threeLabel.hidden = YES;
        self.fourLabel.hidden = YES;
        self.threeLabel_1.hidden = YES;
        self.fourLabel_1.hidden = YES;
        self.twoLine.hidden = YES;
        self.threeLine.hidden = YES;
        self.firstLabel.text = @"年化利率";
        self.twoLabel.text = @"利息总计";
    }
}

@end

@interface HJDCalculatorResultViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation HJDCalculatorResultViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 4, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - 4) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTitle:@"计算结果"];
    
    self.view.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 44 + 1 + 36 * 4 + 1 * 3 + 4;
    } else if (indexPath.row == 1) {
        return 44 + 1 + 36 * 2 + 1 * 1 + 4;
    }
    return 33;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HJDCalculatorResultTableCell";
    HJDCalculatorResultTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[HJDCalculatorResultTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"填写信息";
        cell.firstLabel_1.text = @"1000000元";
        cell.twoLabel_1.text = @"3月";
        cell.threeLabel_1.text = @"2018-02-15";
        cell.fourLabel_1.text = @"2019-04-12";
        [cell setCellOfNumber:4];
    } else if (indexPath.row == 1) {
        cell.titleLabel.text = @"计算结果";
        cell.firstLabel_1.text = @"10%";
        cell.twoLabel_1.text = @"24,999.99元";
        [cell setCellOfNumber:2];
    }
    return cell;
}
@end
