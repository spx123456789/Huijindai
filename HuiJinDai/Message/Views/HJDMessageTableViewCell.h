//
//  HJDMessageTableViewCell.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/9.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJDMessageTableViewCell : UITableViewCell
@property(nonatomic, copy) NSString *number;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *status;
@property(nonatomic, strong) UILabel *channelLabel;
@end
