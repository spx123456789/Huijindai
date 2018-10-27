//
//  HJDMessageViewController.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/9.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMessageViewController.h"
#import "HJDMessageTableViewCell.h"
#import "HJDMessageManager.h"
#import "HJDMessageSegmentView.h"
#import "HJDHomeOrderDetailViewController.h"

@interface HJDMessageViewController ()<UITableViewDelegate, UITableViewDataSource, HJDMessageSegmentViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) HJDMessageSegmentView *segmentView;
@property(nonatomic, assign) HJDMessageType selectType;
@property(nonatomic, strong) NSIndexPath *editingIndexPath;
@property(nonatomic, assign) NSInteger messagePage;
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
        self.messagePage = 1;
    }
    return self;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (self.editingIndexPath)
    {
        [self configSwipeButtons];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.segmentView;
    self.view.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    [self.view addSubview:self.tableView];

    [self getMessageDataType:@"1"];
    
    @weakify(self);
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self getMessageDataType:self.selectType == HJDMessageTypeMy ? @"1" : @"3"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getMessageDataType:(NSString *)type {
    @weakify(self);
    [MBProgressHUD showMessage:@"正在加载..."];
    [HJDMessageManager getMyMessageWithType:type page:self.messagePage callBack:^(NSArray *data, BOOL result) {
        @strongify(self);
        [MBProgressHUD hideHUD];
        [self.tableView.mj_footer endRefreshing];
        if (result) {
            [self.dataSource addObjectsFromArray:data];
            [self.tableView reloadData];
            if (self.messagePage == 1 && data.count == 0) {
                [self showNodataViewFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight)];
            } else {
                [self hideHttpResultView];
            }
            
            if (data.count == 0 || data.count < kHJDHttpRow) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            self.messagePage++;
        } else {
            [MBProgressHUD showError:@"加载失败"];
        }
    }];
}

- (void)configSwipeButtons {
    // 获取选项按钮的reference
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue>=11.0)
    {
        // iOS 11层级 (Xcode 9编译): UITableView -> UISwipeActionPullView
        for (UIView *subview in self.tableView.subviews)
        {
            if ([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")])
            {
                // 和iOS 10的按钮顺序相反
                UIButton *deleteButton = subview.subviews[0];
                
                [self configDeleteButton:deleteButton];
            }
        }
    }
    else
    {
        // iOS 8-10层级: UITableView -> UITableViewCell -> UITableViewCellDeleteConfirmationView
        HJDMessageTableViewCell *tableCell = [self.tableView cellForRowAtIndexPath:self.editingIndexPath];
        for (UIView *subview in tableCell.subviews)
        {
            if ([subview isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")] && [subview.subviews count] >= 2)
            {
                UIButton *deleteButton = subview.subviews[0];
                
                [self configDeleteButton:deleteButton];
            }
        }
    }
}

- (void)configDeleteButton:(UIButton*)deleteButton {
    if (deleteButton) {
        [deleteButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [deleteButton setTitle:@"删除通知" forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"通知删除"] forState:UIControlStateNormal];
        [deleteButton setBackgroundColor:kRGB_Color(0xFF, 0x52, 0x52)];
        [self centerImageAndTextOnButton:deleteButton];
    }
}

- (void)centerImageAndTextOnButton:(UIButton*)button {
    // this is to center the image and text on button.
    // the space between the image and text
    CGFloat spacing = 35.0;
    
    // lower the text and push it left so it appears centered below the image
    CGSize imageSize = button.imageView.image.size;
    button.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
    
    // raise the image and push it right so it appears centered above the text
    CGSize titleSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: button.titleLabel.font}];
    button.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
    
    // increase the content height to avoid clipping
    CGFloat edgeOffset = (titleSize.height - imageSize.height) / 2.0;
    button.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0.0, edgeOffset, 0.0);
    
    // move whole button down, apple placed the button too high in iOS 10
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue<11.0)
    {
        CGRect btnFrame = button.frame;
        btnFrame.origin.y = 18;
        button.frame = btnFrame;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    self.editingIndexPath = indexPath;
    [self.view setNeedsLayout];   // 触发-(void)viewDidLayoutSubviews
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    self.editingIndexPath = nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *mut = self.dataSource[indexPath.section];
    HJDMessageModel *message = mut[indexPath.row];
    HJDHomeOrderDetailViewController *detailController = [[HJDHomeOrderDetailViewController alloc] init];
    detailController.order_id = message.lid;
    [self.navigationController pushViewController:detailController animated:YES];
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
        //修改数据
        NSMutableArray *mut = self.dataSource[indexPath.section];
        [mut removeObjectAtIndex:indexPath.row];
        if (mut.count == 0) {
            [self.dataSource removeObject:mut];
        }
        [self.tableView reloadData];
        completionHandler (YES);
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
    self.messagePage = 1;
    [self getMessageDataType:type == HJDMessageTypeMy ? @"1" : @"3"];
}
@end
