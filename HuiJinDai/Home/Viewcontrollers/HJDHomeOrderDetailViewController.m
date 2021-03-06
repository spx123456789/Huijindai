//
//  HJDHomeOrderDetailViewController.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/16.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeOrderDetailViewController.h"
#import "HJDHomeOrderDetailTableViewCell.h"
#import "HJDHomeOrderDetailPhotoCell.h"
#import "HJDHomeOrderRefuseViewController.h"
#import "HJDHomeOrderApprovedView.h"
#import "HJDHomeRoomDiDaiManager.h"
#import "HJDHomeOrderDetailResultViewController.h"
#import "HJDMyManager.h"
#import "HJDPhotoBrowseViewController.h"
#import "HJDHomeBankViewController.h"

@interface HJDHomeOrderDetailViewController ()<UITableViewDelegate, UITableViewDataSource, HJDHomeOrderDetailButtonCellDelegate, HJDHomeOrderDetailPhotoCellDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) NSMutableDictionary *topDictionary;
@end

@implementation HJDHomeOrderDetailViewController

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

- (void)tapBankView:(UITapGestureRecognizer *)tap {
    HJDHomeBankViewController *bankController = [[HJDHomeBankViewController alloc] init];
    bankController.order_id = self.order_id;
    [self.navigationController pushViewController:bankController animated:YES];
}

- (UIView *)createViewWithStatus:(NSInteger)status frame:(CGRect)frame {
    UIView *bankView = [[UIView alloc] initWithFrame:frame];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBankView:)];
    [bankView addGestureRecognizer:tap];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(16, CGRectGetHeight(frame)/2 - 6, 12, 12)];
    [bankView addSubview:imgView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(32, CGRectGetHeight(frame)/2 - 8, CGRectGetWidth(frame) - 32 - 16, 16)];
    label.font = kFont14;
    [bankView addSubview:label];
    
    switch (status) {
        case 99: {
            imgView.image = kImage(@"!w");
            label.text = @"银行卡绑定中，点击查看银行卡信息";
            label.textColor = kRGB_Color(0xf5, 0x97, 0x01);
            bankView.backgroundColor = kRGB_Color(0xfc, 0xf6, 0xd5);
            break;
        }
        case 2: {
            imgView.image = kImage(@"!f");
            label.text = @"银行卡绑定失败，点此重新绑定";
            label.textColor = kRGB_Color(0xff, 0x52, 0x52);
            bankView.backgroundColor = kRGB_Color(0xff, 0xe1, 0xe1);
            break;
        }
        case 0: {
            imgView.image = kImage(@"!f");
            label.text = @"未绑定银行卡，点此重新绑定";
            label.textColor = kRGB_Color(0xff, 0x52, 0x52);
            bankView.backgroundColor = kRGB_Color(0xff, 0xe1, 0xe1);
            break;
        }
        default: {
            imgView.image = kImage(@"矩形1148拷贝");
            label.text = @"银行卡绑定成功，点击更换银行卡";
            label.textColor = kRGB_Color(0x0f, 0xc8, 0x6f);
            bankView.backgroundColor = kRGB_Color(0xd4, 0xfc, 0xe9);
            break;
        }
    }
    
    return bankView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTitle:@"工单详情"];
    self.view.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    self.dataSource = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    
    @weakify(self);
    [MBProgressHUD showMessage:@"正在加载..."];
    [HJDHomeRoomDiDaiManager getOrderDetailWithID:self.order_id from:self.controller_from callBack:^(NSDictionary *data, BOOL result) {
        [MBProgressHUD hideHUD];
        @strongify(self);
        if (result) {
            [self.dataSource addObject:data[@"xunzhi"]];
            [self.dataSource addObject:data[@"baodan"]];
            [self.dataSource addObject:data[@"fujian"]];
            [self.dataSource addObject:data[@"status_log"]];
            
            HJDUserModel *userModel = (HJDUserModel *)[[HJDUserDefaultsManager shareInstance] loadObject:kUserModelKey];
            BOOL isChannel = ([data[@"channel_type"] integerValue] == 1) && (userModel.type.integerValue == HJDUserTypeChannel);
            BOOL isManager = ([data[@"manager_type"] integerValue] == 1) && (userModel.type.integerValue == HJDUserTypeManager);
            
            if (isChannel || isManager) {
                [self.dataSource addObject:@(1)];
            }
            [self setTabelViewTopView:data];
            [self.tableView reloadData];
        } else {
            [MBProgressHUD showError:@"加载失败"];
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(auditNotificationName:) name:kHJDOrderAuditNotificationName object:nil];
}

- (void)auditNotificationName:(NSNotification *)noti {
    [self hideAuditButton];
}

- (void)setTabelViewTopView:(NSDictionary *)resultDic {
    self.topDictionary = [NSMutableDictionary dictionaryWithDictionary:resultDic];
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    
    UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (self.isShowBank) {
        //是否绑定银行卡信息，0未绑定，1绑定成功/已绑定，2绑定失败,99绑定中
        NSString *isBank = resultDic[@"register_bank"];
        UIView *bankView = [self createViewWithStatus:isBank.integerValue frame:CGRectMake(0, 0, kScreenWidth, 50)];
        [topView addSubview:bankView];
        
        topView.frame = CGRectMake(0, 0, kScreenWidth, 53 + 3 + 5);
        topBtn.frame = CGRectMake(16, 50 + 10 + 3, kScreenWidth - 32, 53);
    } else {
        topBtn.frame = CGRectMake(16, 10, kScreenWidth - 32, 53);
    }
    
    if ([resultDic[@"credit_type"] integerValue] == 1) { //是否已放款 1是 2否
        [topBtn setBackgroundImage:kImage(@"工单详情已放款") forState:UIControlStateNormal];
        [topBtn setBackgroundImage:kImage(@"工单详情已放款") forState:UIControlStateHighlighted];
        [topBtn addTarget:self action:@selector(planButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:topBtn];
        if (self.isShowBank) {
            topView.frame = CGRectMake(0, 0, kScreenWidth, 50 + 10 + 53 + 3 + 5);
        } else {
            topView.frame = CGRectMake(0, 0, kScreenWidth, 10 + 53 + 3 + 5);
        }
    } else if ([resultDic[@"refuse_type"] integerValue] == 1) { //是否已拒绝
        [topBtn setBackgroundImage:kImage(@"共党详情已拒单") forState:UIControlStateNormal];
        [topBtn setBackgroundImage:kImage(@"共党详情已拒单") forState:UIControlStateHighlighted];
        [topBtn addTarget:self action:@selector(refuseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:topBtn];
        if (self.isShowBank) {
            topView.frame = CGRectMake(0, 0, kScreenWidth, 50 + 10 + 53 + 3 + 5);
        } else {
            topView.frame = CGRectMake(0, 0, kScreenWidth, 10 + 53 + 3 + 5);
        }
    } else if ([resultDic[@"letter_type"] integerValue] == 1) { //是否显示批贷函、审查报告
        [topBtn setBackgroundImage:kImage(@"工单详情查看批贷函") forState:UIControlStateNormal];
        [topBtn setBackgroundImage:kImage(@"工单详情查看批贷函") forState:UIControlStateHighlighted];
        [topBtn addTarget:self action:@selector(presentationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
//        UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        bottomBtn.frame = CGRectMake(16, 10 + 53 + 3, kScreenWidth - 32, 53);
//        [bottomBtn setBackgroundImage:kImage(@"工单详情查看审查报告") forState:UIControlStateNormal];
//        [bottomBtn setBackgroundImage:kImage(@"工单详情查看审查报告") forState:UIControlStateHighlighted];
//        [bottomBtn addTarget:self action:@selector(approvalButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [topView addSubview:bottomBtn];
        
        [topView addSubview:topBtn];
        if (self.isShowBank) {
            topView.frame = CGRectMake(0, 0, kScreenWidth, 50 + 10 + 53 + 3 + 5);
        } else {
            topView.frame = CGRectMake(0, 0, kScreenWidth, 10 + 53 + 3 + 5);
        }
    }
    
    self.tableView.tableHeaderView = topView;
}

- (void)refuseButtonClick:(id)sender {
    //拒单原因
    NSString *refuseStr = self.topDictionary[@"refuse"];
    HJDHomeOrderRefuseViewController *controller = [[HJDHomeOrderRefuseViewController alloc] init];
    controller.order_id = self.order_id;
    controller.refuseContent = refuseStr;
    controller.isView = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)presentationButtonClick:(id)sender {
    // 审批函文件位置,PDF文件
    NSString *presentation = self.topDictionary[@"presentation"];
    [self goToNextController:presentation];
}

- (void)approvalButtonClick:(id)sender {
    // 审查报告文件位置,PDF文件
    NSString *approval = self.topDictionary[@"approval"];
    [self goToNextController:approval];
}

- (void)planButtonClick:(id)sender {
    // 还款计划信息，该信息为字典形式，目前暂时未定义
    NSString *plan = self.topDictionary[@"plan"];
    [self goToNextController:plan];
}

- (void)goToNextController:(NSString *)word {
    HJDHomeOrderDetailResultViewController *resultController = [[HJDHomeOrderDetailResultViewController alloc] init];
    resultController.wordUrl = word;
    [self.navigationController pushViewController:resultController animated:YES];
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
            [cell setDetailCellValue:self.dataSource[indexPath.row]];
            return cell;
            break;
        }
        case 1: {
            HJDHomeOrderDetailDeclarationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            if (cell == nil) {
                cell = [[HJDHomeOrderDetailDeclarationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.titleLabel.text = @"报单信息";
            [cell setCellDeclarationValue:self.dataSource[indexPath.row]];
            return cell;
            break;
        }
        case 2: {
            HJDHomeOrderDetailPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
            if (cell == nil) {
                cell = [[HJDHomeOrderDetailPhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.titleLabel.text = @"照片信息";
            cell.delegate = self;
            cell.imgDataArray = self.dataSource[indexPath.row];
            return cell;
            break;
        }
        case 3: {
            HJDHomeOrderDetailProcessCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
            if (cell == nil) {
                cell = [[HJDHomeOrderDetailProcessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier3];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.titleLabel.text = @"工单流程";
            cell.processArray = self.dataSource[indexPath.row];
            return cell;
            break;
        }
        default: {
            HJDHomeOrderDetailButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier4];
            if (cell == nil) {
                cell = [[HJDHomeOrderDetailButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier4];
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
            return 44 + 1 + 16 + 14 * 5 + 12 * 4 + 16 + 4;
            break;
        case 1:
            return 44 + 1 + 16 + 14 * 7 + 12 * 6 + 16 + 4;
            break;
        case 2: {
            CGFloat collectionHeight = 44 + 1;
            for (NSDictionary *infoDic in self.dataSource[indexPath.row]) {
                NSArray *sectionArray = infoDic[@"list"];
                if (sectionArray.count != 0) {
                    collectionHeight += 30;
                    collectionHeight += (12 + kDetailPhotoHeight * (sectionArray.count/3 + 1) + 8 * (sectionArray.count/3));
                }
            }
            return collectionHeight + 16;
            break;
        }
        case 3: {
            NSArray *arr = self.dataSource[indexPath.row];
            CGFloat viewHeight = 12 + 12 + 17 + 8 + 14 + 4 + 12 + 12;
            return 44 + 1 + 4 + (viewHeight * arr.count) + 16;
            break;
        }
        default:
            return 49;
            break;
    }
}

#pragma mark - HJDHomeOrderDetailPhotoCellDelegate
- (void)detailPhotoCell:(HJDHomeOrderDetailPhotoCell *)detailPhotoCell didSelectIndexPath:(NSIndexPath *)indexPath {
    //大图浏览
    HJDPhotoBrowseViewController *controller = [[HJDPhotoBrowseViewController alloc] init];
    NSArray *allImageArray = self.dataSource[2];
    
    NSMutableArray *mutArray = [NSMutableArray array];
    for (NSDictionary *sectionDic in allImageArray) {
        NSArray *sectionArray = sectionDic[@"list"];
        if (sectionArray.count != 0) {
            [mutArray addObject:sectionDic];
        }
    }
    controller.dataSource = mutArray;
    controller.currentIndexPath = indexPath;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - HJDHomeOrderDetailButtonCellDelegate
- (void)buttonCell:(HJDHomeOrderDetailButtonCell *)buttonCell selectButtonIndex:(NSInteger)index {
    if (index == 0) { //拒单
        HJDHomeOrderRefuseViewController *controller = [[HJDHomeOrderRefuseViewController alloc] init];
        controller.order_id = self.order_id;
        [self.navigationController pushViewController:controller animated:YES];
    } else { //通过
        HJDUserModel *userModel = (HJDUserModel *)[[HJDUserDefaultsManager shareInstance] loadObject:kUserModelKey];
        if (userModel.type.integerValue == HJDUserTypeChannel) {
            @weakify(self);
            [MBProgressHUD showMessage:@""];
            [HJDMyManager getMyRelationWithUrl:@"/User/get_customer" keyWork:nil callBack:^(NSArray *arr, BOOL result) {
                [MBProgressHUD hideHUD];
                if (result) {
                    if (arr == nil || arr.count == 0) {
                        [MBProgressHUD showError:@"暂无审核的客户经理"];
                    } else {
                        HJDHomeOrderApprovedView *approveView = [[HJDHomeOrderApprovedView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                        NSMutableArray *tempArray = [NSMutableArray array];
                        for (NSDictionary *modelDic in arr) {
                            HJDMyAgentModel *model = [[HJDMyAgentModel alloc] init];
                            [model hjd_loadDataFromkeyValues:modelDic];
                            [tempArray addObject:model];
                        }
                        approveView.dataSource = tempArray;
                        [approveView showApprovedView];
                        approveView.callBack = ^(HJDMyAgentModel *model) {
                            @strongify(self);
                            [self postAuditManagerId:model.uid];
                        };
                    }
                } else {
                    [MBProgressHUD showError:@"加载失败"];
                }
            }];
        } else {
            [self postAuditManagerId:nil];
        }
    }
}

- (void)postAuditManagerId:(NSString *)managerID {
    [MBProgressHUD showMessage:@"正在提交..."];
    [HJDHomeRoomDiDaiManager auditOrderWithID:self.order_id step:@"1" content:nil managerId:managerID callBack:^(NSString *msg, BOOL result) {
        [MBProgressHUD hideHUD];
        if (result) {
            [MBProgressHUD showSuccess:@"提交成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:kHJDOrderAuditNotificationName object:nil];
        } else {
            if (msg) {
                [MBProgressHUD showError:msg];
            } else {
                [MBProgressHUD showError:@"提交失败"];
            }
        }
    }];
}

#pragma mark - 审核通过或拒绝 隐藏下方按钮
- (void)hideAuditButton {
    NSNumber *last = self.dataSource.lastObject;
    if ([last isKindOfClass:[NSNumber class]] && last.integerValue == 1) {
        [self.dataSource removeObject:last];
        [self.tableView deleteRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:self.dataSource.count inSection:0] ] withRowAnimation:UITableViewRowAnimationFade];
    }
}
@end
