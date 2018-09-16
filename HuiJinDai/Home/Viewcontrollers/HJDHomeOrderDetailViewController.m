//
//  HJDHomeOrderDetailViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/16.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeOrderDetailViewController.h"
#import "HJDHomeOrderDetailTableViewCell.h"
#import "HJDHomeOrderDetailPhotoCell.h"
#import "HJDHomeOrderRefuseViewController.h"

@interface HJDHomeOrderDetailViewController ()<UITableViewDelegate, UITableViewDataSource, HJDHomeOrderDetailButtonCellDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIView *topView;
@end

@implementation HJDHomeOrderDetailViewController

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

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
        UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        topBtn.frame = CGRectMake(16, 10, kScreenWidth - 32, 53);
        [topBtn setBackgroundImage:kImage(@"工单详情查看批贷函") forState:UIControlStateNormal];
        [topBtn setBackgroundImage:kImage(@"工单详情查看批贷函") forState:UIControlStateHighlighted];
        [_topView addSubview:topBtn];
        
        UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bottomBtn.frame = CGRectMake(16, 10 + 53 + 3, kScreenWidth - 32, 53);
        [bottomBtn setBackgroundImage:kImage(@"工单详情查看审查报告") forState:UIControlStateNormal];
        [bottomBtn setBackgroundImage:kImage(@"工单详情查看审查报告") forState:UIControlStateHighlighted];
        [_topView addSubview:bottomBtn];
    }
    return _topView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTitle:@"工单详情"];
    
    [self.view addSubview:self.tableView];
    self.topView.frame = CGRectMake(0, 0, kScreenWidth, 10 + 53 * 2 + 3 + 5);
    self.tableView.tableHeaderView = self.topView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HJDHomeOrderDetailQueryCell";
    static NSString *cellIdentifier1 = @"HJDHomeOrderDetailDeclarationCell";
    static NSString *cellIdentifier2 = @"HJDHomeOrderDetailPhotoCell";
    static NSString *cellIdentifier3 = @"HJDHomeOrderDetailProcessCell";
    static NSString *cellIdentifier4 = @"HJDHomeOrderDetailButtonCell";
    
    switch (indexPath.row) {
        case 0: {
            HJDHomeOrderDetailQueryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[HJDHomeOrderDetailQueryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.titleLabel.text = @"询值信息";
            return cell;
            break;
        }
        case 1: {
            HJDHomeOrderDetailDeclarationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            if (cell == nil) {
                cell = [[HJDHomeOrderDetailDeclarationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.titleLabel.text = @"报单信息";
            return cell;
            break;
        }
        case 2: {
            HJDHomeOrderDetailPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
            if (cell == nil) {
                cell = [[HJDHomeOrderDetailPhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.titleLabel.text = @"照片信息";
            return cell;
            break;
        }
        case 3: {
            HJDHomeOrderDetailProcessCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
            if (cell == nil) {
                cell = [[HJDHomeOrderDetailProcessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.titleLabel.text = @"工单流程";
            return cell;
            break;
        }
        default: {
            HJDHomeOrderDetailButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier4];
            if (cell == nil) {
                cell = [[HJDHomeOrderDetailButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.delegate = self;
            return cell;
            break;
        }
    }
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 44 + 1 + 16 + 14 * 5 + 12 * 4 + 16;
            break;
        case 1:
            return 44 + 1 + 16 + 14 * 7 + 12 * 6 + 16;
            break;
        case 2:
            return 44 + 1 + 4 + (12 + 12 + 17 + 8 + 14 + 4 + 12 + 12) + 16;
            break;
        case 3:
            return 44 + 1 + 4 + (12 + 12 + 17 + 8 + 14 + 4 + 12 + 12) + 16;
            break;
        default:
            return 49;
            break;
    }
}

#pragma mark - HJDHomeOrderDetailButtonCellDelegate
- (void)buttonCell:(HJDHomeOrderDetailButtonCell *)buttonCell selectButtonIndex:(NSInteger)index {
    if (index == 0) { //拒单
        HJDHomeOrderRefuseViewController *controller = [[HJDHomeOrderRefuseViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    } else { //通过
        
    }
}
@end
