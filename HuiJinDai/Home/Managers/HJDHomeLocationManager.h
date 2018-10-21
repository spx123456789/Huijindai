//
//  HJDHomeLocationManager.h
//  HuiJinDai
//
//  Created by GXW on 2018/10/9.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HJDHomeLocationManagerDelegate<NSObject>
- (void)locationManagerDidUpdateLocation:(NSString *)location;
@end

@interface HJDHomeLocationManager : NSObject

@property(nonatomic, weak) id<HJDHomeLocationManagerDelegate> delegate;

+ (instancetype)sharedManager;

- (void)startLocation;

@end
