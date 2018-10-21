//
//  NSString+HJD.h
//  HuiJinDai
//
//  Created by GXW on 2018/9/28.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HJD)

/**
 *  @brief  是否为空字符串
 *
 *  @return YES/NO
 */
+ (BOOL)hjd_isBlankString:(NSString *)string;

/**
 *  @brief  去除两端空格和回车
 *
 *  @return 去除后的字符串
 */
- (NSString *)hjd_trim;

/**
 *  @brief  是否是合法的(国内三大运营商)手机号码
 *
 *  @return 如果是合法的手机号码则返回YES；否则返回NO
 */
- (BOOL)hjd_isVaildPhoneNumber;

@end
