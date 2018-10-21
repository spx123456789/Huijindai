//
//  HJDMyAgentTableViewCell.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJDMyAgentTableViewCell;
@protocol HJDMyAgentTableViewCellDelegate <NSObject>
- (void)myAgentCell:(HJDMyAgentTableViewCell *)agentCell didClickPhone:(id)sender;
@end

@interface HJDMyAgentTableViewCell : UITableViewCell
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *phone;

@property(nonatomic, weak) id<HJDMyAgentTableViewCellDelegate> delegate;
@end
