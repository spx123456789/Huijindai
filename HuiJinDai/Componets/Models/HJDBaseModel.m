//
//  HJDBaseModel.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/28.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDBaseModel.h"

@implementation HJDBaseModel

- (NSMutableDictionary *)hjd_TransToDictionary {
    return [self mj_keyValues];
    
}

- (instancetype)hjd_loadDataFromkeyValues:(id)keyValues {
    return [self mj_setKeyValues:keyValues];
}

+ (NSMutableArray *)mj_ignoredPropertyNames {
    return nil;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    /*
     return @{
     @"desc" : @"desciption",
     @"name.oldName" : @"oldName",
     @"name.info[1].nameChangedTime" : @"nameChangedTime",
     @"other.bag" : @"bag"
     };
     key值是 model的属性名称，如果属性本身是类对象，@"name.oldName"就是指类对象的属性
     value值是 是json内的key值
     */
    return nil;
}
@end
