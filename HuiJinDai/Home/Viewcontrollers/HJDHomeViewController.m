//
//  HJDHomeViewController.m
//  HuiJinDai
//
//  Created by SHANPX on 2018/8/31.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeViewController.h"
#import "HKScrollView.h"
#import "HJDHomeOrderAuditViewController.h"
#import "HJDHomeOrderManageViewController.h"
#import "HJDHomeTableViewCell.h"
#import "HJDHomeModel.h"
#import "HJDHomeCalculatorViewController.h"
#import "HJDMessageViewController.h"
#import "HJDHomeRoomDiDaiViewController.h"
#import "HJDHomeManager.h"
#import "HJDUserModel.h"
#import "HJDUserDefaultsManager.h"
#import "HJDHomeLocationManager.h"
#import "HJDHomeNavBarButton.h"
#import "HJDHomeOrderProcessViewController.h"
#import "HJDHomeBankViewController.h"

@interface HJDHomeViewController ()<UITableViewDelegate, UITableViewDataSource, HKScrollViewNetDelegate, HJDHomeTableViewCellDelegate, HJDHomeLocationManagerDelegate>
@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) NSMutableArray *dataSource;
@property(strong, nonatomic) HKScrollView *netWorkScrollView;
@property(nonatomic, strong) NSMutableArray *imageArray;
@property(nonatomic, strong) HJDUserModel *userModel;

@property(nonatomic, copy) NSString *manageCount;
@property(nonatomic, copy) NSString *auditCount;
@end

@implementation HJDHomeViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - kTabBarHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kWithe;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (HKScrollView *)netWorkScrollView {
//    if (!_netWorkScrollView) {
        CGFloat width = kScreenWidth;
        CGFloat height = 304 * width / 720;
        _netWorkScrollView = [[HKScrollView alloc]initWithFrame:CGRectMake(0, 0, width, height) WithNetImages:self.imageArray];
        _netWorkScrollView.AutoScrollDelay = 2;
        _netWorkScrollView.placeholderImage = [UIImage imageNamed:@"hk_timeline_image_loading"];
        _netWorkScrollView.netDelagate = self;
//    }
    return _netWorkScrollView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _userModel = (HJDUserModel *)[[HJDUserDefaultsManager shareInstance] loadObject:kUserModelKey];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showNavigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTitle:@"首页"];
    self.imageArray = [NSMutableArray new];
    [self setupSubViews];
    
    @weakify(self);
    [HJDHomeManager getHomeBannerCallBack:^(NSArray *data, BOOL result) {
        [self.imageArray removeAllObjects];
        for (NSDictionary * dic in data) {
            NSString * imageurl = [dic objectForKey:@"src"];
            [self.imageArray addObject:kHJDImage(imageurl)];
        }
        self.tableView.tableHeaderView = self.netWorkScrollView ;
        [self.tableView reloadData];
        /*
         {
         click = "";
         src = "../images/banner_default.png";
         },
         {
         click = "http:baidu.com";
         src = "../images/banner_default_2.png";
         }
         */
    }];
    
    [HJDHomeManager getHomePageInfoCallBack:^(NSArray *data, BOOL result) {
        @strongify(self);
        
    }];
    
    if (![CLLocationManager locationServicesEnabled]) {//判断定位操作是否被允许
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置-->隐私-->定位服务，中开启本应用的位置访问权限！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        [self locationManagerDidUpdateLocation:@"正在定位"];
        
        HJDHomeLocationManager *locationManager = [HJDHomeLocationManager sharedManager];
        locationManager.delegate = self;
        [locationManager startLocation];
    }
    
    //获取未读消息数
    if (self.userModel.type.integerValue == HJDUserTypeChannel || self.userModel.type.integerValue == HJDUserTypeManager) {
        @weakify(self);
        [HJDHomeManager getOrderMessageUnreadCount:^(NSInteger manageCount, NSInteger auditCount) {
            @strongify(self);
            if (manageCount == 0) {
                self.manageCount = nil;
            } else {
                self.manageCount = [NSString stringWithFormat:@"%ld", manageCount];
            }
            
            if (auditCount == 0) {
                self.auditCount = nil;
            } else {
                self.auditCount = [NSString stringWithFormat:@"%ld", auditCount];
            }
            self.dataSource = nil;
            [self.tableView reloadData];
        }];
    }
}

- (void)setupSubViews {
    [self setRightNavigationButton:nil backImage:kImage(@"首页通知") highlightedImage:kImage(@"首页通知") frame:CGRectMake(0, 0, 44, 44)];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.netWorkScrollView;
    
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self refreshData];
    }];
}

- (void)refreshData {
    [HJDHomeManager getHomeBannerCallBack:^(NSArray *data, BOOL result) {
        [self.imageArray removeAllObjects];
        for (NSDictionary * dic in data) {
            NSString * imageurl = [dic objectForKey:@"src"];
            [self.imageArray addObject:kHJDImage(imageurl)];
        }
        self.tableView.tableHeaderView = self.netWorkScrollView ;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)navigationRightButtonClicked:(UIButton *)sender {
    HJDMessageViewController *controller = [[HJDMessageViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HJDHomeTableViewCell";
    HJDHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[HJDHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.section];
    NSArray *arr = [dic objectForKey:@"sectionValue"];
    [cell configCellWithArray:arr];
    return cell;
}

#pragma mark - UITableView Delegate methods
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    NSDictionary * dic = [self.dataSource objectAtIndex:section];
    NSString * sectionTitle = [dic objectForKey:@"sectionTitle"];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, kScreenWidth-20, 20)];
    label.font = [UIFont boldSystemFontOfSize:17];
    label.text = sectionTitle;
    [headerView addSubview:label];
    return headerView;
}

#pragma mark - HKScrollViewNetDelegate
/** 点中网络滚动视图后触发*/
-(void)didSelectedNetImageAtIndex:(NSInteger)index {
    
}

- (void)tableViewCell:(HJDHomeTableViewCell *) cell didselectButtonWithIndex:(NSInteger)index {
    if (index >= cell.dataArray.count) {
        return;
    }
    HJDHomeModel * model = [cell.dataArray objectAtIndex:index];
    if ([model.title isEqualToString:@"房抵贷"]) {
        HJDHomeRoomDiDaiViewController *diDaiController = [[HJDHomeRoomDiDaiViewController alloc] init];
        diDaiController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:diDaiController animated:YES];
    } else if ([model.title isEqualToString:@"车抵贷"]) {
        
    } else if ([model.title isEqualToString:@"信贷"]) {
        
    } else if ([model.title isEqualToString:@"工单审核"]) {
        HJDHomeOrderAuditViewController *auditController = [[HJDHomeOrderAuditViewController alloc] init];
        auditController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:auditController animated:YES];
    } else if ([model.title isEqualToString:@"工单管理"]) {
        if (self.userModel.type.integerValue == HJDUserTypeAgent) {
            HJDHomeOrderProcessViewController *controller = [[HJDHomeOrderProcessViewController alloc] init];
            controller.uid = self.userModel.user_id;
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        } else {
            HJDHomeOrderManageViewController *controller = [[HJDHomeOrderManageViewController alloc] init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
    } else if ([model.title isEqualToString:@"绑定银行卡"]) {
        HJDHomeBankViewController *bankController = [[HJDHomeBankViewController alloc] init];
        bankController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bankController animated:YES];
    } else if ([model.title isEqualToString:@"还款计算器"]) {
        HJDHomeCalculatorViewController *calcuController = [[HJDHomeCalculatorViewController alloc]init];
        calcuController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:calcuController animated:YES];
    }

}

#pragma mark - HJDHomeLocationManagerDelegate
- (void)locationManagerDidUpdateLocation:(NSString *)location {
    HJDHomeNavBarButton *btn = [[HJDHomeNavBarButton alloc] initWithFrame:CGRectMake(0, 00, 100, 44)];
    btn.hjd_title = location;

    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftBar;

}

#pragma mark - getters && setters
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
        switch (self.userModel.type.integerValue) {
                case HJDUserTypeAgent: {
                    HJDHomeModel * model = [HJDHomeModel new];
                    model.title = @"房抵贷";
                    model.imageName = @"首页房抵贷";
                    HJDHomeModel * model1 = [HJDHomeModel new];
                    model1.title = @"车抵贷";
                    model1.imageName = @"首页车抵贷";
                    HJDHomeModel * model2 = [HJDHomeModel new];
                    model2.title = @"信贷";
                    model2.imageName = @"首页信贷";
                    NSArray * array = @[model,model1,model2];
                    
                    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:array,@"sectionValue",@"业务分类",@"sectionTitle", nil];
                    
                    [_dataSource addObject:dic];

                    HJDHomeModel * model4 = [HJDHomeModel new];
                    model4.title = @"工单管理";
                    model4.imageName = @"首页工单管理";
                    HJDHomeModel * model5 = [HJDHomeModel new];
                    model5.title = @"还款计算器";
                    model5.imageName = @"首页还款计算器";
                    NSArray * array2 = @[model4,model5];
                    
                    NSDictionary * dic2 = [NSDictionary dictionaryWithObjectsAndKeys:array2,@"sectionValue",@"工单管理",@"sectionTitle", nil];
                    
                    [_dataSource addObject:dic2];
                    
                    break;
                }
                case HJDUserTypeManager: {
                    HJDHomeModel * model = [HJDHomeModel new];
                    model.title = @"房抵贷";
                    model.imageName = @"首页房抵贷";
                    HJDHomeModel * model1 = [HJDHomeModel new];
                    model1.title = @"车抵贷";
                    model1.imageName = @"首页车抵贷";
                    HJDHomeModel * model2 = [HJDHomeModel new];
                    model2.title = @"信贷";
                    model2.imageName = @"首页信贷";
                    NSArray * array = @[model,model1,model2];
                    
                    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:array,@"sectionValue",@"业务分类",@"sectionTitle", nil];
                    
                    [_dataSource addObject:dic];
                    
                    HJDHomeModel * model3 = [HJDHomeModel new];
                    model3.title = @"工单审核";
                    model3.imageName = @"首页工单审核";
                    model3.unreadCount = self.auditCount;
                    HJDHomeModel * model4 = [HJDHomeModel new];
                    model4.title = @"工单管理";
                    model4.imageName = @"首页工单管理";
                    model4.unreadCount = self.manageCount;
                    HJDHomeModel * model5 = [HJDHomeModel new];
                    model5.title = @"绑定银行卡";
                    model5.imageName = @"首页银行卡";
                    NSArray * array2 = @[model3,model4,model5];
                    
                    NSDictionary * dic2 = [NSDictionary dictionaryWithObjectsAndKeys:array2,@"sectionValue",@"工单管理",@"sectionTitle", nil];
                    
                    [_dataSource addObject:dic2];
                    
                    HJDHomeModel *model6 = [HJDHomeModel new];
                    model6.title = @"还款计算器";
                    model6.imageName = @"首页还款计算器";
                    NSArray *array3 = @[ model6 ];
                    
                    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:array3, @"sectionValue", @"其他功能", @"sectionTitle", nil];
                    
                    [_dataSource addObject:dic3];
                    break;
                }
                case HJDUserTypeChannel: {
                    
                    HJDHomeModel * model3 = [HJDHomeModel new];
                    model3.title = @"工单审核";
                    model3.imageName = @"首页工单审核";
                    model3.unreadCount = self.auditCount;
                    HJDHomeModel * model4 = [HJDHomeModel new];
                    model4.title = @"工单管理";
                    model4.imageName = @"首页工单管理";
                    model4.unreadCount = self.manageCount;
                    HJDHomeModel * model5 = [HJDHomeModel new];
                    model5.title = @"还款计算器";
                    model5.imageName = @"首页还款计算器";
                    NSArray * array2 = @[model3,model4,model5];
                    
                    NSDictionary * dic2 = [NSDictionary dictionaryWithObjectsAndKeys:array2,@"sectionValue",@"工单管理",@"sectionTitle", nil];
                    
                    [_dataSource addObject:dic2];
                    break;
                }
            
        }
    }
    return _dataSource;
}

@end
