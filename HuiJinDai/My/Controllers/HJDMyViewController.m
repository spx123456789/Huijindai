//
//  HJDMyViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/1.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMyViewController.h"
#import "HJDMyTableViewCell.h"
#import "HJDMyCustomerManagerViewController.h"
#import "HJDMyAgentViewController.h"
#import "HJDMyInviteCodeView.h"
#import "HJDMySettingViewController.h"

@interface HJDMyViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *dataSource;
@property(nonatomic, strong) HJDMyTableHeaderView *headerView;
@end

@implementation HJDMyViewController

static NSString *key1 = @"image";
static NSString *key2 = @"title";

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

- (HJDMyTableHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[HJDMyTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 340)];
        _headerView.headImgView.image = kImage(@"我的默认头像");
        _headerView.nameLabel.text = @"周思然";
    }
    return _headerView;
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
    
    self.dataSource = @[ @{ key1 : kImage(@"我的页客户经理"), key2 : @"我的客户经理" }, @{ key1 : kImage(@"我的页经纪人"), key2 : @"我的经纪人" }, @{ key1 : kImage(@"我的页邀请码"), key2 : @"我的邀请码" }, @{ key1 : kImage(@"我的页设置"), key2 : @"设置" } ];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
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
    static NSString *cellIdentifier = @"HJDMyTableViewCell";
    HJDMyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[HJDMyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic = self.dataSource[indexPath.row];
    cell.imgView.image = dic[key1];
    cell.titleLabel.text = dic[key2];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            HJDMyCustomerManagerViewController *customerController = [[HJDMyCustomerManagerViewController alloc] init];
            customerController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:customerController animated:YES];
        }
            break;
        case 1: {
            HJDMyAgentViewController *agentController = [[HJDMyAgentViewController alloc] init];
            agentController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:agentController animated:YES];
        }
            break;
        case 2: {
            HJDMyInviteCodeView *inviteView = [[HJDMyInviteCodeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            inviteView.headImgView.image = kImage(@"邀请码头像");
            inviteView.nameLabel.text = @"张思然";
            inviteView.cityLabel.text = @"北京市";
            inviteView.inviteCode = @"邀请码：ASDFR";
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window addSubview:inviteView];
        }
            break;
        case 3: {
            HJDMySettingViewController *settingController = [[HJDMySettingViewController alloc] init];
            settingController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:settingController animated:YES];
        }
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 51.f;
    }
    return 58.f;
}

@end
