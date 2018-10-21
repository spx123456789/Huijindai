//
//  HJDMyCustomerManagerViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMyCustomerManagerViewController.h"
#import "HJDMyAgentTableViewCell.h"
#import "HJDMyNavTextFieldSearchView.h"
#import "HJDCustomerServiceView.h"
#import "HJDMyManager.h"

@interface HJDMyCustomerManagerViewController ()<UITableViewDelegate, UITableViewDataSource, HJDMyNavTextFieldSearchViewDelegate, HJDMyAgentTableViewCellDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) HJDMyNavTextFieldSearchView *searchView;
@property(nonatomic, strong) HJDCustomerServiceView *customServiceView;
@end

@implementation HJDMyCustomerManagerViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - 64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kRGB_Color(244, 244, 244);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (HJDMyNavTextFieldSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[HJDMyNavTextFieldSearchView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
        _searchView.delegate = self;
        _searchView.placeholderStr = @"请输入姓名和手机号搜索";
    }
    return _searchView;
}

- (HJDCustomerServiceView *)customServiceView {
    if (!_customServiceView) {
        _customServiceView = [[HJDCustomerServiceView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 70, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight, 140, 30)];
        _customServiceView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    }
    return _customServiceView;
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

    self.dataSource = [NSMutableArray array];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 170, kScreenWidth, 170)];
    bgView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    [self.view addSubview:bgView];
    
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.customServiceView];
    
    [self searchWithKeyWord:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchWithKeyWord:(NSString *)keyWord {
    [MBProgressHUD showMessage:@"正在加载..."];
    [HJDMyManager getMyCustomerManagerWithKeyWork:keyWord callBack:^(NSArray *arr, BOOL result) {
        [MBProgressHUD hideHUD];
        if (result) {
            [self.dataSource removeAllObjects];
            for (int k = 0; k < arr.count; k++) {
                HJDMyAgentModel *model = [[HJDMyAgentModel alloc] init];
                [model hjd_loadDataFromkeyValues:arr[k]];
                [self.dataSource addObject:model];
            }
            [self.tableView reloadData];
        } else {
            [MBProgressHUD showError:@"请求失败"];
        }
    }];
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
    cell.name = model.rename;
    cell.phone = model.phone;
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}

#pragma mark - HJDMyAgentTableViewCellDelegate
- (void)myAgentCell:(HJDMyAgentTableViewCell *)agentCell didClickPhone:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:agentCell];
    HJDMyAgentModel *model = self.dataSource[indexPath.row];
    [self phoneCall:model.phone];
}

#pragma mark - HJDMyNavTextFieldSearchViewDelegate
- (void)searchView:(HJDMyNavTextFieldSearchView *)searchView backButton:(id)sender {
    [self goBack:sender];
}

- (void)searchView:(HJDMyNavTextFieldSearchView *)searchView clearButton:(id)sender {
    [self.dataSource removeAllObjects];
    [self.tableView reloadData];
}

- (void)searchView:(HJDMyNavTextFieldSearchView *)searchView keyWord:(NSString *)keyWord sureButton:(id)sender {
    [self searchWithKeyWord:keyWord];
}
@end
