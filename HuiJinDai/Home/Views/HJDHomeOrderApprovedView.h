//
//  HJDHomeOrderApprovedView.h
//  HuiJinDai
//
//  Created by GXW on 2018/9/17.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJDMyAgentModel.h"

typedef void(^HJDOrderApprovedBlock)(HJDMyAgentModel *model);

@interface HJDHomeOrderApprovedView : UIView
@property(nonatomic, strong) NSArray *dataSource;
@property(nonatomic, copy) HJDOrderApprovedBlock callBack;

- (void)showApprovedView;
@end
