//
//  HJDUserDefaultsManager.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/28.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDUserDefaultsManager.h"

@implementation HJDUserDefaultsManager

// 单例
+ (instancetype)shareInstance {
    static dispatch_once_t once;
    static HJDUserDefaultsManager *instance = nil;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

//保存对象
- (void)saveObject:(id<NSCoding>)obj key:(NSString *)key {
    NSData *userdata = [NSKeyedArchiver archivedDataWithRootObject:obj];
    [[NSUserDefaults standardUserDefaults] setObject:userdata forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//读取对象
- (HJDBaseModel *)loadObject:(NSString *)key {
    HJDBaseModel *obj = nil;
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (data) {
        obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return obj;
}

//移出对象
- (void)removeObject:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

@end
