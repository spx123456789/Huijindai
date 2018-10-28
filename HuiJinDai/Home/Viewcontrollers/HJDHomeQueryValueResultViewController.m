//
//  HJDHomeQueryValueResultViewController.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/24.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeQueryValueResultViewController.h"
#import "HJDCustomerServiceView.h"
#import "HJDHomeDeclarationViewController.h"
#import "HJDHomeQueryValueResultTableViewCell.h"
#import "HJDHomeRoomDiDaiManager.h"

@interface HJDHomeQueryValueResultViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIView *topView;
@property(nonatomic, strong) HJDCustomerServiceView *customServiceView;
@property(nonatomic, strong) UIButton *declarationBtn;
@property(nonatomic, strong) NSMutableArray *companyArray;
@property(nonatomic, strong) NSMutableArray *dataSource;
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
        [button addTarget:self action:@selector(closeButton:) forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:CGRectMake(kScreenWidth - 50, 20, 44, 44)];
        [button setTitle:@"关闭" forState:UIControlStateNormal];
        [button setTitle:@"关闭" forState:UIControlStateSelected];
        button.titleLabel.font = kFont15;
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

- (void)closeButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)declarationButtonClick:(id)sender {
    HJDHomeDeclarationViewController *vc = [[HJDHomeDeclarationViewController alloc] init];
    NSDictionary *dictionary = self.dataSource.firstObject;
    if (dictionary != nil && [dictionary[@"assessCompany"] integerValue] == 01) {
        vc.xun_id = dictionary[@"x_id"];
    }
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

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    self.companyArray = [NSMutableArray arrayWithArray:@[ @"世联", @"首佳", @"仁达" ]];
    for (NSDictionary *dic in self.dataSource) {
        NSString *company = dic[@"assessCompany"];
        switch (company.integerValue) {
            case 01: {
                [self.companyArray removeObject:@"世联"];
                break;
            }
            case 02: {
                [self.companyArray removeObject:@"仁达"];
                break;
            }
            default: {
                [self.companyArray removeObject:@"首佳"];
                break;
            }
        }
    }
}

- (void)setResultDic:(NSDictionary *)resultDic {
    _resultDic = resultDic;
    self.dataSource = [NSMutableArray arrayWithArray:[resultDic getObjectByPath:@"data/list"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.customServiceView];
    
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
    NSString *company = nil;
    if (indexPath.row == 1) { //首佳
        company = @"03";
    } else if (indexPath.row == 2) { //仁达
        company = @"02";
    }
    
    if (company == nil) {
        return;
    }
    
    if (self.didaiModel == nil) {
        [self showToast:@"询值失败"];
        return;
    }
    
    self.didaiModel.companyStr = company;
    [MBProgressHUD showMessage:@"正在询值..."];
    @weakify(self);
    [HJDHomeRoomDiDaiManager postRoomEvaluateWithModel:nil callBack:^(NSDictionary *dataDic, BOOL result) {
        @strongify(self);
        [MBProgressHUD hideHUD];
        if (result) {
            [self.dataSource addObjectsFromArray:[dataDic getObjectByPath:@"data/list"]];
            [self.tableView reloadData];
        } else {
            [MBProgressHUD showError:@"询值失败"];
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 112 + 16;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count + self.companyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.dataSource.count) {
        static NSString *cellIdentifier = @"HJDHomeQueryValueResultTableViewCell";
        HJDHomeQueryValueResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[HJDHomeQueryValueResultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setCellValue:self.dataSource[indexPath.row]];
        return cell;
    } else {
        static NSString *cellIdentifier2 = @"HJDHomeQueryValueResultNumberTableCell";
        HJDHomeQueryValueResultNumberTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (cell == nil) {
            cell = [[HJDHomeQueryValueResultNumberTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    
        NSString *title = self.companyArray[indexPath.row - self.dataSource.count];
        cell.company = title;
        cell.number = [self.resultDic getObjectByPath:@"data/frequency"];
        return cell;
    }
    
}
@end
