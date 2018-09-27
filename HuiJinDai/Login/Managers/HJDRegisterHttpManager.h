//
//  HJDRegisterHttpManager.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/27.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void (^HttpCallback)(NSDictionary *data, NSError *error, BOOL result);

@interface HJDRegisterHttpManager : NSObject
- (void)getVerifiCodeWithPhone:(NSString *)phone callBack:(HttpCallback)callBack;

- (void)postRegisterRequestWithPhone:(NSString *)phone verifiCode:(NSString *)code callBack:(HttpCallback)callBack;
@end
