//
//  HJDBaseViewController.m
//  HuiJinDai
//
//  Created by SHANPX on 2018/8/31.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDBaseViewController.h"
#import "UITableView+Imora.h"
@interface HJDBaseViewController ()

@end

@implementation HJDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setExtraCellLineHidden:(UITableView *)tableView {
    if (tableView != nil) {
        [tableView setExtraCellLineHidden:YES];
    }
}

//隐藏导航栏下面的细线
- (void)navigationBarLineHidden:(BOOL)hidden {
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        NSArray *list = self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {
                UIView *view = (UIView *)obj;
                if ([view isKindOfClass:[UIButton class]]) {
                    continue;
                }
                for (id obj2 in view.subviews) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *image2 = (UIImageView *)obj2;
                        image2.hidden = YES;
                    }
                }
            } else {
                if ([obj isKindOfClass:[UIImageView class]]) {
                    UIImageView *imageView = (UIImageView *)obj;
                    for (id obj2 in imageView.subviews) {
                        if ([obj2 isKindOfClass:[UIImageView class]]) {
                            UIImageView *imageView2 = (UIImageView *)obj2;
                            imageView2.hidden = hidden;
                        }
                    }
                }
            }
        }
    }
}

@end
