//
//  HJDHomeCalculatorViewController.m
//  HuiJinDai
//
//  Created by SHANPX on 2018/9/9.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeCalculatorViewController.h"
#import <TPKeyboardAvoidingTableView.h>
#import "HJDCalculatorTableViewCell.h"
#import "HJDHomeCalculatorResultViewController.h"
#import "HJDHomeManager.h"
#import "HJDHomeDatePickerView.h"

@interface HJDHomeCalculatorViewController ()<UITableViewDelegate, UITableViewDataSource, HJDHomeDatePickerViewDelegate>
@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;
@property(nonatomic, strong) UIView *bottomView;
@property(nonatomic, strong) HJDHomeCalculatorModel *calculatorModel;

@end

@implementation HJDHomeCalculatorViewController

- (TPKeyboardAvoidingTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44 + 32)];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(16, 32, kScreenWidth - 16 * 2, 44);
        [btn setBackgroundColor:kMainColor];
        [btn setTitle:@"开始计算" forState:UIControlStateNormal];
        [btn setTitleColor:kRGB_Color(0xff, 0xff, 0xff) forState:UIControlStateNormal];
        btn.titleLabel.font = kFont15;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 4.f;
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:btn];
    }
    return _bottomView;
}

- (void)buttonClick:(id)sender {
    if ([NSString hjd_isBlankString:self.calculatorModel.money]) {
        [self showToast:@"请填写借款金额"];
        return;
    }
    
    if ([NSString hjd_isBlankString:self.calculatorModel.month]) {
        [self showToast:@"请填写申请期限"];
        return;
    }
    
    if ([NSString hjd_isBlankString:self.calculatorModel.start_date]) {
        [self showToast:@"请选择放款日期"];
        return;
    }
    
    @weakify(self);
    [MBProgressHUD showMessage:@"开始计算..."];
    [HJDHomeManager getJiSuanResultWithStartTime:self.calculatorModel.start_date month:self.calculatorModel.month money:self.calculatorModel.money callBack:^(NSDictionary *dataDic, BOOL result) {
        @strongify(self);
        [MBProgressHUD hideHUD];
        if (result) {
            HJDHomeCalculatorResultViewController *controller = [[HJDHomeCalculatorResultViewController alloc] init];
            self.calculatorModel.lilv = dataDic[@"lilv"];
            self.calculatorModel.lixi = dataDic[@"lixi"];
            controller.resultModel = self.calculatorModel;
            [self.navigationController pushViewController:controller animated:YES];
        } else {
            [MBProgressHUD showError:@"计算失败"];
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTitle:@"还款计算器"];
    [self.view addSubview:self.tableView];
    [self setExtraCellLineHidden:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(42);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    self.tableView.tableFooterView = self.bottomView;
    
    self.calculatorModel = [[HJDHomeCalculatorModel alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadEndTime {
    if ([NSString hjd_isBlankString:self.calculatorModel.month]) {
        return;
    }
    
    if ([NSString hjd_isBlankString:self.calculatorModel.start_date]) {
        return;
    }
    
    NSInteger loan_month = self.calculatorModel.month.integerValue;
    
    NSInteger year = loan_month/12;
    NSInteger month = loan_month % 12;
    
    NSArray *dateArray = [self.calculatorModel.start_date componentsSeparatedByString:@"-"];
    
    NSInteger newDay = [dateArray.lastObject integerValue] - 1;

    NSInteger newMonth = [dateArray[1] integerValue] + month;
    
    NSInteger newYear = [dateArray.firstObject integerValue] + year;
    if (newMonth > 12) {
        newMonth = newMonth - 12;
        newYear += 1;
    }
    
    NSString *newDate = [NSString stringWithFormat:@"%02ld-%02ld-%02ld", (long)newYear, (long)newMonth, (long)newDay];
    
    self.calculatorModel.end_date = newDate;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    HJDCalculatorTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.textField.text = newDate;

}

#pragma mark - HJDHomeDatePickerViewDelegate
- (void)datePickerView:(HJDHomeDatePickerView *)datePickerView selectTime:(NSString *)selectTime {
    self.calculatorModel.start_date = selectTime;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    HJDCalculatorTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.textField.text = selectTime;
    [self reloadEndTime];
}

#pragma mark - UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    HJDCalculatorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[HJDCalculatorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *placeHoderStr = @"";
    switch (indexPath.row) {
        case 0: {
            cell.titleLabel.text = @"借款金额";
            placeHoderStr = @"请填写";
            cell.textField.userInteractionEnabled = YES;
            cell.moreImageView.hidden = YES;
            cell.subLabel.text = @"元";
            cell.subLabel.hidden = NO;
            cell.textField.keyboardType = UIKeyboardTypePhonePad;
            [cell.textField.rac_textSignal subscribeNext:^(NSString *x) {
                if ([x isNumber]) {
                    self.calculatorModel.money = x;
                } else {
                    cell.textField.text = self.calculatorModel.money;
                }
            }];
            break;
        }
        case 1: {
            cell.titleLabel.text = @"申请期限";
            placeHoderStr = @"请填写";
            cell.textField.userInteractionEnabled = YES;
            cell.moreImageView.hidden = YES;
            cell.subLabel.text = @"月";
            cell.subLabel.hidden = NO;
            cell.textField.keyboardType = UIKeyboardTypePhonePad;
            [cell.textField.rac_textSignal subscribeNext:^(NSString *x) {
                if ([x isNumber]) {
                    self.calculatorModel.month = x;
                    [self reloadEndTime];
                } else {
                    cell.textField.text = self.calculatorModel.month;
                }
            }];
            break;
        }
        case 2: {
            cell.titleLabel.text = @"放款日期";
            placeHoderStr = @"请选择";
            cell.textField.userInteractionEnabled = NO;
            cell.moreImageView.hidden = NO;
            cell.subLabel.hidden = YES;
            break;
        }
        case 3: {
            cell.titleLabel.text = @"到期日期";
            placeHoderStr = @"请选择";
            cell.textField.userInteractionEnabled = NO;
            cell.moreImageView.hidden = NO;
            cell.subLabel.hidden = YES;
            break;
        }
        default:
            break;
    }
    NSDictionary *attributes = @{NSForegroundColorAttributeName: HMRGBHex(@"D4D4D4")};
    NSAttributedString *placeholderAttr = [[NSAttributedString alloc] initWithString:placeHoderStr attributes: attributes];

    cell.textField.attributedPlaceholder = placeholderAttr;

    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        HJDHomeDatePickerView *picker = [[HJDHomeDatePickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - 180, kScreenWidth, 180)];
        picker.delegate = self;
        [self.view addSubview:picker];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
@end
