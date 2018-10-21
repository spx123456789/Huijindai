//
//  HJDHomeCalculatorResultViewController.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/22.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeCalculatorResultViewController.h"
#import "HJDHomeCalculatorResultTableCell.h"

@interface HJDHomeCalculatorResultViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation HJDHomeCalculatorResultViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 4, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - 4) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTitle:@"计算结果"];
    
    self.view.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 44 + 1 + 36 * 4 + 1 * 3 + 4;
    } else if (indexPath.row == 1) {
        return 44 + 1 + 36 * 2 + 1 * 1 + 4;
    }
    return 33;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HJDHomeCalculatorResultTableCell";
    HJDHomeCalculatorResultTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[HJDHomeCalculatorResultTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"填写信息";
        cell.firstLabel.text = @"借款金额";
        cell.twoLabel.text = @"申请期限";
        cell.threeLabel.text = @"放款日期";
        cell.fourLabel.text = @"到期日期";
        cell.firstLabel_1.text = [NSString stringWithFormat:@"%@元", self.resultModel.money];
        cell.twoLabel_1.text = [NSString stringWithFormat:@"%@月", self.resultModel.month];
        cell.threeLabel_1.text = self.resultModel.start_date;
        cell.fourLabel_1.text = self.resultModel.end_date;
        [cell setCellOfNumber:4];
    } else if (indexPath.row == 1) {
        cell.titleLabel.text = @"计算结果";
        cell.firstLabel.text = @"年化利率";
        cell.twoLabel.text = @"利息总计";
        cell.firstLabel_1.text = [NSString stringWithFormat:@"%@%%", self.resultModel.lilv];
        cell.twoLabel_1.text = [NSString stringWithFormat:@"%@元", self.resultModel.lixi];
        [cell setCellOfNumber:2];
    }
    return cell;
}
@end
