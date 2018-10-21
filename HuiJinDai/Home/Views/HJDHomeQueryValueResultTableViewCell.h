//
//  HJDHomeQueryValueResultTableViewCell.h
//  HuiJinDai
//
//  Created by GXW on 2018/10/13.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJDHomeQueryValueResultTableViewCell : UITableViewCell

- (void)setCellValue:(NSDictionary *)dic;
@end

@interface HJDHomeQueryValueResultNumberTableCell : UITableViewCell
@property(nonatomic, copy) NSString *company;
@property(nonatomic, copy) NSString *number;
@end
