//
//  UIView+HMCore.h
//  HMHealth
//
//  Created by lilingang on 16/11/2.
//  Copyright © 2016年 LiLingang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (HMCore)

@property (nonatomic, readwrite) CGFloat hmTop;
@property (nonatomic, readwrite) CGFloat hmBottom;
@property (nonatomic, readwrite) CGFloat hmLeft;
@property (nonatomic, readwrite) CGFloat hmRight;
@property (nonatomic, readwrite) CGFloat hmMiddleX;
@property (nonatomic, readwrite) CGFloat hmMiddleY;
@property (nonatomic, readwrite) CGFloat hmWidth;
@property (nonatomic, readwrite) CGFloat hmHeight;
@property (nonatomic, readwrite) CGPoint hmLeftTopPoint;

@property (nonatomic, readonly) CGSize hmSize;
@property (nonatomic, readonly) CGPoint hmBoundsCenter;

/**
给View增加阴影

 @param color   阴影颜色
 @param offset  偏移量
 @param opacity 透明度
 @param radius  弧度
 @param blur    扩散半径
 */
- (void)hmShadowWithColor:(UIColor *)color
                   offset:(CGSize)offset
                  opacity:(CGFloat)opacity
                   radius:(CGFloat)radius
                     blur:(CGFloat)blur;

- (void)hmLayerCornerRadius:(CGFloat)radius;

- (UIView *)hmAddSubviewToFillContent:(UIView *)view;

//添加点击事件
- (void)hm_addTapActionWithBlock:(GestureActionBlock)block;

//移除点击事件
- (void)hm_removeTapAction;

//添加长按事件
- (void)hm_addLongPressActionWithBlock:(GestureActionBlock)block;

//移除长按事件
- (void)hm_removeLongPressAction;

@end
