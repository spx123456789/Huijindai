//
//  HJDHomeOrderListViewController.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeOrderListViewController.h"
#import "HJDHomeOrderListTableViewCell.h"
#import "HJDHomeOrderDetailViewController.h"
#import "HJDHomeManager.h"

@interface HJDHomeOrderListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, assign) NSInteger orderListPage;
@end

@implementation HJDHomeOrderListViewController
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 52, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - 52) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入房产地址/申请人姓名查询" attributes:@{ NSFontAttributeName : kFont14, NSForegroundColorAttributeName : kRGB_Color(0xd4, 0xd4, 0xd4)}];
        _textField.font = kFont14;
        _textField.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSearchView];
    [self.view addSubview:self.tableView];
    
    self.orderListPage = 1;
    self.dataSource = [NSMutableArray array];
    
    [self searchKeyWord:nil];
    
    @weakify(self);
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self searchKeyWord:self.textField.text];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderAuditNotification:) name:kHJDOrderAuditNotificationName object:nil];
}

- (void)orderAuditNotification:(NSNotification *)noti {
    self.orderListPage = 1;
    [self.dataSource removeAllObjects];
    [self searchKeyWord:self.textField.text showLoading:NO];
}

- (void)searchKeyWord:(NSString *)keyWord showLoading:(BOOL)showLoading {
    if (showLoading) {
        [MBProgressHUD showMessage:@"正在加载..."];
    }
    [HJDHomeManager getOrderAuditListChannelOrAgentWithUid:self.uid keyWord:keyWord page:self.orderListPage callBack:^(NSArray *data, BOOL result) {
        if (showLoading) {
            [MBProgressHUD hideHUD];
        }
        [self.tableView.mj_footer endRefreshing];
        if (result) {
            for (int k = 0; k < data.count; k++) {
                HJDOrderListModel *listModel = [[HJDOrderListModel alloc] init];
                [listModel hjd_loadDataFromkeyValues:data[k]];
                [self.dataSource addObject:listModel];
            }
            [self.tableView reloadData];
            if (self.orderListPage == 1 && data.count == 0) {
                [self showNodataViewFrame:CGRectMake(0, 52, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - 52)];
            } else {
                [self hideHttpResultView];
            }
            
            if (data.count == 0 || data.count < kHJDHttpRow) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            self.orderListPage++;
        } else {
            if (showLoading) {
                [MBProgressHUD showError:@"加载失败"];
            }
        }
    }];
}

- (void)searchKeyWord:(NSString *)keyWord {
    [self searchKeyWord:keyWord showLoading:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createSearchView {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36 + 16)];
    [self.view addSubview:bgView];
    
    UIView *s_bgView = [[UIView alloc] init];
    s_bgView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    s_bgView.layer.masksToBounds = YES;
    s_bgView.layer.cornerRadius = 4.f;
    [bgView addSubview:s_bgView];
    
    [s_bgView addSubview:self.textField];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = kRGB_Color(0xff, 0xff, 0xff);
    [s_bgView addSubview:line];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureButton setBackgroundColor:[UIColor clearColor]];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.titleLabel.font = kFont15;
    [sureButton setTitleColor:kRGB_Color(0x33, 0x33, 0x33) forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(clickSureButton:) forControlEvents:UIControlEventTouchUpInside];
    [s_bgView addSubview:sureButton];
    
    [s_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(16);
        make.right.equalTo(bgView).offset(-16);
        make.height.equalTo(@36);
        make.top.equalTo(bgView).offset(8);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(s_bgView).offset(12);
        make.top.bottom.equalTo(s_bgView);
        make.right.equalTo(line.mas_left).offset(-12);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(s_bgView);
        make.right.equalTo(sureButton.mas_left);
        make.width.equalTo(@1);
    }];
    
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(s_bgView);
        make.width.equalTo(@53);
    }];

}

- (void)clickSureButton:(id)sender {
    self.orderListPage = 1;
    [self.dataSource removeAllObjects];
    [self searchKeyWord:self.textField.text];
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
    controller.controller_from = @"0";
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 177;
}

@end
