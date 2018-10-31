//
//  HJDHomeOrderApprovedView.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/17.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeOrderApprovedView.h"

@interface HJDHomeOrderApprovedTableCell : UITableViewCell
@property(nonatomic, strong) UIView *lineView;
@end

@implementation HJDHomeOrderApprovedTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kLineColor;
        [self.contentView addSubview:self.lineView];
        
        @weakify(self);
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.right.bottom.equalTo(self.contentView);
            make.height.equalTo(@1);
        }];
    }
    return self;
}

@end

@interface HJDHomeOrderApprovedView()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIButton *cancelButton;
@end

@implementation HJDHomeOrderApprovedView

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"请选择客户经理";
        _titleLabel.textColor = kMainColor;
        _titleLabel.font = kFont16;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = kWithe;
    }
    return _titleLabel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(12, 204, kScreenWidth - 12*2, 200) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.cornerRadius = 8.f;
    }
    return _tableView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(12, 404 + 15, kScreenWidth - 12*2, 44);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setBackgroundColor:kWithe];
        [_cancelButton setTitleColor:kRGB_Color(0x66, 0x66, 0x66) forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = kFont17;
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.cornerRadius = 8.f;
        [_cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (void)cancelButtonClick:(id)sender {
    [self removeFromSuperview];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kRGBA_Color(0x00, 0x00, 0x00, 0.4);
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39, kScreenWidth - 24, 1)];
        line.backgroundColor = kLineColor;
        [self.titleLabel addSubview:line];
        self.titleLabel.frame = CGRectMake(0, 0, kScreenWidth - 24, 40);
        
        self.tableView.tableHeaderView = self.titleLabel;
        
        [self addSubview:self.tableView];
        [self addSubview:self.cancelButton];
        self.tableView.bounces = NO;
    }
    return self;
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];
    
    NSInteger dataArrayCount = 5;
    if (dataSource.count < 5) {
        dataArrayCount = dataSource.count;
    }
    
    CGFloat newHeight = 44 * dataArrayCount + 40;
    CGRect btnFrame = self.cancelButton.frame;
    
    CGFloat totalHeight = newHeight + 15 + btnFrame.size.height;
    self.tableView.frame = CGRectMake(12, kScreenHeight/2 - totalHeight/2, kScreenWidth - 24, newHeight);
    self.cancelButton.frame = CGRectMake(btnFrame.origin.x, self.tableView.frame.origin.y + self.tableView.frame.size.height + 15, btnFrame.size.width, btnFrame.size.height);
}

- (void)showApprovedView {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.callBack) {
        self.callBack(self.dataSource[indexPath.row]);
    }
    [self removeFromSuperview];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"indentifier";
    HJDHomeOrderApprovedTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[HJDHomeOrderApprovedTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    HJDMyAgentModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.rename;
    cell.textLabel.font = kFont17;
    cell.textLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
    if (indexPath.row == self.dataSource.count - 1) {
        cell.lineView.hidden = YES;
    } else {
        cell.lineView.hidden = NO;
    }
    return cell;
}
@end
