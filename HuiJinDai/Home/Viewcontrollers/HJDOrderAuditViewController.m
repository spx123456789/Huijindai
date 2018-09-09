//
//  HJDOrderAuditViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDOrderAuditViewController.h"
#import "HJDHomeAuditTableViewCell.h"
#import "HJDHomeNavSearchView.h"
#import "HJDHomeOrderListViewController.h"

@interface HJDOrderAuditViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) HJDHomeNavSearchView *searchView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation HJDOrderAuditViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 11, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - 11) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (HJDHomeNavSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[HJDHomeNavSearchView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 117 - 21, 40)];
        _searchView.placeholder = @"请输入姓名搜索";
    }
    return _searchView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    
    self.dataSource = [NSMutableArray arrayWithArray:@[ @"", @"", @"", @"", @"" ]];
    
    [self.view addSubview:self.tableView];
    
    self.navigationItem.titleView = self.searchView;
    
    [self setRightNavigationButton:@"确定" backImage:nil highlightedImage:nil frame:CGRectMake(0, 0, 44, 44)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = [NSString stringWithFormat:@"经纪人%ld", indexPath.row + 1];
    HJDHomeOrderListViewController *listController = [[HJDHomeOrderListViewController alloc] init];
    listController.title = [NSString stringWithFormat:@"%@工单列表", str];
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
    cell.nameLabel.text = [NSString stringWithFormat:@"经纪人%ld", indexPath.row + 1];
    cell.numberLabel.text = @"99";
    
    return cell;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}
@end
