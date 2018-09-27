//
//  HJDHomeDeclarationViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/27.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeDeclarationViewController.h"
#import "HJDHomeRoomDiDaiTableViewCell.h"
#import "HJDCustomerServiceView.h"

@interface HJDHomeDeclarationViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) HJDCustomerServiceView *customServiceView;
@property(nonatomic, strong) UIButton *submitButton;
@end

@implementation HJDHomeDeclarationViewController

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

- (HJDCustomerServiceView *)customServiceView {
    if (!_customServiceView) {
        _customServiceView = [[HJDCustomerServiceView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 70, 0, 140, 30)];
        _customServiceView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    }
    return _customServiceView;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitButton setTitleColor:kRGB_Color(0xff, 0xff, 0xff) forState:UIControlStateNormal];
        [_submitButton setBackgroundColor:kMainColor];
        _submitButton.titleLabel.font = kFont15;
        _submitButton.layer.masksToBounds = YES;
        _submitButton.layer.cornerRadius = 4.f;
        [_submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

- (void)submitButtonClick:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTitle:@"报单"];
    self.view.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    
    [self.view addSubview:self.tableView];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60 + 44 + 25)];
    
    self.submitButton.frame = CGRectMake(16, 20, kScreenWidth - 32, 44);
    [footerView addSubview:self.submitButton];
    
    self.customServiceView.frame = CGRectMake(kScreenWidth/2 - 70, 40 + 44, 140, 25);
    [footerView addSubview:self.customServiceView];
    
    self.tableView.tableFooterView = footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        case 1:
        case 5:
            return 44 + 4;
            break;
        case 2:
        case 3:
        case 4:
        case 6:
        case 7:
        case 8:
        case 9:
            return 44;
            break;
        default:
            return 4 + 44 + 1 + 16 + kPhotoHeight + 16;
            break;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10 + 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HJDHomeRoomDiDaiTableViewCell";
    static NSString *cellPhotoIdentifier = @"HJDHomeRoomDiDaiPhotoTableViewCell";
    
    if (indexPath.row < 10) {
        HJDHomeRoomDiDaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[HJDHomeRoomDiDaiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [self setCellValue:cell indexPath:indexPath];
        return cell;
    } else {
        HJDHomeRoomDiDaiPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellPhotoIdentifier];
        if (cell == nil) {
            cell = [[HJDHomeRoomDiDaiPhotoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellPhotoIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        switch (indexPath.row) {
            case 10: {
                cell.title = @"借款人身份证";
                [cell addCellImageWithImageArray:@[ @"添加证件", @"添加证件" ]];
                break;
            }
            case 11: {
                cell.title = @"借款人户口本";
                [cell addCellImageWithImageArray:@[ @"添加证件", @"添加证件" ]];
                break;
            }
            case 12: {
                cell.title = @"借款人征信报告";
                [cell addCellImageWithImageArray:@[ @"添加证件"]];
                break;
            }
            case 13: {
                cell.title = @"借款人婚姻证明";
                [cell addCellImageWithImageArray:@[ @"添加证件" ]];
                break;
            }
            case 14: {
                cell.title = @"房产证";
                [cell addCellImageWithImageArray:@[ @"添加证件", @"添加证件" ]];
                break;
            }
            default:
                break;
        }
        return cell;
    }
    
}

- (void)setCellValue:(HJDHomeRoomDiDaiTableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            cell.leftLabel.text = @"贷款品种";
            cell.placeholderString = @"请选择";
            cell.rightImgView.hidden = NO;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = YES;
            break;
        }
        case 1: {
            cell.leftLabel.text = @"客户名称";
            cell.placeholderString = @"请填写";
            cell.rightImgView.hidden = YES;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = NO;
            break;
        }
        case 2: {
            cell.leftLabel.text = @"证件类型";
            cell.placeholderString = @"请选择";
            cell.rightImgView.hidden = NO;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = NO;
            break;
        }
        case 3: {
            cell.leftLabel.text = @"证件号码";
            cell.placeholderString = @"请填写";
            cell.rightImgView.hidden = YES;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = NO;
            break;
        }
        case 4: {
            cell.leftLabel.text = @"婚姻状况";
            cell.placeholderString = @"请选择";
            cell.rightImgView.hidden = NO;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = YES;
            break;
        }
        case 5: {
            cell.leftLabel.text = @"申请金额";
            cell.placeholderString = @"请填写";
            cell.rightImgView.hidden = YES;
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text = @"元";
            cell.lineView.hidden = NO;
            break;
        }
        case 6: {
            cell.leftLabel.text = @"申请期限";
            cell.placeholderString = @"请选择";
            cell.rightImgView.hidden = NO;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = NO;
            break;
        }
        case 7: {
            cell.leftLabel.text = @"天数";
            cell.placeholderString = @"";
            cell.rightImgView.hidden = YES;
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text = @"天";
            cell.lineView.hidden = NO;
            break;
        }
        case 8: {
            cell.leftLabel.text = @"月份";
            cell.placeholderString = @"";
            cell.rightImgView.hidden = YES;
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text = @"月";
            cell.lineView.hidden = NO;
            break;
        }
        case 9: {
            cell.leftLabel.text = @"一抵余额";
            cell.placeholderString = @"请填写";
            cell.rightImgView.hidden = YES;
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text = @"万元";
            cell.lineView.hidden = YES;
            break;
        }
        default:
            break;
    }
}
@end
