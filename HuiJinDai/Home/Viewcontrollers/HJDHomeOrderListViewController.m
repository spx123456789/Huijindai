//
//  HJDHomeOrderListViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeOrderListViewController.h"
#import "HJDHomeOrderListTableViewCell.h"
#import "HJDHomeManager.h"
#import "HJDHomeOrderListSearchView.h"

@interface HJDHomeOrderListViewController ()<UITableViewDelegate, UITableViewDataSource, HJDHomeOrderListSearchViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) HJDHomeOrderListSearchView *searchView;
@end

@implementation HJDHomeOrderListViewController
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

- (HJDHomeOrderListSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[HJDHomeOrderListSearchView alloc] initWithFrame:CGRectMake(0, kSafeAreaTopHeight, kScreenWidth, 95)];
        _searchView.delegate = self;
    }
    return _searchView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self setRightNavigationButton:nil backImage:kImage(@"4.png") highlightedImage:nil frame:CGRectMake(0, 0, 44, 44)];
    
    NSArray *arr = [HJDHomeManager getOrderListArray];
    self.dataSource = [NSMutableArray arrayWithArray:arr];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigationRightButtonClicked:(UIButton *)sender {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.searchView];
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
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 161;
}

#pragma mark - HJDHomeOrderListSearchViewDelegate
- (void)searchView:(HJDHomeOrderListSearchView *)searchView didSearch:(NSString *)searchStr {
    
}
@end
