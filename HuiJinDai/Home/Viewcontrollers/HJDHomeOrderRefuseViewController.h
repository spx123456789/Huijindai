//
//  HJDHomeOrderRefuseViewController.h
//  HuiJinDai
//
//  Created by GXW on 2018/9/16.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDBaseViewController.h"

@interface HJDHomeOrderRefuseViewController : HJDBaseViewController
@property(nonatomic, copy) NSString *order_id;
@property(nonatomic, copy) NSString *refuseContent;
@property(nonatomic, assign) BOOL isView;   //是否是查看拒单原因，默认NO
@end
