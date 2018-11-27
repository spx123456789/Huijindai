//
//  HJDHomeRoomSelectViewController.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeRoomSelectViewController.h"
#import "HJDMyNavTextFieldSearchView.h"
#import "HJDHomeRoomDiDaiManager.h"

@interface HJDHomeRoomSelectCell : UITableViewCell
@property(nonatomic, strong) UILabel *label;
@property(nonatomic, strong) UIView *lineView;
@end

@implementation HJDHomeRoomSelectCell

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textColor = kRGB_Color(0x66, 0x66, 0x66);
        _label.font = kFont15;
    }
    return _label;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kLineColor;
    }
    return _lineView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.lineView];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.right.equalTo(self.contentView).offset(-16);
            make.top.bottom.equalTo(self.contentView);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@1);
            make.left.right.bottom.equalTo(self.contentView);
        }];
    }
    return self;
}
@end

@interface HJDHomeRoomSelectViewController ()<UITableViewDelegate, UITableViewDataSource, HJDMyNavTextFieldSearchViewDelegate, UIScrollViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) HJDMyNavTextFieldSearchView *searchView;
@property(nonatomic, strong) NSURLSessionDataTask *httpTask;
@end

@implementation HJDHomeRoomSelectViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kSafeAreaTopHeight, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (HJDMyNavTextFieldSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[HJDMyNavTextFieldSearchView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, 44)];
        _searchView.delegate = self;
        _searchView.isHaveSureButton = NO;
        NSString *str = @"";
        switch (self.searchType) {
            case HJDRoomSearchCommunity:
                str = @"请输入小区名称";
                break;
            case HJDRoomSearchBuilding:
                str = @"请输入楼栋名称";
                break;
            case HJDRoomSearchUnit:
                str = @"请输入单元名称";
                break;
            default:
                str = @"请输入门牌号";
                break;
        }
        _searchView.placeholderStr = str;
    }
    return _searchView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.searchType = HJDRoomSearchCommunity;
        self.dataSource = [NSMutableArray array];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self showNavigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.searchView];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    view.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    self.tableView.tableHeaderView = view;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.callback) {
        self.callback(self.dataSource[indexPath.row]);
    }
    [self goBack:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HJDHomeRoomSelectCell";
    HJDHomeRoomSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[HJDHomeRoomSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic = self.dataSource[indexPath.row];
    NSString *str = @"";
    switch (self.searchType) {
        case HJDRoomSearchCommunity:
            str = dic[@"communityName"];
            break;
        case HJDRoomSearchBuilding:
            str = dic[@"buildingName"];
            break;
        case HJDRoomSearchUnit:
            str = dic[@"buildingName"];
            break;
        default:
            str = dic[@"houseNo"];
            break;
    }
    cell.label.text = str;
    return cell;
}

#pragma mark - HJDMyNavTextFieldSearchViewDelegate
- (void)searchView:(HJDMyNavTextFieldSearchView *)searchView backButton:(id)sender {
    [self goBack:sender];
}

- (void)searchView:(HJDMyNavTextFieldSearchView *)searchView clearButton:(id)sender {
    [self.dataSource removeAllObjects];
    [self.tableView reloadData];
}

- (void)searchView:(HJDMyNavTextFieldSearchView *)searchView keyWord:(NSString *)keyWord sureButton:(id)sender {
    [self hideHttpResultView];
    switch (self.searchType) {
        case HJDRoomSearchCommunity: {
            if (self.httpTask != nil) {
                [self.httpTask cancel];
            }
            self.httpTask = [HJDHomeRoomDiDaiManager getXiaoquListWithShiId:self.diDaiModel.cityId quId:self.diDaiModel.districtId keyWord:keyWord CallBack:^(NSArray *data, BOOL result) {
                if (result) {
                    if (data.count == 0) {
                        [self showNodataViewFrame:CGRectMake(0, kSafeAreaTopHeight, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight)];
                    } else {
                        [self.dataSource removeAllObjects];
                        [self.dataSource addObjectsFromArray:data];
                        [self.tableView reloadData];
                    }
                } else {
                }
            }];
            break;
        }
        case HJDRoomSearchBuilding: {
            if (self.httpTask != nil) {
                [self.httpTask cancel];
            }
            self.httpTask = [HJDHomeRoomDiDaiManager getLouDongListWithModel:self.diDaiModel keyWord:keyWord CallBack:^(NSArray *data, BOOL result) {
                if (result) {
                    if (data.count == 0) {
                        [self showNodataViewFrame:CGRectMake(0, kSafeAreaTopHeight, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight)];
                    } else {
                        [self.dataSource removeAllObjects];
                        [self.dataSource addObjectsFromArray:data];
                        [self.tableView reloadData];
                    }
                } else {
                }
            }];
            break;
        }
        case HJDRoomSearchUnit: {
            if (self.httpTask != nil) {
                [self.httpTask cancel];
            }
            self.httpTask = [HJDHomeRoomDiDaiManager getDanYuanListWithModel:self.diDaiModel keyWord:keyWord CallBack:^(NSArray *data, BOOL result) {
                if (result) {
                    if (data.count == 0) {
                        [self showNodataViewFrame:CGRectMake(0, kSafeAreaTopHeight, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight)];
                    } else {
                        [self.dataSource removeAllObjects];
                        [self.dataSource addObjectsFromArray:data];
                        [self.tableView reloadData];
                    }
                } else {
                }
            }];
            break;
        }
        case HJDRoomSearchHouse: {
            if (self.httpTask != nil) {
                [self.httpTask cancel];
            }
            self.httpTask = [HJDHomeRoomDiDaiManager getMenPaiListWithModel:self.diDaiModel keyWord:keyWord CallBack:^(NSArray *data, BOOL result) {
                if (result) {
                    if (data.count == 0) {
                        [self showNodataViewFrame:CGRectMake(0, kSafeAreaTopHeight, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight)];
                    } else {
                        [self.dataSource removeAllObjects];
                        [self.dataSource addObjectsFromArray:data];
                        [self.tableView reloadData];
                    }
                } else {
                }
            }];
            break;
        }
        default:
            
            break;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
@end
