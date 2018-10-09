//
//  HJDHomeRoomDiDaiPickerView.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJDHomeRoomDiDaiModel;
@class HJDHomeRoomDiDaiPickerView;
@protocol HJDHomeRoomDiDaiPickerViewDelegate<NSObject>
- (void)roomDiDaiPickerView:(HJDHomeRoomDiDaiPickerView *)pickerView didSelectedCity:(HJDHomeRoomDiDaiModel *)cityModel;
@end

@interface HJDHomeRoomDiDaiPickerView : UIView
@property(nonatomic, weak) id<HJDHomeRoomDiDaiPickerViewDelegate> delegate;

- (void)show;
@end
