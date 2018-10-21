//
//  HJDHomeOrderDetailTableViewCell.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/16.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJDHomeQueryValueDetailModel.h"

@interface HJDHomeOrderDetailTableViewCell : UITableViewCell
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIView *lineView;

- (UILabel *)createLeftLabelWithTitle:(NSString *)title;
- (UILabel *)createRightLabel;
@end

//询值
@interface HJDHomeOrderDetailQueryCell : HJDHomeOrderDetailTableViewCell
- (void)setCellValue:(HJDHomeQueryValueDetailModel *)model;
- (void)setDetailCellValue:(NSDictionary *)dic;
@end

//报单
@interface HJDHomeOrderDetailDeclarationCell : HJDHomeOrderDetailTableViewCell
- (void)setCellDeclarationValue:(NSDictionary *)dic;
@end

//工单流程
@interface HJDHomeOrderDetailProcessCell : HJDHomeOrderDetailTableViewCell
@property(nonatomic, strong) NSArray *processArray;
@end

//询值结果
@interface HJDHomeOrderDetailQueryValueResultCell : HJDHomeOrderDetailTableViewCell
@property(nonatomic, strong) NSArray *dataSource;
@end

@class HJDHomeOrderDetailButtonCell;
@protocol HJDHomeOrderDetailButtonCellDelegate<NSObject>
- (void)buttonCell:(HJDHomeOrderDetailButtonCell *)buttonCell selectButtonIndex:(NSInteger)index;
@end

//审核
@interface HJDHomeOrderDetailButtonCell : UITableViewCell
@property(nonatomic, weak) id<HJDHomeOrderDetailButtonCellDelegate> delegate;
@end


