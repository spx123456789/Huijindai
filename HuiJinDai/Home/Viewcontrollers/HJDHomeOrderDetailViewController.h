//
//  HJDHomeOrderDetailViewController.h
//  HuiJinDai
//
//  Created by GXW on 2018/9/16.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDBaseViewController.h"

@interface HJDHomeOrderDetailViewController : HJDBaseViewController
@property(nonatomic, copy) NSString *order_id;
@property(nonatomic, copy) NSString *controller_from;
@property(nonatomic, assign) BOOL isShowBank; //是否显示绑定银行卡，默认NO
@end
