//
//  HJDHomeViewController.m
//  HuiJinDai
//
//  Created by SHANPX on 2018/8/31.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeViewController.h"
#import "HKScrollView.h"
#import "HJDOrderAuditViewController.h"
#import "HJDHomeTableViewCell.h"
#import "HJDHomeModel.h"
@interface HJDHomeViewController ()<UITableViewDelegate,UITableViewDataSource,HKScrollViewNetDelegate,HJDHomeTableViewCellDelegate>
@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) NSMutableArray *dataSource;
@property(strong, nonatomic) HKScrollView *netWorkScrollView;
@end

@implementation HJDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.userType = HJDUserType_userManager;
    [self.view addSubview:self.tableView];
    NSArray *array = @[@"",@"",@""];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = 304*width/720;
    self.netWorkScrollView = [[HKScrollView alloc]initWithFrame:CGRectMake(0, 0, width, height) WithNetImages:array];
    self.netWorkScrollView.AutoScrollDelay = 2;
    self.netWorkScrollView.placeholderImage = [UIImage imageNamed:@"hk_timeline_image_loading"];
    self.netWorkScrollView.netDelagate = self;
    self.tableView.tableHeaderView = self.netWorkScrollView;
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self refreshDate];
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshDate {
    
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
    NSDictionary * dic = [self.dataSource objectAtIndex:indexPath.section];
    
    NSArray * arr = [dic objectForKey:@"sectionValue"];
    
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
    HJDHomeModel * model = [cell.dataArray objectAtIndex:index];
    if ([model.title isEqualToString:@"房抵贷"]) {
        
    }else if ([model.title isEqualToString:@"车抵贷"]) {
        
    }else if ([model.title isEqualToString:@"信贷"]) {
        
    }else if ([model.title isEqualToString:@"工单审核"]) {
        //工单审核
        HJDOrderAuditViewController *controller = [[HJDOrderAuditViewController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([model.title isEqualToString:@"工单管理"]) {
        
    }else if ([model.title isEqualToString:@"还款计算器"]) {
        
    }

}


#pragma mark - getters && setters

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
        switch (self.userType) {
                case HJDUserType_user: {
                    
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
                    
                    NSDictionary * dic2 = [NSDictionary dictionaryWithObjectsAndKeys:array2,@"sectionValue",@"功能模块",@"sectionTitle", nil];
                    
                    [_dataSource addObject:dic2];
                    
                    break;
                }
                case HJDUserType_userManager: {
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
                    HJDHomeModel * model4 = [HJDHomeModel new];
                    model4.title = @"工单管理";
                    model4.imageName = @"首页工单管理";
                    HJDHomeModel * model5 = [HJDHomeModel new];
                    model5.title = @"还款计算器";
                    model5.imageName = @"首页还款计算器";
                    NSArray * array2 = @[model3,model4,model5];
                    
                    NSDictionary * dic2 = [NSDictionary dictionaryWithObjectsAndKeys:array2,@"sectionValue",@"功能模块",@"sectionTitle", nil];
                    
                    [_dataSource addObject:dic2];
                    break;
                }
                case HJDUserType_channel: {
                    
                    HJDHomeModel * model3 = [HJDHomeModel new];
                    model3.title = @"工单审核";
                    model3.imageName = @"首页工单审核";
                    HJDHomeModel * model4 = [HJDHomeModel new];
                    model4.title = @"工单管理";
                    model4.imageName = @"首页工单管理";
                    HJDHomeModel * model5 = [HJDHomeModel new];
                    model5.title = @"还款计算器";
                    model5.imageName = @"首页还款计算器";
                    NSArray * array2 = @[model3,model4,model5];
                    
                    NSDictionary * dic2 = [NSDictionary dictionaryWithObjectsAndKeys:array2,@"sectionValue",@"功能模块",@"sectionTitle", nil];
                    
                    [_dataSource addObject:dic2];
                    break;
                }
            
        }
    }
    return _dataSource;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kSafeAreaTopHeight-kSafeAreaBottomHeight-kTabBarHeight) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.backgroundColor = kWithe;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

@end
