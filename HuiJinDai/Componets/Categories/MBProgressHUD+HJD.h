//
//  MBProgressHUD+HJD.h
//  HuiJinDai
//
//  Created by GXW on 2018/10/9.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (HJD)

+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;

@end
