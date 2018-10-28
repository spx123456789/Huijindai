//
//  HJDHomeDatePickerView.h
//  HuiJinDai
//
//  Created by GXW on 2018/10/21.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJDHomeDatePickerView;
@protocol HJDHomeDatePickerViewDelegate <NSObject>

- (void)datePickerView:(HJDHomeDatePickerView *)datePickerView selectTime:(NSString *)selectTime;

@end

@interface HJDHomeDatePickerView : UIView
@property(nonatomic, weak) id<HJDHomeDatePickerViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame selectDate:(NSDate *)selectDate;

- (void)showDatePicker;
@end
