//
//  HJDBaseModel.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/28.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface HJDBaseModel : NSObject

/**
 *  将模型转成字典
 *  @return 字典
 */
- (NSMutableDictionary *)hjd_TransToDictionary;

/**
 *  将字典的键值对转成模型属性
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 */
- (instancetype)hjd_loadDataFromkeyValues:(id)keyValues;

/** !!!!!!!!!!!!
 *  所有忽略保存至数据库的属性都需要在该方法中指出，
 *  在该方法中返回的属性，在存DB和转字典时都会被忽略
 *  @return 不需要保存至数据库的方法
 */
+ (NSMutableArray *)mj_ignoredPropertyNames;

/**
 *  如果model的属性名称存在于json内对应的键不匹配时，此函数更换key值，具体实现参考.m文件实现
 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName;
@end
