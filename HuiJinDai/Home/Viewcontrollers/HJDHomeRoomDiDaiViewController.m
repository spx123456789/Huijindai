//
//  HJDHomeRoomDiDaiViewController.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/24.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeRoomDiDaiViewController.h"
#import "HJDMessageSegmentView.h"
#import "HJDHomeRoomDiDaiTableViewCell.h"
#import "HJDHomeCalculatorResultTableCell.h"
#import "HJDHomeQueryValueDetailViewController.h"
#import "HJDHomeQueryValueResultViewController.h"
#import "HJDCustomerServiceView.h"
#import "HJDHomeRoomSelectViewController.h"
#import "HJDHomeRoomDiDaiPickerView.h"
#import "HJDHomeRoomDiDaiManager.h"
#import "HJDHomeSelectPickerView.h"

typedef enum : NSUInteger {
    HJDRomeQueryValue = 0,  //极速询值
    HJDRomeQueryRecord      //询值记录
} HJDRomeDiDaiType;

@interface HJDHomeRoomDiDaiViewController ()<UITableViewDelegate, UITableViewDataSource, HJDMessageSegmentViewDelegate, HJDHomeRoomDiDaiPickerViewDelegate, HJDHomeSelectPickerViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) HJDMessageSegmentView *segmentView;
@property(nonatomic, assign) HJDRomeDiDaiType selectType;
@property(nonatomic, strong) UIButton *queryValueButton;
@property(nonatomic, strong) HJDCustomerServiceView *customServiceView;
@property(nonatomic, strong) HJDHomeRoomDiDaiModel *roomModel;
@property(nonatomic, strong) HJDHomeRoomDiDaiPickerView *cityPickerView;
@property(nonatomic, assign) NSInteger diDaiPage;
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

- (HJDHomeRoomDiDaiPickerView *)cityPickerView {
    if (!_cityPickerView) {
        _cityPickerView = [[HJDHomeRoomDiDaiPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _cityPickerView.delegate = self;
    }
    return _cityPickerView;
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
    self.roomModel.companyStr = @"01,02,03";
    /*
     houseId    string
     房间 Id
     
     houseNo    string
     门牌号，如：1702
     
     companyStr    string
     询值类型， 01-世联,02-仁达,03-首佳
     */
    if ([NSString hjd_isBlankString:self.roomModel.provinceId]) {
        [self showToast:@"请选择城市"];
        return;
    }
    
    if ([NSString hjd_isBlankString:self.roomModel.communityId]) {
        [self showToast:@"请选择小区名称"];
        return;
    }
    
    if ([NSString hjd_isBlankString:self.roomModel.buildingUnitId]) {
        [self showToast:@"请选择楼栋名称"];
        return;
    }
    //单元门  门牌号
    
    if ([NSString hjd_isBlankString:self.roomModel.houseSpace]) {
        [self showToast:@"请填写建筑面积"];
        return;
    }
    
    [MBProgressHUD showMessage:@"正在询值..."];
    [HJDHomeRoomDiDaiManager postRoomEvaluateWithModel:self.roomModel callBack:^(NSDictionary *dataDic, BOOL result) {
        [MBProgressHUD hideHUD];
        if (result) {
            HJDHomeQueryValueResultViewController *controller = [[HJDHomeQueryValueResultViewController alloc] init];
            controller.resultDic = [NSDictionary dictionaryWithDictionary:dataDic];
            [self.navigationController pushViewController:controller animated:YES];
        } else {
            if (dataDic) {
                [MBProgressHUD showError:@"用户询值次数已达上限"];
            } else {
                [MBProgressHUD showError:@"询值失败"];
            }
        }
    }];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.selectType = HJDRomeQueryValue;
        self.roomModel = [[HJDHomeRoomDiDaiModel alloc] init];
        self.dataSource = [NSMutableArray array];
        self.diDaiPage = 1;
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
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:@[ @"", @"", @"", @"", @"", @"", @"" ]];
        
        self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - 60);
        [self.view addSubview:self.tableView];
        [self.view addSubview:self.customServiceView];
        self.customServiceView.hidden = NO;
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44 + 20)];
        [footerView addSubview:self.queryValueButton];
        self.tableView.tableFooterView = footerView;
        
        self.tableView.mj_footer = nil;
    } else {
        self.tableView.frame = CGRectMake(0, 4, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - 4);
        [self.view addSubview:self.tableView];
        self.customServiceView.hidden = YES;
        self.tableView.tableFooterView = nil;
        
        @weakify(self);
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            [self loadMoreData];
        }];
    }
}

- (void)loadMoreData {
    @weakify(self);
    [MBProgressHUD showMessage:@"正在加载..."];
    [HJDHomeRoomDiDaiManager getRoomEvaluateListWithPage:self.diDaiPage callBack:^(NSArray *data, BOOL result) {
        @strongify(self);
        [MBProgressHUD hideHUD];
        [self.tableView.mj_footer endRefreshing];
        if (result) {
            [self.dataSource addObjectsFromArray:data];
            [self.tableView reloadData];
            if (data.count == 0 || data.count < kHJDHttpRow) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            self.diDaiPage++;
        } else {
            [MBProgressHUD showError:@"加载失败"];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HJDHomeSelectPickerViewDelegate
- (void)selectPickerView:(HJDHomeSelectPickerView *)selectPickerView didSelecIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
    HJDHomeRoomDiDaiTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSArray *arr = @[ @"住宅", @"别墅" ];
    cell.textField.text = arr[index];
    self.roomModel.planning = index + 1;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectType == HJDRomeQueryValue) {
        [self roomDiDaiCellSelectIndexPath:indexPath];
    } else {
        NSDictionary *dic = self.dataSource[indexPath.row];
        NSString *status = [NSString stringWithFormat:@"%@", dic[@"request"]];
        HJDHomeQueryValueDetailViewController *statusController = [[HJDHomeQueryValueDetailViewController alloc] init];
        statusController.xun_id = dic[@"x_id"];
        if ([status isEqualToString:@"true"]) {
            statusController.isSuccess = YES;
        } else {
            statusController.isSuccess = NO;
        }
        [self.navigationController pushViewController:statusController animated:YES];
    }
}

- (void)roomDiDaiCellSelectIndexPath:(NSIndexPath *)indexPath {
    HJDHomeRoomDiDaiTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    switch (indexPath.row) {
        case 0: { //城市
            [self.cityPickerView show];
            break;
        }
        case 1: { //小区名称
            if ([NSString hjd_isBlankString:self.roomModel.districtId]) {
                [self showToast:@"请先选择城市"];
                return;
            }
            HJDHomeRoomSelectViewController *controller = [[HJDHomeRoomSelectViewController alloc] init];
            controller.diDaiModel = self.roomModel;
            controller.searchType = HJDRoomSearchCommunity;
            controller.callback = ^(NSDictionary *dic) {
                self.roomModel.communityId = dic[@"communityId"];
                self.roomModel.communityName = dic[@"communityName"];
                self.roomModel.communityCompany = dic[@"company"];
                self.roomModel.address = dic[@"address"];
                cell.textField.text = dic[@"communityName"];
            };
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        case 2: { //楼栋名称
            if ([NSString hjd_isBlankString:self.roomModel.communityId]) {
                [self showToast:@"请先选择小区名称"];
                return;
            }
            HJDHomeRoomSelectViewController *controller = [[HJDHomeRoomSelectViewController alloc] init];
            controller.diDaiModel = self.roomModel;
            controller.searchType = HJDRoomSearchBuilding;
            controller.callback = ^(NSDictionary *dic) {
                self.roomModel.buildingUnitId = dic[@"buildingId"];
                self.roomModel.buildingUnitName = dic[@"buildingName"];
                self.roomModel.buildingCompany = dic[@"company"];
                cell.textField.text = dic[@"buildingName"];
            };
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        case 3: { //单元门
            if ([NSString hjd_isBlankString:self.roomModel.buildingUnitId]) {
                [self showToast:@"请先选择楼栋名称"];
                return;
            }
            HJDHomeRoomSelectViewController *controller = [[HJDHomeRoomSelectViewController alloc] init];
            controller.diDaiModel = self.roomModel;
            controller.searchType = HJDRoomSearchUnit;
            controller.callback = ^(NSDictionary *dic) {
                self.roomModel.buildingUnitId = dic[@"buildingId"];
                self.roomModel.buildingUnitName = dic[@"buildingName"];
                self.roomModel.buildingCompany = dic[@"company"];
                cell.textField.text = dic[@"buildingName"];
            };
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        case 4: { //门牌号
            if ([NSString hjd_isBlankString:self.roomModel.houseId]) {
                [self showToast:@"请先选择单元"];
                return;
            }
            HJDHomeRoomSelectViewController *controller = [[HJDHomeRoomSelectViewController alloc] init];
            controller.diDaiModel = self.roomModel;
            controller.searchType = HJDRoomSearchHouse;
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        case 5: { //规划用途
            HJDHomeSelectPickerView *picker = [[HJDHomeSelectPickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - 180, kScreenWidth, 180)];
            picker.delegate = self;
            picker.dataSource = @[ @"住宅", @"别墅" ];
            [self.view addSubview:picker];
            break;
        }
        case 6: {
            return;
            break;
        }
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.selectType) {
        case HJDRomeQueryValue: {
            if (indexPath.row == 0 || indexPath.row == 5) {
                return 44 + 4;
            } else {
                return 44;
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
            NSDictionary *dic = self.dataSource[indexPath.row];
            cell.titleLabel.text = [NSString stringWithFormat:@"询值编号：%@", dic[@"no"]];
            cell.firstLabel.text = @"询值时间";
            cell.twoLabel.text = @"房产地址";
            cell.firstLabel_1.text = dic[@"ad_time"];
            cell.twoLabel_1.text = dic[@"addr"];
            [cell setCellOfNumber:2];
            cell.statusLabel.hidden = NO;
            cell.nextImgView.hidden = NO;
            
            NSString *status = [NSString stringWithFormat:@"%@", dic[@"request"]];
            if ([status isEqualToString:@"true"]) {
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
            cell.fieldCanEdit = NO;
            break;
        }
        case 1: {
            cell.leftLabel.text = @"小区名称";
            cell.placeholderString = @"请选择";
            cell.rightImgView.hidden = NO;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = NO;
            cell.fieldCanEdit = NO;
            break;
        }
        case 2: {
            cell.leftLabel.text = @"楼栋名称";
            cell.placeholderString = @"请选择";
            cell.rightImgView.hidden = NO;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = NO;
            cell.fieldCanEdit = NO;
            break;
        }
        case 3: {
            cell.leftLabel.text = @"单元门";
            cell.placeholderString = @"请选择";
            cell.rightImgView.hidden = NO;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = NO;
            cell.fieldCanEdit = NO;
            break;
        }
        case 4: {
            cell.leftLabel.text = @"门牌号";
            cell.placeholderString = @"请选择";
            cell.rightImgView.hidden = NO;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = YES;
            cell.fieldCanEdit = NO;
            break;
        }
        case 5: {
            cell.leftLabel.text = @"规划用途";
            cell.placeholderString = @"请选择";
            cell.rightImgView.hidden = NO;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = NO;
            cell.fieldCanEdit = NO;
            break;
        }
        case 6: {
            cell.leftLabel.text = @"建筑面积";
            cell.placeholderString = @"请填写建筑面积";
            cell.rightImgView.hidden = YES;
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text = @"m²";
            cell.lineView.hidden = YES;
            @weakify(self);
            [cell.textField.rac_textSignal subscribeNext:^(NSString *x) {
                @strongify(self);
                self.roomModel.houseSpace = x;
            }];
            break;
        }
        default:
            break;
    }
}

#pragma mark - HJDMessageSegmentViewDelegate
- (void)segmentView:(HJDMessageSegmentView *)segmentView didSelectMessageType:(HJDMessageType)type {
    self.selectType = (NSUInteger)type;
    
    if (self.selectType == HJDRomeQueryRecord) {
        [self reloadView];
        [self.dataSource removeAllObjects];
        [self.tableView reloadData];
        //请求数据
        self.diDaiPage = 1;
        [self loadMoreData];
    } else {
        //刷新数据
        [self reloadView];
        [self.tableView reloadData];
    }
}

#pragma mark - HJDHomeRoomDiDaiPickerViewDelegate
- (void)roomDiDaiPickerView:(HJDHomeRoomDiDaiPickerView *)pickerView didSelectedCity:(HJDHomeRoomDiDaiModel *)cityModel {
    self.roomModel = cityModel;
    HJDHomeRoomDiDaiTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.textField.text = [NSString stringWithFormat:@"%@ %@ %@", cityModel.provinceName, cityModel.cityName, cityModel.districtName];
    self.cityPickerView = nil;
}


#pragma mark - dealloc
- (void)dealloc {
    NSLog(@"%@ dealloc", [self class]);
}
@end
