//
//  HJDHomeOrderManageViewController.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/5.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeOrderManageViewController.h"
#import "HJDHomeAuditTableViewCell.h"
#import "HJDMyNavTextFieldSearchView.h"
#import "HJDHomeOrderProcessViewController.h"
#import "HJDHomeManager.h"

@interface HJDHomeOrderManageViewController ()<UITableViewDelegate, UITableViewDataSource, HJDMyNavTextFieldSearchViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) HJDMyNavTextFieldSearchView *searchView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, assign) BOOL isHaveMy;
@end

@implementation HJDHomeOrderManageViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kSafeAreaTopHeight, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (HJDMyNavTextFieldSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[HJDMyNavTextFieldSearchView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, 44)];
        _searchView.delegate = self;
        _searchView.placeholderStr = @"请输入姓名搜索";
    }
    return _searchView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self showNavigationBar];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dataSource = [NSMutableArray array];
        _isHaveMy = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.tableView];
    
    UIView *hearderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 12)];
    hearderView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    self.tableView.tableHeaderView = hearderView;
    
    [self searchWithKeyWord:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchWithKeyWord:(NSString *)keyWord {
    [MBProgressHUD showMessage:@"正在加载..."];
    [HJDHomeManager getOrderManageListWithKeyWord:keyWord callBack:^(NSDictionary *data, BOOL result) {
        [MBProgressHUD hideHUD];
        if (result) {
            [self.dataSource removeAllObjects];
            NSArray *selfArray = [data objectForKey:@"self"];
            NSArray *subArray = [data objectForKey:@"sub"];
            self.isHaveMy = NO;
            if (selfArray.count != 0) {
                self.isHaveMy = YES;
                [self.dataSource addObjectsFromArray:selfArray];
            }
            [self.dataSource addObjectsFromArray:subArray];
            [self.tableView reloadData];
        } else {
            [MBProgressHUD showError:@"加载失败"];
        }
    }];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HJDHomeOrderProcessViewController *controller = [[HJDHomeOrderProcessViewController alloc] init];
    NSDictionary *dic = self.dataSource[indexPath.row];
    controller.uid = dic[@"uid"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isHaveMy && indexPath.row == 0) {
        return 44 + 12;
    } else {
        return 45;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HJDHomeAuditTableViewCell";
    HJDHomeAuditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[HJDHomeAuditTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *dic = self.dataSource[indexPath.row];
    if (self.isHaveMy && indexPath.row == 0) {
        cell.headImgView.image = kImage(@"订单管理我的订单");
        cell.nameLabel.text = @"我的工单";
    } else {
        cell.headImgView.image = kImage(@"订单管理渠道代码");
        cell.nameLabel.text = dic[@"rename"];
    }
    
    NSString *number = dic[@"count"];
    if (number.integerValue == 0) {
        cell.numberLabel.hidden = YES;
    } else {
        cell.numberLabel.hidden = NO;
        cell.numberLabel.text = number;
    }
    return cell;
}

#pragma mark - HJDMyNavTextFieldSearchViewDelegate
- (void)searchView:(HJDMyNavTextFieldSearchView *)searchView backButton:(id)sender {
    [self goBack:sender];
}

- (void)searchView:(HJDMyNavTextFieldSearchView *)searchView clearButton:(id)sender {
    [self searchWithKeyWord:nil];
}

- (void)searchView:(HJDMyNavTextFieldSearchView *)searchView keyWord:(NSString *)keyWord sureButton:(id)sender {
    [self searchWithKeyWord:keyWord];
}

@end
