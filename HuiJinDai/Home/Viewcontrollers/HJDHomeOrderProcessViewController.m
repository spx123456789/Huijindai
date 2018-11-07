//
//  HJDHomeOrderProcessViewController.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/22.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeOrderProcessViewController.h"
#import "HJDMessageSegmentView.h"
#import "HJDHomeOrderListTableViewCell.h"
#import "HJDHomeOrderDetailViewController.h"
#import "HJDOrderProcessSearchView.h"
#import "HJDHomeManager.h"

@interface HJDHomeOrderProcessViewController ()<UITableViewDelegate, UITableViewDataSource, HJDMessageSegmentViewDelegate, HJDOrderProcessSearchViewDelegate, UIScrollViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) HJDMessageSegmentView *segmentView;
@property(nonatomic, strong) HJDOrderProcessSearchView *searchView;
@property(nonatomic, copy) NSString *order_step;
@property(nonatomic, assign) NSInteger orderManagePage;
@end

@implementation HJDHomeOrderProcessViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (HJDMessageSegmentView *)segmentView {
    if (!_segmentView) {
        _segmentView = [[HJDMessageSegmentView alloc] initWithFrame:CGRectMake(0, 0, 240, 32)];
        [_segmentView setSegmentViewTitle:@"工单进程" rightTitle:@"已完结工单"];
        _segmentView.delegate = self;
    }
    return _segmentView;
}

- (HJDOrderProcessSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[HJDOrderProcessSearchView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36 + 16)];
        _searchView.delegate = self;
        _searchView.showLeft = YES;
    }
    return _searchView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.segmentView;
    
    self.orderManagePage = 1;
    self.dataSource = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.searchView;
    
    [self searchKeyWord:nil status:@"1" step:nil];
    
    @weakify(self);
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self searchKeyWord:self.searchView.textField.text status:(self.searchView.showLeft ? @"1" : @"2") step:self.order_step];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderAuditNotifi:) name:kHJDOrderAuditNotificationName object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)orderAuditNotifi:(NSNotification *)noti {
    self.orderManagePage = 1;
    [self.dataSource removeAllObjects];
    [self searchKeyWord:self.searchView.textField.text status:(self.searchView.showLeft ? @"1" : @"2") step:self.order_step showLoading:NO];
}

- (void)searchKeyWord:(NSString *)keyWord status:(NSString *)status step:(NSString *)step {
    [self searchKeyWord:keyWord status:status step:step showLoading:YES];
}

- (void)searchKeyWord:(NSString *)keyWord status:(NSString *)status step:(NSString *)step showLoading:(BOOL)showLoading {
    @weakify(self);
    [MBProgressHUD showMessage:@"正在加载..."];
    [HJDHomeManager getOrderManageListChannelOrAgentWithUid:self.uid status:status keyWord:keyWord step:step page:self.orderManagePage callBack:^(NSArray *data, BOOL result) {
        @strongify(self);
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUD];
        if (result) {
            for (int k = 0; k < data.count; k++) {
                HJDOrderListModel *model = [[HJDOrderListModel alloc] init];
                [model hjd_loadDataFromkeyValues:data[k]];
                [self.dataSource addObject:model];
            }
            if (data.count == 0 || data.count < kHJDHttpRow) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.tableView reloadData];
            
            if (self.orderManagePage == 1 && data.count == 0) {
                [self showNodataViewFrame:CGRectMake(0, 52, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - 52)];
            } else {
                [self hideHttpResultView];
            }
            self.orderManagePage++;
        } else {
            [MBProgressHUD showError:@"加载失败"];
        }
    }];
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
    return cell;
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

#pragma mark - HJDMessageSegmentViewDelegate
- (void)segmentView:(HJDMessageSegmentView *)segmentView didSelectMessageType:(HJDMessageType)type {
    self.searchView.textField.text = @"";
    self.orderManagePage = 1;
    [self.dataSource removeAllObjects];
    if (type == HJDMessageTypeMy) { //left
        [self searchKeyWord:nil status:@"1" step:nil];
        _searchView.showLeft = YES;
    } else {
        [self searchKeyWord:nil status:@"2" step:nil];
        _searchView.showLeft = NO;
    }
}

#pragma mark - HJDOrderProcessSearchViewDelegate
- (void)processSearchView:(HJDOrderProcessSearchView *)searchView searchWord:(NSString *)keyWord selectStatus:(NSString *)status clickSureButton:(BOOL)isClick {
    if (isClick && [NSString hjd_isBlankString:keyWord]) {
        [self showToast:@"请输入搜索关键词"];
        return;
    }
    
    if (![NSString hjd_isBlankString:status]) {
        self.order_step = status;
    }
    
    self.orderManagePage = 1;
    [self.dataSource removeAllObjects];
    [self searchKeyWord:keyWord status:(searchView.showLeft ? @"1" : @"2") step:self.order_step];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
@end
