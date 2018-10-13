//
//  HJDHomeQueryValueResultViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/24.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeQueryValueResultViewController.h"
#import "HJDCustomerServiceView.h"
#import "HJDHomeDeclarationViewController.h"
#import "HJDHomeQueryValueResultTableViewCell.h"

@interface HJDHomeQueryValueResultViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIView *topView;
@property(nonatomic, strong) HJDCustomerServiceView *customServiceView;
@property(nonatomic, strong) UIButton *declarationBtn;
@end

@implementation HJDHomeQueryValueResultViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 76, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - 76) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kWithe;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64 + 12 + 260)];
        _topView.backgroundColor = kMainColor;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 75, 20, 150, 44)];
        label.text = @"询值结果";
        label.textColor = kRGB_Color(0xff, 0xff, 0xff);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = kFont17;
        label.adjustsFontSizeToFitWidth = YES;
        [_topView addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:CGRectMake(0, 20, 44, 44)];
        [button setImage:kImage(@"返回按钮") forState:UIControlStateNormal];
        [button setImage:kImage(@"返回按钮") forState:UIControlStateSelected];
        [_topView addSubview:button];
    }
    return _topView;
}

- (HJDCustomerServiceView *)customServiceView {
    if (!_customServiceView) {
        _customServiceView = [[HJDCustomerServiceView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 70, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight, 140, 30)];
        _customServiceView.backgroundColor = kWithe;
    }
    return _customServiceView;
}

- (UIButton *)declarationBtn {
    if (!_declarationBtn) {
        _declarationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_declarationBtn setTitle:@"报单" forState:UIControlStateNormal];
        [_declarationBtn setTitleColor:kRGB_Color(0xff, 0xff, 0xff) forState:UIControlStateNormal];
        [_declarationBtn setBackgroundColor:kMainColor];
        _declarationBtn.titleLabel.font = kFont15;
        _declarationBtn.layer.masksToBounds = YES;
        _declarationBtn.layer.cornerRadius = 4.f;
        [_declarationBtn addTarget:self action:@selector(declarationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _declarationBtn;
}

- (void)declarationButtonClick:(id)sender {
    HJDHomeDeclarationViewController *vc = [[HJDHomeDeclarationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self showNavigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.customServiceView];
    
    NSArray *testArr = @[ @{ @"totalPrice":@"4480000", @"unitPrice":@"44797", @"assessCompany":@"01", @"x_id":@"1"
    }, @{ @"totalPrice":@"4480000",  @"unitPrice":@"44797", @"assessCompany":@"02", @"x_id":@"2" }];
    
    self.resultArray = [NSArray arrayWithArray:testArr];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.tableView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(16 , 16)];
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.frame = self.tableView.bounds;
    shapeLayer.path = bezierPath.CGPath;
    self.tableView.layer.mask = shapeLayer;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44 + 44)];
    self.declarationBtn.frame = CGRectMake(16, 44, kScreenWidth - 32, 44);
    [footerView addSubview:self.declarationBtn];
    self.tableView.tableFooterView = footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 112 + 16;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.resultArray.count) {
        static NSString *cellIdentifier = @"HJDHomeQueryValueResultTableViewCell";
        HJDHomeQueryValueResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[HJDHomeQueryValueResultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setCellValue:self.resultArray[indexPath.row]];
        return cell;
    } else {
        static NSString *cellIdentifier2 = @"HJDHomeQueryValueResultNumberTableCell";
        HJDHomeQueryValueResultNumberTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (cell == nil) {
            cell = [[HJDHomeQueryValueResultNumberTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.company = @"仁达";
        cell.number = @"5";
        return cell;
    }
    
}
@end
