//
//  HJDHomeRoomDiDaiPickerView.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeRoomDiDaiPickerView.h"
#import "HJDHomeRoomDiDaiManager.h"

typedef enum : NSUInteger {
    SelectFirstStep,
    SelectSecondStep,
    SelectThirdStep,
} kSelectStep;

@interface HJDHomeRoomDiDaiPickerView()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *selectLabel;
@property(nonatomic, strong) UILabel *shengLabel;
@property(nonatomic, strong) UILabel *shiLabel;
@property(nonatomic, strong) UIView *line1;
@property(nonatomic, strong) UIView *color_line;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, assign) kSelectStep selectStep;
@property(nonatomic, strong) HJDHomeRoomDiDaiModel *homeRoomModel;
@end

@implementation HJDHomeRoomDiDaiPickerView
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = kRGB_Color(0xff, 0xff, 0xff);
    }
    return _bgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"选择地区";
        _titleLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _titleLabel.font = kFont17;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)shengLabel {
    if (!_shengLabel) {
        _shengLabel = [[UILabel alloc] init];
        _shengLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _shengLabel.font = kFont15;
    }
    return _shengLabel;
}

- (UILabel *)shiLabel {
    if (!_shiLabel) {
        _shiLabel = [[UILabel alloc] init];
        _shiLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _shiLabel.font = kFont15;
    }
    return _shiLabel;
}

- (UILabel *)selectLabel {
    if (!_selectLabel) {
        _selectLabel = [[UILabel alloc] init];
        _selectLabel.text = @"请选择";
        _selectLabel.textColor = kMainColor;
        _selectLabel.font = kFont15;
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = kMainColor;
        [_selectLabel addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.selectLabel);
            make.height.equalTo(@2);
            
        }];
    }
    return _selectLabel;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 90, kScreenWidth, 290) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (void)setUpUI {
    self.backgroundColor = kRGBA_Color(0x00, 0x00, 0x00, 0.4);
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.shengLabel];
    [self.bgView addSubview:self.shiLabel];
    [self.bgView addSubview:self.selectLabel];
    [self.bgView addSubview:self.tableView];
    self.line1 = [self createLineViewColor:kLineColor];
    UIView *line2 = [self createLineViewColor:kLineColor];
    self.color_line = [self createLineViewColor:kMainColor];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.equalTo(@(90 + 290));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.bgView);
        make.height.equalTo(@44);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [self.shengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line1.mas_bottom);
        make.left.equalTo(self.bgView).offset(16);
        make.height.equalTo(@44);
        make.width.equalTo(@50);
    }];
    
    [self.shiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line1.mas_bottom);
        make.left.equalTo(self.shengLabel.mas_right).offset(36);
        make.height.equalTo(@44);
        make.width.equalTo(@50);
    }];
    
    [self.selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line1.mas_bottom);
        make.left.equalTo(self.shiLabel.mas_right).offset(36);
        make.height.equalTo(@44);
        make.width.equalTo(@50);
    }];
    
    [self.color_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.selectLabel);
        make.top.equalTo(self.selectLabel.mas_bottom).offset(-2);
        make.height.equalTo(@2);
    }];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bgView);
        make.top.equalTo(self.selectLabel.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [self resetConstraints];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.selectStep = SelectFirstStep;
        self.homeRoomModel = [[HJDHomeRoomDiDaiModel alloc] init];
        self.dataSource = [NSMutableArray array];
        
        [self setUpUI];
        
        [self getFirstLevelCityList];
    }
    return self;
}

- (UIView *)createLineViewColor:(UIColor *)color {
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = color;
    [self.bgView addSubview:line];
    return line;
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

- (void)resetConstraints {
    switch (self.selectStep) {
        case SelectFirstStep: {
            self.shengLabel.hidden = YES;
            self.shiLabel.hidden = YES;
    
            [self.selectLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.line1.mas_bottom);
                make.left.equalTo(self.bgView).offset(16);
                make.height.equalTo(@44);
                make.width.equalTo(@50);
            }];
            break;
        }
        case SelectSecondStep: {
            self.shengLabel.hidden = NO;
            self.shiLabel.hidden = YES;
            
            [self.selectLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.line1.mas_bottom);
                make.left.equalTo(self.shengLabel.mas_right).offset(36);
                make.height.equalTo(@44);
                make.width.equalTo(@50);
            }];
            break;
        }
        default: {
            self.shengLabel.hidden = NO;
            self.shiLabel.hidden = NO;
            
            [self.selectLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.line1.mas_bottom);
                make.left.equalTo(self.shiLabel.mas_right).offset(36);
                make.height.equalTo(@44);
                make.width.equalTo(@50);
            }];
            break;
        }
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.selectStep) {
        case SelectFirstStep: {
            self.selectStep = SelectSecondStep;
            NSDictionary *shengDic = self.dataSource[indexPath.row];
            NSString *locationId = shengDic[@"locationId"];
            NSString *locationName = shengDic[@"locationName"];
            self.shengLabel.text = locationName;
            [self resetConstraints];
            [self getSecondLevelCityWithID:locationId];
            self.homeRoomModel.provinceId = locationId;
            self.homeRoomModel.provinceName = locationName;
            break;
        }
        case SelectSecondStep: {
            self.selectStep = SelectThirdStep;
            NSDictionary *shiDic = self.dataSource[indexPath.row];
            NSString *locationId_1 = shiDic[@"locationId"];
            NSString *locationName_1 = shiDic[@"locationName"];
            self.shiLabel.text = locationName_1;
            [self resetConstraints];
            [self getThirdLevelCityWithID:self.homeRoomModel.provinceId shiId:locationId_1];
            self.homeRoomModel.cityId = locationId_1;
            self.homeRoomModel.cityName = locationName_1;
            break;
        }
        default: {
            if (self.delegate && [self.delegate respondsToSelector:@selector(roomDiDaiPickerView:didSelectedCity:)]) {
                NSDictionary *dictionary = self.dataSource[indexPath.row];
                self.homeRoomModel.districtId = dictionary[@"locationId"];
                self.homeRoomModel.districtName = dictionary[@"locationName"];
                [self.delegate roomDiDaiPickerView:self didSelectedCity:self.homeRoomModel];
                [self removeFromSuperview];
            }
            break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 47.f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *dic = self.dataSource[indexPath.row];
    cell.textLabel.text = dic[@"locationName"];
    return cell;
}

#pragma mark - 城市数据网络请求
- (void)getFirstLevelCityList {
    [HJDHomeRoomDiDaiManager getShengListCallBack:^(NSArray *data, BOOL result) {
        if (result) {
            [self.dataSource addObjectsFromArray:data];
            [self.tableView reloadData];
        }
    }];
}

- (void)getSecondLevelCityWithID:(NSString *)cityId {
    [HJDHomeRoomDiDaiManager getShiListWithShengId:cityId CallBack:^(NSArray *data, BOOL result) {
        if (result) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:data];
            [self.tableView reloadData];
        }
    }];
}

- (void)getThirdLevelCityWithID:(NSString *)shengId shiId:(NSString *)shiId {
    [HJDHomeRoomDiDaiManager getQuListWithShengId:shengId shiId:shiId CallBack:^(NSArray *data, BOOL result) {
        if (result) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:data];
            [self.tableView reloadData];
        }
    }];
}
@end
