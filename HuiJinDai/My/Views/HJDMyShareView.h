//
//  HJDMyShareView.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJDMyShareView;

@protocol HJDMyShareViewDelegate<NSObject>
- (void)shareView:(HJDMyShareView *)shareView didSelectedIndex:(NSInteger)index;
@end

@interface HJDMyShareView : UIView
@property(nonatomic, weak) id<HJDMyShareViewDelegate> delegate;
@end
