//
//  HJDHomeSelectToastView.m
//  HuiJinDai
//
//  Created by GXW on 2018/10/21.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeSelectToastView.h"

@interface HJDHomeSelectToastTableCell : UITableViewCell
@property(nonatomic, strong) UIView *leftView;
@property(nonatomic, strong) UILabel *leftLabel;
@property(nonatomic, strong) UIView *lineView;
@property(nonatomic, assign) BOOL isCellSelect;
@end

@implementation HJDHomeSelectToastTableCell
- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _leftLabel.font = kFont16;
    }
    return _leftLabel;
}

- (UIView *)leftView {
    if (!_leftView) {
        _leftView = [[UIView alloc] init];
        _leftView.backgroundColor = kMainColor;
        _leftView.layer.masksToBounds = YES;
        _leftView.layer.cornerRadius = 7.5f;
        _leftView.layer.borderWidth = 2.f;
        _leftView.layer.borderColor = [UIColor grayColor].CGColor;
    }
    return _leftView;
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
        [self.contentView addSubview:self.leftView];
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.lineView];
        
        @weakify(self);
        [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.equalTo(self.contentView).offset(12);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.equalTo(self.leftView.mas_right).offset(8);
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-12);
            make.height.equalTo(@18);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.contentView);
            make.height.equalTo(@1);
        }];
    }
    return self;
}

- (void)setIsCellSelect:(BOOL)isCellSelect {
    _isCellSelect = isCellSelect;
    self.leftView.backgroundColor = isCellSelect ? kMainColor : [UIColor clearColor];
}
@end

@interface HJDHomeSelectToastView()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIPickerView *pickerView;
@property(nonatomic, assign) CGRect gFrame;
@end

@implementation HJDHomeSelectToastView

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(12, self.gFrame.size.height/2 - 100, self.gFrame.size.width - 24, 200) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.cornerRadius = 5.f;
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _gFrame = frame;
        self.backgroundColor = kRGBA_Color(0x00, 0x00, 0x00, 0.4);
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)setSelectIndexPath:(NSIndexPath *)selectIndexPath {
    _selectIndexPath = selectIndexPath;
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    CGFloat height = dataSource.count * 45;
    self.tableView.frame = CGRectMake(12, self.gFrame.size.height/2 - height/2, self.gFrame.size.width - 24, height);
    [self.tableView reloadData];
}

- (void)showView {
    UIWindow *keyWindow = (UIWindow *)[UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectIndexPath != nil) {
        if (self.selectIndexPath == indexPath) {
            [self removeFromSuperview];
            return;
        } else {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:self.selectIndexPath];
            cell.textLabel.textColor = kRGB_Color(0x66, 0x66, 0x66);
            self.selectIndexPath = indexPath;
            if (self.delegate && [self.delegate respondsToSelector:@selector(selectToastView:didSelecIndex:)]) {
                [self.delegate selectToastView:self didSelecIndex:indexPath.row];
            }
        }
    } else {
        self.selectIndexPath = indexPath;
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectToastView:didSelecIndex:)]) {
            [self.delegate selectToastView:self didSelecIndex:indexPath.row];
        }
    }
    UITableViewCell *new_cell = [tableView cellForRowAtIndexPath:self.selectIndexPath];
    new_cell.textLabel.textColor = kMainColor;
    [self removeFromSuperview];
    self.selectIndexPath = indexPath;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HJDHomeSelectToastTableCell";
    HJDHomeSelectToastTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[HJDHomeSelectToastTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.leftLabel.text = self.dataSource[indexPath.row];
    if (indexPath.row == 0) {
        cell.lineView.hidden = YES;
    } else {
        cell.lineView.hidden = NO;
    }
    
    if (self.selectIndexPath != nil && self.selectIndexPath.row == indexPath.row) {
        cell.isCellSelect = YES;
    } else {
        cell.isCellSelect = NO;
    }
    return cell;
}
@end
