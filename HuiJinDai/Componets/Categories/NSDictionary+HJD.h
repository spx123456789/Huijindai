//
//  NSDictionary+HJD.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/28.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (HJD)
// 根据key/key形式获取数据，分隔符'/'
- (id)getObjectByPath:(NSString *)path;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end
