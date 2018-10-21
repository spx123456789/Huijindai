//
//  HJDUserDefaultsManager.h
//  HuiJinDai
//
//  Created by GXW on 2018/9/28.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJDBaseModel.h"

#define kUserModelKey @"kUserModelKey"

@interface HJDUserDefaultsManager : NSObject
// 单例
+ (instancetype)shareInstance;

//保存对象
- (void)saveObject:(id<NSCoding>)obj key:(NSString *)key;

//读取对象
- (HJDBaseModel *)loadObject:(NSString *)key;

//移出对象
- (void)removeObject:(NSString *)key;
@end
