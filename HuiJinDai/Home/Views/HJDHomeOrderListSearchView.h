//
//  HJDHomeOrderListSearchView.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/5.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJDHomeOrderListSearchView;
@protocol HJDHomeOrderListSearchViewDelegate <NSObject>
- (void)searchView:(HJDHomeOrderListSearchView *)searchView didSearch:(NSString *)searchStr;
@end

@interface HJDHomeOrderListSearchView : UIView
@property(nonatomic, weak) id<HJDHomeOrderListSearchViewDelegate> delegate;
@end
