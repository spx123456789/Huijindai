//
//  NSObject+HMCore.h
//  HMHealth
//
//  Created by SHANPX on 2018/8/21.
//  Copyright © 2018年 HM iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HMCore)

- (void)hm_setAssociateValue:(id)value withKey:(void *)key;  // Strong reference
- (void)hm_setAssociateWeakValue:(id)value withKey:(void *)key;
- (void)hm_setAssociateCopyValue:(id)value withKey:(void *)key;
- (id)hm_associatedValueForKey:(void *)key;
- (id)hm_getPrivateProperty:(NSString *)propertyName;

@end
