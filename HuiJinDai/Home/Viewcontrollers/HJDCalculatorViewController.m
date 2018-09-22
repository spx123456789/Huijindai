//
//  HJDCalculatorViewController.m
//  HuiJinDai
//
//  Created by SHANPX on 2018/9/9.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDCalculatorViewController.h"
#import <TPKeyboardAvoidingTableView.h>
#import "HJDCalculatorTableViewCell.h"

@interface HJDCalculatorViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;
@end

@implementation HJDCalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTitle:@"还款计算器"];
    [self.view addSubview:self.tableView];
    [self setExtraCellLineHidden:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSString * placeHoderStr = @"";
    switch (indexPath.row) {
        case 0: {
            cell.titleLabel.text = @"借款金额";
            placeHoderStr = @"请填写";
            cell.textField.userInteractionEnabled = YES;
            cell.moreImageView.hidden = YES;
            cell.subLabel.text = @"元";
            cell.subLabel.hidden = NO;
            break;
        }
        case 1: {
            cell.titleLabel.text = @"申请期限";
            placeHoderStr = @"请填写";
            cell.textField.userInteractionEnabled = YES;
            cell.moreImageView.hidden = YES;
            cell.subLabel.text = @"月";
            cell.subLabel.hidden = NO;
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
    switch (indexPath.row) {
        case 0:
        {
            
            break;
        }
        case 1:
        {
            
            break;
        }
        case 2:
        {
            
            break;
        }
        case 3:
        {
            
            break;
        }
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}


- (TPKeyboardAvoidingTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
