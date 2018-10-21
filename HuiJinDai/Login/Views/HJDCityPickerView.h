//
//  HJDCityPickerView.h
//  HuiJinDai
//
//  Created by GXW on 2018/8/31.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJDRegisterModel.h"

@class HJDCityPickerView;
@protocol HJDCityPickerViewDelegate<NSObject>
- (void)pickerView:(HJDCityPickerView *)pickerView didSelectedCity:(HJDCityModel *)city;
@end

@interface HJDCityPickerView : UIView
@property(nonatomic, weak) id<HJDCityPickerViewDelegate> delegate;

- (void)show;
@end
