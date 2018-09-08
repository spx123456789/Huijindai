//
//  UIColor+HMCore.h
//  HMHealth
//
//  Created by lilingang on 16/11/2.
//  Copyright © 2016年 LiLingang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HMRGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define HMRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define HMRGBHex(hexString) [UIColor hmColorWithHexString:hexString alpha:1]
#define HMRGBAHex(hexString,a) [UIColor hmColorWithHexString:hexString alpha:a]

@interface UIColor (HMCore)


/**
 将十六进制颜色值字符串转换为UIColor对象

 @param hexString 十六进制颜色值字符串
 @param alpha     alpha值 0~1

 @return UIColor
 */
+ (UIColor *)hmColorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;


/**
 将十六进制颜色值转换为UIColor对象

 @param hexColor 十六进制颜色值
 @param alpha    alpha值 0~1

 @return UIColor
 */
+ (UIColor *)hmColorWithHex:(long)hexColor alpha:(float)alpha;

@end
