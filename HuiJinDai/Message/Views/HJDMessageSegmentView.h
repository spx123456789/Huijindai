//
//  HJDMessageSegmentView.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/16.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HJDMessageTypeMy,
    HJDMessageTypeChannel,
} HJDMessageType;


@class HJDMessageSegmentView;
@protocol HJDMessageSegmentViewDelegate<NSObject>
- (void)segmentView:(HJDMessageSegmentView *)segmentView didSelectMessageType:(HJDMessageType)type;
@end

@interface HJDMessageSegmentView : UIView
@property(nonatomic, weak) id<HJDMessageSegmentViewDelegate> delegate;
@end
