//
//  UIColor+HMCore.m
//  HMHealth
//
//  Created by lilingang on 16/11/2.
//  Copyright © 2016年 LiLingang. All rights reserved.
//

#import "UIColor+HMCore.h"

@implementation UIColor (HMCore)

+ (UIColor *)hmColorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha{
    if ([hexString length] == 0) {
        return [UIColor clearColor];
    }
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]){
        cString = [cString substringFromIndex:2];
    } else if ([cString hasPrefix:@"#"]){
        cString = [cString substringFromIndex:1];
    }
    
    
    if ([cString length] == 6){
        return [UIColor hmColorWithSix:cString alpha:alpha];

    } else if([cString length] == 8) {
        return [UIColor hmColorWithEight:cString];
    }
    
    return [UIColor clearColor];
}

//正常六位的颜色值 eg #000000
+ (UIColor *)hmColorWithSix:(NSString *)colorString alpha:(CGFloat)alpha{
    NSRange range;
    range.location = 0;
    range.length = 2;
    // Separate into r, g, b substrings
    //r
    NSString *rString = [colorString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [colorString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [colorString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

//八位的颜色值 最高位为透明度 eg #FF000000
+ (UIColor *)hmColorWithEight:(NSString *)colorString{
    NSRange range;
    range.location = 0;
    range.length = 2;
    // Separate into r, g, b substrings
    //alpha
    NSString *alphaString = [colorString substringWithRange:range];
    range.location = 2;
    
    //r
    NSString *rString = [colorString substringWithRange:range];
    
    //g
    range.location = 4;
    NSString *gString = [colorString substringWithRange:range];
    
    //b
    range.location = 6;
    NSString *bString = [colorString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b,alpha;
    [[NSScanner scannerWithString:alphaString] scanHexInt:&alpha];
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:((float) alpha / 255.0f)];
}

+ (UIColor *)hmColorWithHex:(long)hexColor alpha:(float)alpha{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


@end
