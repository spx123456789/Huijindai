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

@interface HJDHomeOrderProcessViewController ()<UITableViewDelegate, UITableViewDataSource, HJDMessageSegmentViewDelegate, HJDOrderProcessSearchViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) HJDMessageSegmentView *segmentView;
@property(nonatomic, strong) HJDOrderProcessSearchView *searchView;
@property(nonatomic, copy) NSString *order_status;
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
        _searchView.selectIndex = 0;
        _searchView.delegate = self;
    }
    return _searchView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.segmentView;
    
    self.dataSource = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.searchView;
    
    self.order_status = @"1";
    
    [self searchKeyWord:nil status:@"1"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchKeyWord:(NSString *)keyWord status:(NSString *)status {
    [MBProgressHUD showMessage:@"正在加载..."];
    [HJDHomeManager getOrderManageListChannelOrAgentWithUid:self.uid status:status keyWord:keyWord page:1 callBack:^(NSArray *data, BOOL result) {[MBProgressHUD hideHUD];
        if (result) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:data];
            [self.tableView reloadData];
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
    cell.orderNumber = listModel.orderNumber;
    cell.orderTime = listModel.orderTime;
    cell.locationAddress = listModel.locationAddress;
    cell.customerName = listModel.customerName;
    cell.money = listModel.money;
    cell.auditStatus = listModel.auditStatus.integerValue;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HJDHomeOrderDetailViewController *controller = [[HJDHomeOrderDetailViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 177;
}

#pragma mark - HJDMessageSegmentViewDelegate
- (void)segmentView:(HJDMessageSegmentView *)segmentView didSelectMessageType:(HJDMessageType)type {
    if (type == HJDMessageTypeMy) { //left
        self.order_status = @"1";
        [self searchKeyWord:nil status:@"1"];
    } else {
        self.order_status = @"2";
        [self searchKeyWord:nil status:@"2"];
    }
}

#pragma mark - HJDOrderProcessSearchViewDelegate
- (void)processSearchView:(HJDOrderProcessSearchView *)searchView searchWord:(NSString *)keyWord {
    if ([NSString hjd_isBlankString:keyWord]) {
        [self showToast:@"请输入搜索关键词"];
        return;
    }
    
    [self searchKeyWord:keyWord status:self.order_status];
}
@end
