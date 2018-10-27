//
//  HJDHttpResultView.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/10/27.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HJDHttpResultNoData = 0,
    HJDHttpResultNoNetwork,
} HJDHttpResultType;

typedef void(^HJDHttpResultCallBack)(void);

@interface HJDHttpResultView : UIView
@property(nonatomic, assign) HJDHttpResultType showType;
@property(nonatomic, copy) HJDHttpResultCallBack callBack;
@end

