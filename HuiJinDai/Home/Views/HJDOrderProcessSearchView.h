//
//  HJDOrderProcessSearchView.h
//  HuiJinDai
//
//  Created by GXW on 2018/9/22.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJDOrderProcessSearchView;
@protocol HJDOrderProcessSearchViewDelegate <NSObject>
- (void)processSearchView:(HJDOrderProcessSearchView *)searchView searchWord:(NSString *)keyWord selectStatus:(NSString *)status clickSureButton:(BOOL)isClick;
@end

@interface HJDOrderProcessSearchView : UIView
@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, assign) NSInteger selectIndex;
@property(nonatomic, weak) id<HJDOrderProcessSearchViewDelegate> delegate;
@property(nonatomic, assign) BOOL showLeft;
@end
