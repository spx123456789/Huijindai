//
//  HJDHomeQueryValueStatusViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/26.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeQueryValueStatusViewController.h"
#import "HJDHomeOrderDetailTableViewCell.h"

@interface HJDHomeQueryValueStatusViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIButton *continueButton;
@property(nonatomic, strong) UIButton *declarationBtn;
@end

@implementation HJDHomeQueryValueStatusViewController

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

- (UIButton *)continueButton {
    if (!_continueButton) {
        _continueButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_continueButton setTitle:@"继续评值" forState:UIControlStateNormal];
        [_continueButton setTitleColor:kMainColor forState:UIControlStateNormal];
        [_continueButton setBackgroundColor:[UIColor clearColor]];
        _continueButton.titleLabel.font = kFont15;
        _continueButton.layer.masksToBounds = YES;
        _continueButton.layer.cornerRadius = 4.f;
        _continueButton.layer.borderColor = kMainColor.CGColor;
        _continueButton.layer.borderWidth = 0.5f;
        [_continueButton addTarget:self action:@selector(continueButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _continueButton;
}

- (UIButton *)declarationBtn {
    if (!_declarationBtn) {
        _declarationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_declarationBtn setTitle:@"报单" forState:UIControlStateNormal];
        [_declarationBtn setTitleColor:kRGB_Color(0xff, 0xff, 0xff) forState:UIControlStateNormal];
        [_declarationBtn setBackgroundColor:kMainColor];
        _declarationBtn.titleLabel.font = kFont15;
        _declarationBtn.layer.masksToBounds = YES;
        _declarationBtn.layer.cornerRadius = 4.f;
        [_declarationBtn addTarget:self action:@selector(declarationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _declarationBtn;
}

- (void)continueButtonClick:(id)sender {
    
}

- (void)declarationButtonClick:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    
    [self setNavTitle:@"工单详情"];
    
    [self.view addSubview:self.tableView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20 + 12 + 88 + 10)];
    self.continueButton.frame = CGRectMake(16, 20, kScreenWidth - 32, 44);
    [bottomView addSubview:self.continueButton];
    self.declarationBtn.frame = CGRectMake(16, 20 + 44 + 12, kScreenWidth - 32, 44);
    [bottomView addSubview:self.declarationBtn];
    
    self.tableView.tableFooterView = bottomView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 44 + 1 + 16 + 14 * 5 + 12 * 4 + 16 + 4;
            break;
        case 1:
            return 44 + 1 + 16 + 14 * 2 + 12 + 16 + 4;
            break;
        default:
            return 49;
            break;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HJDHomeOrderDetailQueryCell";
    static NSString *cellIdentifier1 = @"HJDHomeOrderDetailQueryValueResultCell";
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
            HJDHomeOrderDetailQueryValueResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            if (cell == nil) {
                cell = [[HJDHomeOrderDetailQueryValueResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.titleLabel.text = @"询值结果";
            return cell;
            break;
        }
        default: {
            return nil;
            break;
        }
    }
}
@end

