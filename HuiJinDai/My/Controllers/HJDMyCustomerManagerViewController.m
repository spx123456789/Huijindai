//
//  HJDMyCustomerManagerViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMyCustomerManagerViewController.h"
#import "HJDMyAgentTableViewCell.h"
#import "HJDMySearchFieldView.h"
#import "HJDCustomerServiceView.h"
#import "HJDMyManager.h"

@interface HJDMyCustomerManagerViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) HJDMySearchFieldView *headerSearchView;
@property(nonatomic, strong) HJDCustomerServiceView *customServiceView;
@end

@implementation HJDMyCustomerManagerViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - 60) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kRGB_Color(244, 244, 244);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (HJDMySearchFieldView *)headerSearchView {
    if (!_headerSearchView) {
        _headerSearchView = [[HJDMySearchFieldView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 88 - 20, 44)];
    }
    return _headerSearchView;
}

- (HJDCustomerServiceView *)customServiceView {
    if (!_customServiceView) {
        _customServiceView = [[HJDCustomerServiceView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 70, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - 60, 140, 30)];
        _customServiceView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    }
    return _customServiceView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的客户经理";
    self.view.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    
    NSArray *arr = [HJDMyManager getMyCustomerManagerArray];
    self.dataSource = [NSMutableArray arrayWithArray:arr];
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.customServiceView];
    
     self.navigationItem.titleView = self.headerSearchView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HJDMyAgentTableViewCell";
    HJDMyAgentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[HJDMyAgentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    HJDMyAgentModel *model = self.dataSource[indexPath.row];
    cell.name = model.name;
    cell.phone = model.phone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}

@end
