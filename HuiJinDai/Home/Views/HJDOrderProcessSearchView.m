//
//  HJDOrderProcessSearchView.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/22.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDOrderProcessSearchView.h"

@interface HJDPopView : UIView<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *dataSource;
@property(nonatomic, strong) NSIndexPath *selectIndexPath;

- (void)show;
@end

@implementation HJDPopView
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
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
        self.selectIndexPath = nil;
        self.dataSource = @[ @"全部", @"客户经理审核中", @"风控分配中", @"审核岗处理中", @"合同/公证/抵押岗处理中", @"放款审核处理中", @"待放款" ];
        
        CGFloat view_width = 170;
        CGFloat view_height = 162 + 28 * 2;
        //imageView的superView
        UIView *fangkuanView1 = [[UIView alloc] initWithFrame:CGRectMake(16, 64 + 44, view_width, view_height)];
        //imageView的superView 的阴影view
        UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view_width, view_height)];//这里的大小将不影响fangkuanView1 的显示（即这里只起 设置frame.origin的作用）
        
        self.tableView.frame = CGRectMake(0, 11, view_width, view_height - 11 * 2);
        //阴影设置
        shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
        shadowView.layer.shadowOffset = CGSizeMake(4, 4);
        shadowView.layer.shadowOpacity = 0.5;
        shadowView.layer.shadowRadius = 4.0;
        shadowView.layer.cornerRadius = 8.f;
        
        //superView
        fangkuanView1.layer.masksToBounds = YES;
        fangkuanView1.layer.cornerRadius = 8.f;
        fangkuanView1.clipsToBounds = YES;
        fangkuanView1.backgroundColor = [UIColor whiteColor];
        
        [fangkuanView1 addSubview:self.tableView];
        [shadowView addSubview:fangkuanView1];
        [self addSubview:shadowView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapGesture:(id)sender {
    [self removeFromSuperview];
}

- (void)show {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectIndexPath != nil) {
        if (self.selectIndexPath == indexPath) {
            return;
        } else {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:self.selectIndexPath];
            cell.textLabel.textColor = kRGB_Color(0x66, 0x66, 0x66);
            self.selectIndexPath = indexPath;
        }
    } else {
        self.selectIndexPath = indexPath;
    }
    UITableViewCell *new_cell = [tableView cellForRowAtIndexPath:self.selectIndexPath];
    new_cell.textLabel.textColor = kMainColor;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 28;
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
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.font = kFont12;
    if (self.selectIndexPath != nil && self.selectIndexPath == indexPath) {
        cell.textLabel.textColor = kMainColor;
    } else {
        cell.textLabel.textColor = kRGB_Color(0x66, 0x66, 0x66);
    }
    return cell;
}
@end

#pragma mark - 搜索view
@interface HJDOrderProcessSearchView()
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIButton *selectButton;
@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) UIButton *sureButton;
@end

@implementation HJDOrderProcessSearchView

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 4.f;
    }
    return _bgView;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 12, 50, 12)];
        label.text = @"工单状态";
        label.font = kFont12;
        label.textColor = kRGB_Color(0x66, 0x66, 0x66);
        [_selectButton addSubview:label];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(66, 16, 6, 3)];
        imgView.image = kImage(@"订单进程搜索中的下拉箭头");
        [_selectButton addSubview:imgView];
    }
    return _selectButton;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _textField.font = kFont14;
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入房产地址/申请人姓名" attributes:@{ NSForegroundColorAttributeName : kRGB_Color(0xd4, 0xd4, 0xd4), NSFontAttributeName : kFont14 }];
        //_textField.delegate = self;
    }
    return _textField;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setBackgroundColor:[UIColor clearColor]];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        _sureButton.titleLabel.font = kFont15;
        [_sureButton setTitleColor:kRGB_Color(0x33, 0x33, 0x33) forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

- (void)sureButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(processSearchView:searchWord:)]) {
        [self.delegate processSearchView:self searchWord:self.textField.text];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWithe;
        self.selectIndex = 0;
        
        UIView *line1 = [self createLine];
        UIView *line2 = [self createLine];
        
        [self addSubview:self.bgView];
        
        [self.bgView addSubview:self.selectButton];
        [self.bgView addSubview:line1];
        [self.bgView addSubview:self.textField];
        [self.bgView addSubview:line2];
        [self.bgView addSubview:self.sureButton];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.right.equalTo(self).offset(-16);
            make.centerY.equalTo(self);
            make.height.equalTo(@36);
        }];
        
        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView);
            make.width.equalTo(@84);
            make.top.bottom.equalTo(self.bgView);
        }];
        
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@1);
            make.left.equalTo(self.selectButton.mas_right);
            make.top.bottom.equalTo(self.bgView);
        }];
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line1.mas_right).offset(12);
            make.right.equalTo(line2.mas_left).offset(-12);
            make.top.bottom.equalTo(self.bgView);
        }];
        
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@1);
            make.right.equalTo(self.sureButton.mas_left);
            make.top.bottom.equalTo(self.bgView);
        }];
        
        [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bgView);
            make.top.bottom.equalTo(self.bgView);
            make.width.equalTo(@53);
        }];
    }
    return self;
}

- (UIView *)createLine {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kRGB_Color(0xff, 0xff, 0xff);
    return view;
}

- (void)selectButtonClick:(id)sender {
    HJDPopView *pop = [[HJDPopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self.selectIndex == NSNotFound) {
        pop.selectIndexPath = nil;
    } else {
       pop.selectIndexPath = [NSIndexPath indexPathForRow:self.selectIndex inSection:0];
    }
    [pop show];
}

@end
