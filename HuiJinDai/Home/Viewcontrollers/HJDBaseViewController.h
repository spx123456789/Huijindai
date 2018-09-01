//
//  HJDBaseViewController.h
//  HuiJinDai
//
//  Created by SHANPX on 2018/8/31.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJDBaseViewController : UIViewController

//隐藏tabbleView 的多余线
- (void)setExtraCellLineHidden:(UITableView *)tableView;
//隐藏导航栏下面的线
- (void)navigationBarLineHidden:(BOOL)hidden;

@end
