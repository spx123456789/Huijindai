//
//  HJDMessageSegmentView.h
//  HuiJinDai
//
//  Created by GXW on 2018/9/16.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HJDMessageTypeMy = 0,
    HJDMessageTypeChannel,
} HJDMessageType;


@class HJDMessageSegmentView;
@protocol HJDMessageSegmentViewDelegate<NSObject>
- (void)segmentView:(HJDMessageSegmentView *)segmentView didSelectMessageType:(HJDMessageType)type;
@end

@interface HJDMessageSegmentView : UIView
@property(nonatomic, weak) id<HJDMessageSegmentViewDelegate> delegate;

- (void)setSegmentViewTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle;
@end
