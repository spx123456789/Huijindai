//
//  HJDHomeLocationManager.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/10/9.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeLocationManager.h"
#import "CoreLocation/CoreLocation.h"

@interface HJDHomeLocationManager()<CLLocationManagerDelegate>
@property(strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation HJDHomeLocationManager

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;//遵循代理
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 10.0f;
        [_locationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8以上版本定位需要）
    }
    return _locationManager;
}

- (void)startLocation {
    
    if ([CLLocationManager locationServicesEnabled]) {//判断定位操作是否被允许
         [self.locationManager startUpdatingLocation];//开始定位
        
    } else {
        
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = locations[0];
    CLLocationCoordinate2D oldCoordinate = newLocation.coordinate;
    NSLog(@"旧的经度：%f,旧的纬度：%f",oldCoordinate.longitude,oldCoordinate.latitude);
        
}

@end
