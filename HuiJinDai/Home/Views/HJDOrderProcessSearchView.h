//
//  HJDOrderProcessSearchView.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/22.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJDOrderProcessSearchView;
@protocol HJDOrderProcessSearchViewDelegate <NSObject>
- (void)processSearchView:(HJDOrderProcessSearchView *)searchView searchWord:(NSString *)keyWord;
@end

@interface HJDOrderProcessSearchView : UIView
@property(nonatomic, assign) NSInteger selectIndex;
@property(nonatomic, weak) id<HJDOrderProcessSearchViewDelegate> delegate;
@end
