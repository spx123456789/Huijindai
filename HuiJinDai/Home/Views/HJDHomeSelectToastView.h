//
//  HJDHomeSelectToastView.h
//  HuiJinDai
//
//  Created by GXW on 2018/10/21.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJDHomeSelectToastView;
@protocol HJDHomeSelectToastViewDelegate <NSObject>
- (void)selectToastView:(HJDHomeSelectToastView *)selectToastView didSelecIndex:(NSInteger)index;
@end


@interface HJDHomeSelectToastView : UIView
@property(nonatomic, weak) id<HJDHomeSelectToastViewDelegate> delegate;
@property(nonatomic, assign) NSIndexPath *selectIndexPath;
@property(nonatomic, strong) NSArray *dataSource;

- (void)showView;
@end

