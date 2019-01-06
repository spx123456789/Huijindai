//
//  HJDBankOrderListViewController.m
//  HuiJinDai
//
//  Created by GXW on 2019/1/6.
//  Copyright © 2019 shanpx. All rights reserved.
//

#import "HJDHomeBankOrderListViewController.h"
#import "HJDHomeOrderListTableViewCell.h"
#import "HJDMyNavTextFieldSearchView.h"
#import "HJDHomeOrderDetailViewController.h"
#import "HJDHomeManager.h"

@interface HJDHomeBankOrderListViewController ()<UITableViewDelegate, UITableViewDataSource, HJDMyNavTextFieldSearchViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) HJDMyNavTextFieldSearchView *searchView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation HJDHomeBankOrderListViewController

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
        _searchView.placeholderStr = @"请输入报单编号搜索";
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
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.tableView];
    
    UIView *hearderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 11)];
    hearderView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    self.tableView.tableHeaderView = hearderView;
    
    [self searchWithOrderNum:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchWithOrderNum:(NSString *)orderNum {
    [MBProgressHUD showMessage:@"正在加载..."];
    @weakify(self);
    [HJDHomeManager getBankOrderListWithOrderNum:orderNum callBack:^(NSArray *data, BOOL result) {
        [MBProgressHUD hideHUD];
        @strongify(self);
        if (result) {
            [self.dataSource removeAllObjects];
            for (int k = 0; k < data.count; k++) {
                HJDOrderListModel *listModel = [[HJDOrderListModel alloc] init];
                [listModel hjd_loadDataFromkeyValues:data[k]];
                [self.dataSource addObject:listModel];
            }
            [self.tableView reloadData];
        } else {
            [MBProgressHUD showError:@"加载失败"];
        }
    }];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HJDOrderListModel *listModel = self.dataSource[indexPath.row];
    HJDHomeOrderDetailViewController *controller = [[HJDHomeOrderDetailViewController alloc] init];
    controller.order_id = listModel.order_id;
    controller.controller_from = @"1";
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 177;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HJDHomeOrderListTableViewCell";
    HJDHomeOrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[HJDHomeOrderListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    HJDOrderListModel *listModel = self.dataSource[indexPath.row];
    cell.orderNumber = listModel.loan_num;
    cell.orderTime = listModel.ad_time;
    cell.locationAddress = listModel.address;
    cell.customerName = listModel.customer_name;
    cell.money = listModel.loan_money;
    cell.status = listModel.loan_status_name;
    cell.isCopyNum = NO;
    return cell;
}

#pragma mark - HJDMyNavTextFieldSearchViewDelegate
- (void)searchView:(HJDMyNavTextFieldSearchView *)searchView backButton:(id)sender {
    [self goBack:sender];
}

- (void)searchView:(HJDMyNavTextFieldSearchView *)searchView clearButton:(id)sender {
    [self searchWithOrderNum:nil];
}

- (void)searchView:(HJDMyNavTextFieldSearchView *)searchView keyWord:(NSString *)keyWord sureButton:(id)sender {
    [self searchWithOrderNum:keyWord];
}
@end

