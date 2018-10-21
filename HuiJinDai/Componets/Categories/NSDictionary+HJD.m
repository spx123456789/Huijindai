//
//  NSDictionary+HJD.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/28.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "NSDictionary+HJD.h"

@implementation NSDictionary (HJD)

- (id)getObjectByPath:(NSString *)path {
    if (![self isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    id data = nil;
    
    //参数检查
    if (path) {
        NSArray *list = [path componentsSeparatedByString:@"/"];
        id node = self;
        for (NSString *name in list) {
            if (![node isKindOfClass:[NSDictionary class]]) {
                node = nil;
                break;
            }
            
            node = [node objectForKey:name];
            if (!node || [[node class] isSubclassOfClass:[NSNull class]]) {
                //没有找到
                node = nil;
                break;
            }
            
            if ([node isKindOfClass:[NSString class]] && [node isEqualToString:@"(null)"]) {
                //没有找到
                node = nil;
                break;
            }
            if ([node isKindOfClass:[NSNumber class]]) {
                //没有找到
                node = [node stringValue];
                break;
            }
            if (![node isKindOfClass:[NSDictionary class]]) {
                break;
            }
        }
        
        data = node;
    }
    return data;
}


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
