//
//  HJDMyNavTextFieldSearchView.h
//  HuiJinDai
//
//  Created by GXW on 2018/9/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJDMyNavTextFieldSearchView;
@protocol HJDMyNavTextFieldSearchViewDelegate<NSObject>
@optional
- (void)searchView:(HJDMyNavTextFieldSearchView *)searchView backButton:(id)sender;
- (void)searchView:(HJDMyNavTextFieldSearchView *)searchView keyWord:(NSString *)keyWord sureButton:(id)sender;
- (void)searchView:(HJDMyNavTextFieldSearchView *)searchView clearButton:(id)sender;
@end

@interface HJDMyNavTextFieldSearchView : UIView
@property(nonatomic, copy) NSString *placeholderStr;
@property(nonatomic, weak) id<HJDMyNavTextFieldSearchViewDelegate> delegate;
@property(nonatomic, assign) BOOL isHaveSureButton;
@end
