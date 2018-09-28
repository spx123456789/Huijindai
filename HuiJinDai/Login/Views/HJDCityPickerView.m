//
//  HJDCityPickerView.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/8/31.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDCityPickerView.h"
#import "HJDRegisterHttpManager.h"

@interface HJDCityPickerView()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *selectLabel;
@property(nonatomic, strong) UILabel *cityLabel;
@property(nonatomic, strong) UIView *line1;
@property(nonatomic, strong) UIView *color_line;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *oneDataSource;
@property(nonatomic, strong) NSMutableArray *twoDataSource;
@property(nonatomic, assign) NSInteger selectIndex;
@property(nonatomic, assign) BOOL isSelectFirst;
@end

@implementation HJDCityPickerView

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

- (UILabel *)cityLabel {
    if (!_cityLabel) {
        _cityLabel = [[UILabel alloc] init];
        _cityLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _cityLabel.font = kFont15;
    }
    return _cityLabel;
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

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _isSelectFirst = NO;
        
        self.backgroundColor = kRGBA_Color(0x00, 0x00, 0x00, 0.4);
        
        self.oneDataSource = [NSMutableArray array];
        self.twoDataSource = [NSMutableArray array];
        
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.cityLabel];
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
        
        [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.line1.mas_bottom);
            make.left.equalTo(self.bgView).offset(16);
            make.height.equalTo(@44);
            make.width.equalTo(@50);
        }];
        
        [self.selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.line1.mas_bottom);
            make.left.equalTo(self.cityLabel.mas_right).offset(36);
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
    if (self.isSelectFirst) {
        self.cityLabel.hidden = NO;
        
        [self.selectLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.line1.mas_bottom);
            make.left.equalTo(self.cityLabel.mas_right).offset(36);
            make.height.equalTo(@44);
            make.width.equalTo(@50);
        }];
    } else {
        self.cityLabel.hidden = YES;
        
        [self.selectLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.line1.mas_bottom);
            make.left.equalTo(self.bgView).offset(16);
            make.height.equalTo(@44);
            make.width.equalTo(@50);
        }];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isSelectFirst) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:didSelectedCity:)]) {
            HJDCityModel *cityModel = self.twoDataSource[indexPath.row];
            [self.delegate pickerView:self didSelectedCity:cityModel];
            [self removeFromSuperview];
        }
    } else {
        self.isSelectFirst = YES;
        HJDCityModel *cityModel = self.oneDataSource[indexPath.row];
        self.cityLabel.text = cityModel.name;
        [self resetConstraints];
        [self getSecondLevelCityWithID:cityModel.pid];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 47.f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isSelectFirst) {
        return self.twoDataSource.count;
    } else {
        return self.oneDataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    HJDCityModel *cityModel = nil;
    if (self.isSelectFirst) {
        cityModel = self.twoDataSource[indexPath.row];
    } else {
        cityModel = self.oneDataSource[indexPath.row];
    }
    cell.textLabel.text = cityModel.name;
    return cell;
}

#pragma mark - 城市数据网络请求
- (void)getFirstLevelCityList {
    [HJDRegisterHttpManager getCityListWithCodeId:@"0" CallBack:^(NSDictionary *data, NSError *error, BOOL result) {
        NSArray *cityArray = [data getObjectByPath:@"data/list"];
        for (int k = 0; k < cityArray.count; k++) {
            NSDictionary *dic = cityArray[k];
            HJDCityModel *city = [[HJDCityModel alloc] init];
            [city hjd_loadDataFromkeyValues:dic];
            [self.oneDataSource addObject:city];
        }
        [self.tableView reloadData];
    }];
}

- (void)getSecondLevelCityWithID:(NSString *)cityId {
    [HJDRegisterHttpManager getCityListWithCodeId:cityId CallBack:^(NSDictionary *data, NSError *error, BOOL result) {
        NSArray *cityArray = [data getObjectByPath:@"data/list"];
        [self.twoDataSource removeAllObjects];
        for (int k = 0; k < cityArray.count; k++) {
            NSDictionary *dic = cityArray[k];
            HJDCityModel *city = [[HJDCityModel alloc] init];
            [city hjd_loadDataFromkeyValues:dic];
            [self.twoDataSource addObject:city];
        }
        [self.tableView reloadData];
    }];
}
@end
