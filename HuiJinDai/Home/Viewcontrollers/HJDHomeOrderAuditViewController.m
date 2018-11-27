//
//  HJDHomeOrderAuditViewController.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeOrderAuditViewController.h"
#import "HJDHomeAuditTableViewCell.h"
#import "HJDMyNavTextFieldSearchView.h"
#import "HJDHomeOrderListViewController.h"
#import "HJDHomeManager.h"

@interface HJDHomeOrderAuditViewController ()<UITableViewDelegate, UITableViewDataSource, HJDMyNavTextFieldSearchViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) HJDMyNavTextFieldSearchView *searchView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation HJDHomeOrderAuditViewController

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
    
    [self searchWithKeyWord:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchWithKeyWord:(NSString *)keyWord {
    [MBProgressHUD showMessage:@"正在加载..."];
    [HJDHomeManager getOrderAuditListWithKeyWord:keyWord callBack:^(NSArray *data, BOOL result) {
        [MBProgressHUD hideHUD];
        if (result) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:data];
            [self.tableView reloadData];
        } else {
            [MBProgressHUD showError:@"加载失败"];
        }
    }];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.dataSource[indexPath.row];
    HJDHomeOrderListViewController *listController = [[HJDHomeOrderListViewController alloc] init];
    listController.uid = dic[@"uid"];
    [listController setNavTitle:[NSString stringWithFormat:@"%@", dic[@"rename"]]];
    [self.navigationController pushViewController:listController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
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
    cell.nameLabel.text = dic[@"rename"];
    NSString *number = dic[@"new_count"];
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
