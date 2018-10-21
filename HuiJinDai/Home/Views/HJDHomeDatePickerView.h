//
//  HJDHomeDatePickerView.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/10/21.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJDHomeDatePickerView;
@protocol HJDHomeDatePickerViewDelegate <NSObject>

- (void)datePickerView:(HJDHomeDatePickerView *)datePickerView selectTime:(NSString *)selectTime;

@end

@interface HJDHomeDatePickerView : UIView
@property(nonatomic, weak) id<HJDHomeDatePickerViewDelegate> delegate;
@end
