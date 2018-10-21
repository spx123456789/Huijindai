//
//  HJDUserModel.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/28.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDUserModel.h"

@implementation HJDUserModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{ @"user_id" : @"id"};
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSArray *list = [self GetAllvars];
    for (NSString *var in list) {
        [aCoder encodeObject:[self valueForKey:var] forKey:var];
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        NSArray *list = [self GetAllvars];
        for (NSString *var in list) {
            if ([aDecoder containsValueForKey:var]) {
                [self setValue:[aDecoder decodeObjectForKey:var] forKey:var];
            }
        }
    }
    return self;
}

#pragma mark - private method
- (NSMutableArray *)GetAllvars {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    //获取当前的类
    Class c = [self class];
    NSDictionary *dict = [self exceptionlist];
    
    while (c && ![[NSString stringWithUTF8String:object_getClassName(c)] isEqualToString:@"NSObject"]) {
        unsigned int numberOfIvars = 0;
        //获取cls 类成员变量列表
        objc_property_t *ivars = class_copyPropertyList(c, &numberOfIvars);
        //采用指针+1 来获取下一个变量
        for (const objc_property_t *p = ivars; p < ivars + numberOfIvars; p++) {
            NSString *key = [NSString stringWithUTF8String:property_getName(*p)];
            
            if (!dict || !dict[key]) {
                [list addObject:key];
            }
        }
        
        free(ivars);
        c = class_getSuperclass(c);
    }
    
    return list;
}

//排除列表
- (NSDictionary*)exceptionlist {
    return nil;
}
@end
