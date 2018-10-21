//
//  HJDMessageViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/9.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMessageViewController.h"
#import "HJDMessageTableViewCell.h"
#import "HJDMessageManager.h"
#import "HJDMessageSegmentView.h"

@interface HJDMessageViewController ()<UITableViewDelegate, UITableViewDataSource, HJDMessageSegmentViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) HJDMessageSegmentView *segmentView;
@property(nonatomic, assign) HJDMessageType selectType;
@property(nonatomic, strong) NSMutableArray *myDataSource;
@property(nonatomic, strong) NSMutableArray *channelDataSource;
@property(nonatomic, assign) BOOL isFirstLoadChannel;
@end

@implementation HJDMessageViewController

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

- (HJDMessageSegmentView *)segmentView {
    if (!_segmentView) {
        _segmentView = [[HJDMessageSegmentView alloc] initWithFrame:CGRectMake(0, 0, 240, 32)];
        _segmentView.delegate = self;
    }
    return _segmentView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.selectType = HJDMessageTypeMy;
        self.dataSource = [NSMutableArray array];
        self.isFirstLoadChannel = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.segmentView;
    
    [self.view addSubview:self.tableView];
    
    [self getMessageData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getMessageData {
    @weakify(self);
    [MBProgressHUD showMessage:@"正在加载..."];
    [HJDMessageManager getMyMessageWithType:@"1" callBack:^(NSArray *data, BOOL result) {
        @strongify(self);
        [MBProgressHUD hideHUD];
        if (result) {
            self.myDataSource = [NSMutableArray arrayWithArray:data];
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:self.myDataSource];
            [self.tableView reloadData];
        } else {
            [MBProgressHUD showError:@"加载失败"];
        }
    }];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 202;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        //[self.titleArr removeObjectAtIndex:indexPath.row];
        completionHandler (YES);
        [self.tableView reloadData];
    }];
    deleteRowAction.image = [UIImage imageNamed:@"删除"];
    deleteRowAction.backgroundColor = [UIColor redColor];
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *mut = self.dataSource[section];
    return mut.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HJDMessageTableViewCell";
    HJDMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[HJDMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSMutableArray *mut = self.dataSource[indexPath.section];
    HJDMessageModel *model = mut[indexPath.row];
    [cell setCellValue:model];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    view.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 40, 16, 120, 12)];
    timeLabel.textColor = kRGB_Color(0xff, 0xff, 0xff);
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.backgroundColor = kRGB_Color(0xDB, 0xDB, 0xDB);
    timeLabel.font = kFont12;
    timeLabel.layer.masksToBounds = YES;
    timeLabel.layer.cornerRadius = 5.f;
    [view addSubview:timeLabel];
    NSMutableArray *mut = self.dataSource[section];
    HJDMessageModel *model = mut.firstObject;
    
    //2018-10-20 22:34:39
    NSString *month = [model.create_time substringWithRange:NSMakeRange(5, 2)];
    NSString *day = [model.create_time substringWithRange:NSMakeRange(8, 2)];
    NSString *timeStr = [NSString stringWithFormat:@"%@月%@日", month, day];
    timeLabel.text = timeStr;
    [timeLabel sizeToFit];
    CGRect oldFrame = timeLabel.frame;
    CGFloat LabelWidth = oldFrame.size.width + 16;
    timeLabel.frame = CGRectMake(kScreenWidth/2 - LabelWidth/2, oldFrame.origin.y, LabelWidth, 15);
    return view;
}

#pragma mark - HJDMessageSegmentViewDelegate
- (void)segmentView:(HJDMessageSegmentView *)segmentView didSelectMessageType:(HJDMessageType)type {
    self.selectType = type;
    [self.dataSource removeAllObjects];
    if (type == HJDMessageTypeMy) {
        [self.dataSource addObjectsFromArray:self.myDataSource];
        [self.tableView reloadData];
    } else {
        if (self.isFirstLoadChannel) {
            self.isFirstLoadChannel = NO;
            [MBProgressHUD showMessage:@"正在加载..."];
            @weakify(self);
            [HJDMessageManager getMyMessageWithType:@"3" callBack:^(NSArray *data, BOOL result) {
                @strongify(self);
                [MBProgressHUD hideHUD];
                if (result) {
                    self.channelDataSource = [NSMutableArray arrayWithArray:data];
                    [self.dataSource addObjectsFromArray:self.channelDataSource];
                    [self.tableView reloadData];
                } else {
                    [MBProgressHUD showError:@"加载失败"];
                }
            }];
        } else {
            [self.dataSource addObjectsFromArray:self.channelDataSource];
            [self.tableView reloadData];
        }
    }
}
@end
