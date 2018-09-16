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
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.segmentView;
    
    self.dataSource = [NSMutableArray arrayWithArray:[HJDMessageManager getMyMessage]];
    
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
    cell.number = model.number;
    cell.type = model.type;
    cell.status = model.status;
    if (self.selectType == HJDMessageTypeMy) {
        cell.channelLabel.hidden = YES;
    } else {
        cell.channelLabel.hidden = NO;
    }
    
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
    timeLabel.text = model.time;
    return view;
}

#pragma mark - HJDMessageSegmentViewDelegate
- (void)segmentView:(HJDMessageSegmentView *)segmentView didSelectMessageType:(HJDMessageType)type {
    self.selectType = type;
    [self.dataSource removeAllObjects];
    if (type == HJDMessageTypeMy) {
        [self.dataSource addObjectsFromArray:[HJDMessageManager getMyMessage]];
    } else {
        [self.dataSource addObjectsFromArray:[HJDMessageManager getChannelMessage]];
    }
    [self.tableView reloadData];
}
@end
