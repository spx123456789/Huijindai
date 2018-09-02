//
//  HJDBaseViewController.h
//  HuiJinDai
//
//  Created by SHANPX on 2018/8/31.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJDBaseViewController : UIViewController

//显示/隐藏导航
- (void)hideNavigationBar;
- (void)showNavigationBar;

//隐藏tabbleView 的多余线
- (void)setExtraCellLineHidden:(UITableView *)tableView;
//隐藏导航栏下面的线
- (void)navigationBarLineHidden:(BOOL)hidden;

//设置按钮
- (void)setRightNavigationButton:(NSString *)title
                       backImage:(UIImage *)backImage
                highlightedImage:(UIImage *)highlightedImage
                           frame:(CGRect)frame;
- (void)navigationRightButtonClicked:(UIButton *)sender;

//返回按钮
- (void)setBackBarButton;
- (void)goBack:(UIButton *)sender;
@end
