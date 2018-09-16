//
//  HJDHomeOrderListViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/2.
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
@end

@implementation HJDHomeOrderListViewController
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 46, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - 46) style:UITableViewStylePlain];
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
    }
    return _textField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSearchView];
    [self.view addSubview:self.tableView];
    
    NSArray *arr = [HJDHomeManager getOrderListArray];
    self.dataSource = [NSMutableArray arrayWithArray:arr];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createSearchView {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 46)];
    [self.view addSubview:bgView];
    
    UIView *s_bgView = [[UIView alloc] initWithFrame:CGRectMake(16, 8, kScreenWidth - 32, 30)];
    s_bgView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    s_bgView.layer.masksToBounds = YES;
    s_bgView.layer.cornerRadius = 4.f;
    [bgView addSubview:s_bgView];
    
    self.textField.frame = CGRectMake(12, 0, kScreenWidth - 110, 30);
    [s_bgView addSubview:self.textField];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth - 70, 0, 1, 30)];
    line.backgroundColor = kRGB_Color(0xff, 0xff, 0xff);
    [s_bgView addSubview:line];
    
    UILabel *sureLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 69, 0, 53, 30)];
    sureLabel.text = @"确定";
    sureLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
    sureLabel.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    sureLabel.font = kFont15;
    sureLabel.textAlignment = NSTextAlignmentCenter;
    [s_bgView addSubview:sureLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSureButton:)];
    [sureLabel addGestureRecognizer:tap];
}

- (void)clickSureButton:(id)sender {
    
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

@end
