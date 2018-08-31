//
//  HJDHomeViewController.m
//  HuiJinDai
//
//  Created by SHANPX on 2018/8/31.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeViewController.h"
#import "HKScrollView.h"
@interface HJDHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) HKScrollView *netWorkScrollView;
@end

@implementation HJDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    NSArray *array = @[@"",@"",@""];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = 304*width/720;
    self.netWorkScrollView = [[HKScrollView alloc]initWithFrame:CGRectMake(0, 0, width, height) WithNetImages:array];
    self.netWorkScrollView.AutoScrollDelay = 2;
    self.netWorkScrollView.placeholderImage = [UIImage imageNamed:@"hk_timeline_image_loading"];
    self.netWorkScrollView.netDelagate = self;
    self.tableView.tableHeaderView = self.netWorkScrollView;
//    @weakify(self);
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        @strongify(self);
//        [self refreshDate];
//    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - getters && setters

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kSafeAreaTopHeight-kSafeAreaBottomHeight-kTabBarHeight) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
