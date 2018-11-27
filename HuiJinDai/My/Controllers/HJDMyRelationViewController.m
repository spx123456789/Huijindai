//
//  HJDMyRelationViewController.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMyRelationViewController.h"
#import "HJDMyAgentTableViewCell.h"
#import "HJDMyNavTextFieldSearchView.h"
#import "HJDCustomerServiceView.h"
#import "HJDMyManager.h"

@interface HJDMyRelationViewController ()<UITableViewDelegate, UITableViewDataSource, HJDMyNavTextFieldSearchViewDelegate, HJDMyAgentTableViewCellDelegate, UIScrollViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) HJDMyNavTextFieldSearchView *searchView;
@property(nonatomic, strong) HJDCustomerServiceView *customServiceView;
@end

@implementation HJDMyRelationViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kSafeAreaTopHeight, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - 44) style:UITableViewStylePlain];
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
        _searchView.placeholderStr = @"请输入姓名和手机号搜索";
    }
    return _searchView;
}

- (HJDCustomerServiceView *)customServiceView {
    if (!_customServiceView) {
        _customServiceView = [[HJDCustomerServiceView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 70, kScreenHeight - kSafeAreaBottomHeight - 40, 140, 30)];
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
    NSString *url = @"";
    switch (self.searchType) {
        case HJDUserTypeManager:
            url = @"/User/get_customer";
            break;
        case HJDUserTypeAgent:
            url = @"/User/get_agent";
            break;
        case HJDUserTypeChannel:
            url = @"/User/get_channel";
            break;
        default:
            break;
    }
    [MBProgressHUD showMessage:@"正在加载..."];
    @weakify(self);
    [HJDMyManager getMyRelationWithUrl:url keyWork:keyWord callBack:^(NSArray *arr, BOOL result) {
        [MBProgressHUD hideHUD];
        @strongify(self);
        if (result) {
            [self.dataSource removeAllObjects];
            if (arr.count == 0) {
                [self showNodataViewFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight)];
            } else {
                [self hideHttpResultView];
                for (int k = 0; k < arr.count; k++) {
                    HJDMyAgentModel *model = [[HJDMyAgentModel alloc] init];
                    [model hjd_loadDataFromkeyValues:arr[k]];
                    [self.dataSource addObject:model];
                }
                [self.tableView reloadData];
            }
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
    [self searchWithKeyWord:nil];
}

- (void)searchView:(HJDMyNavTextFieldSearchView *)searchView keyWord:(NSString *)keyWord sureButton:(id)sender {
    [self searchWithKeyWord:keyWord];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
@end
