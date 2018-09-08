//
//  NSObject+HMCore.m
//  HMHealth
//
//  Created by SHANPX on 2018/8/21.
//  Copyright © 2018年 HM iOS. All rights reserved.
//

#import "NSObject+HMCore.h"
#import <objc/runtime.h>

@implementation NSObject (HMCore)
- (void)hm_setAssociateValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

- (void)hm_setAssociateWeakValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (void)hm_setAssociateCopyValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (id)hm_associatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}
- (id)hm_getPrivateProperty:(NSString *)propertyName
{
    Ivar iVar = class_getInstanceVariable([self class], [propertyName UTF8String]);
    
    if (iVar == nil) {
        iVar = class_getInstanceVariable([self class], [[NSString stringWithFormat:@"_%@",propertyName] UTF8String]);
    }
    
    id propertyVal = object_getIvar(self, iVar);
    return propertyVal;
}
@end
