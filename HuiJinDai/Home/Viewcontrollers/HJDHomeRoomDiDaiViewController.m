//
//  HJDHomeRoomDiDaiViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/24.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeRoomDiDaiViewController.h"
#import "HJDMessageSegmentView.h"
#import "HJDHomeRoomDiDaiTableViewCell.h"
#import "HJDHomeCalculatorResultTableCell.h"
#import "HJDHomeQueryValueResultViewController.h"
#import "HJDHomeQueryValueStatusViewController.h"
#import "HJDCustomerServiceView.h"

typedef enum : NSUInteger {
    HJDRomeQueryValue = 0,  //极速询值
    HJDRomeQueryRecord      //询值记录
} HJDRomeDiDaiType;

@interface HJDHomeRoomDiDaiViewController ()<UITableViewDelegate, UITableViewDataSource, HJDMessageSegmentViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) HJDMessageSegmentView *segmentView;
@property(nonatomic, assign) HJDRomeDiDaiType selectType;
@property(nonatomic, strong) UIButton *queryValueButton;
@property(nonatomic, strong) HJDCustomerServiceView *customServiceView;
@end

@implementation HJDHomeRoomDiDaiViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - 60) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (HJDMessageSegmentView *)segmentView {
    if (!_segmentView) {
        _segmentView = [[HJDMessageSegmentView alloc] initWithFrame:CGRectMake(0, 0, 240, 32)];
        [_segmentView setSegmentViewTitle:@"极速询值" rightTitle:@"询值记录"];
        _segmentView.delegate = self;
    }
    return _segmentView;
}

- (UIButton *)queryValueButton {
    if (!_queryValueButton) {
        _queryValueButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _queryValueButton.frame = CGRectMake(16, 20, kScreenWidth - 32, 44);
        [_queryValueButton setTitle:@"极速询值" forState:UIControlStateNormal];
        [_queryValueButton setTitleColor:kRGB_Color(0xff, 0xff, 0xff) forState:UIControlStateNormal];
        [_queryValueButton setBackgroundColor:kMainColor];
        _queryValueButton.titleLabel.font = kFont15;
        _queryValueButton.layer.masksToBounds = YES;
        _queryValueButton.layer.cornerRadius = 4.f;
        [_queryValueButton addTarget:self action:@selector(queryValueButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _queryValueButton;
}

- (HJDCustomerServiceView *)customServiceView {
    if (!_customServiceView) {
        _customServiceView = [[HJDCustomerServiceView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 70, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - 60, 140, 30)];
        _customServiceView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    }
    return _customServiceView;
}

- (void)queryValueButtonClick:(id)sender {
    HJDHomeQueryValueResultViewController *controller = [[HJDHomeQueryValueResultViewController alloc] init];;
    [self.navigationController pushViewController:controller animated:YES];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.selectType = HJDRomeQueryValue;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.segmentView;
    self.view.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    
    [self reloadView];
}

- (void)reloadView {
    if (self.selectType == HJDRomeQueryValue) {
        self.dataSource = [NSMutableArray arrayWithArray:@[ @"", @"", @"", @"", @"", @"", @"" ]];
        self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - 60);
        [self.view addSubview:self.tableView];
        [self.view addSubview:self.customServiceView];
        self.customServiceView.hidden = NO;
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44 + 20)];
        [footerView addSubview:self.queryValueButton];
        self.tableView.tableFooterView = footerView;
    } else {
        self.dataSource = [NSMutableArray arrayWithArray:@[ @"", @"", @"" ]];
        self.tableView.frame = CGRectMake(0, 4, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - 4);
        [self.view addSubview:self.tableView];
        self.customServiceView.hidden = YES;
        self.tableView.tableFooterView = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectType == HJDRomeQueryValue) {
        
    } else {
        HJDHomeQueryValueStatusViewController *statusController = [[HJDHomeQueryValueStatusViewController alloc] init];
        [self.navigationController pushViewController:statusController animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.selectType) {
        case HJDRomeQueryValue: {
            if (indexPath.row == 0 || indexPath.row == 5) {
                return 44 + 4;
            } else {
                return 45;
            }
            break;
        }
        case HJDRomeQueryRecord: {
            return 44 + 1 + 36 * 2 + 1 * 1 + 4;
            break;
        }
        default:
            return 0;
            break;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.selectType) {
        case HJDRomeQueryValue: {
            static NSString *cellIdentifier = @"HJDHomeRoomDiDaiTableViewCell";
            HJDHomeRoomDiDaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[HJDHomeRoomDiDaiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [self setCellValue:cell indexPath:indexPath];
            return cell;
            break;
        }
        case HJDRomeQueryRecord: {
            static NSString *cellIdentifier = @"HJDHomeCalculatorResultTableCell";
            HJDHomeCalculatorResultTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[HJDHomeCalculatorResultTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.titleLabel.text = @"询值编号：20170912-00450";
            cell.firstLabel.text = @"询值时间";
            cell.twoLabel.text = @"房产地址";
            cell.firstLabel_1.text = @"2018-02-14 18:15";
            cell.twoLabel_1.text = @"北京新世界家园";
            [cell setCellOfNumber:2];
            cell.statusLabel.hidden = NO;
            cell.nextImgView.hidden = NO;
            if (indexPath.row % 2 == 0) {
                [cell setStatusLabelSuccess:YES];
            } else {
                [cell setStatusLabelSuccess:NO];
            }
            return cell;
            break;
        }
        default:
            return nil;
            break;
    }
}

- (void)setCellValue:(HJDHomeRoomDiDaiTableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            cell.leftLabel.text = @"城市";
            cell.placeholderString = @"请选择";
            cell.rightImgView.hidden = NO;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = NO;
            break;
        }
        case 1: {
            cell.leftLabel.text = @"小区名称";
            cell.placeholderString = @"请选择";
            cell.rightImgView.hidden = NO;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = NO;
            break;
        }
        case 2: {
            cell.leftLabel.text = @"楼栋名称";
            cell.placeholderString = @"请选择";
            cell.rightImgView.hidden = NO;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = NO;
            break;
        }
        case 3: {
            cell.leftLabel.text = @"单元门";
            cell.placeholderString = @"请选择";
            cell.rightImgView.hidden = NO;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = NO;
            break;
        }
        case 4: {
            cell.leftLabel.text = @"门牌号";
            cell.placeholderString = @"请选择";
            cell.rightImgView.hidden = NO;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = YES;
            break;
        }
        case 5: {
            cell.leftLabel.text = @"规划用途";
            cell.placeholderString = @"请选择";
            cell.rightImgView.hidden = NO;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = NO;
            break;
        }
        case 6: {
            cell.leftLabel.text = @"建筑面积";
            cell.placeholderString = @"请填写建筑面积";
            cell.rightImgView.hidden = YES;
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text = @"m²";
            cell.lineView.hidden = YES;
            break;
        }
        default:
            break;
    }
}

#pragma mark - HJDMessageSegmentViewDelegate
- (void)segmentView:(HJDMessageSegmentView *)segmentView didSelectMessageType:(HJDMessageType)type {
    self.selectType = (NSUInteger)type;
    //刷新数据
    [self reloadView];
    [self.tableView reloadData];
}
@end
