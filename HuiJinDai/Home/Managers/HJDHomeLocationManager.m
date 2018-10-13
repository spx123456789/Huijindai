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

static HJDHomeLocationManager *_sharedManager = nil;
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[HJDHomeLocationManager alloc] init];
    });
    return _sharedManager;
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
    [self.locationManager stopUpdatingLocation];
    
    //根据经纬度反向地理编译出地址信息
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *placemark in placemarks) {
            NSLog(@"%@", placemark.country);
            if (self.delegate && [self.delegate respondsToSelector:@selector(locationManagerDidUpdateLocation:)]) {
                [self.delegate locationManagerDidUpdateLocation:placemark.country];
            }
        }
    }];
}

@end
