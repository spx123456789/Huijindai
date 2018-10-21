//
//  HJDHomeSelectPickerView.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/10/21.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJDHomeSelectPickerView;
@protocol HJDHomeSelectPickerViewDelegate <NSObject>
- (void)selectPickerView:(HJDHomeSelectPickerView *)selectPickerView didSelecIndex:(NSInteger)index;
@end


@interface HJDHomeSelectPickerView : UIView
@property(nonatomic, weak) id<HJDHomeSelectPickerViewDelegate> delegate;

@property(nonatomic, strong) NSArray *dataSource;
@end

