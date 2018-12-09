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

+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;

@end
