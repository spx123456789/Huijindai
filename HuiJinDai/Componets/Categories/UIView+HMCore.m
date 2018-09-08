//
//  UIView+HMCore.m
//  HMHealth
//
//  Created by lilingang on 16/11/2.
//  Copyright © 2016年 LiLingang. All rights reserved.
//

#import "UIView+HMCore.h"
#import "NSObject+HMCore.h"

static char kActionHandlerTapBlockKey;
static char kActionHandlerLongPressBlockKey;

@implementation UIView (HMCore)


- (void)hmShadowWithColor:(UIColor *)color
                   offset:(CGSize)offset
                  opacity:(CGFloat)opacity
                   radius:(CGFloat)radius
                     blur:(CGFloat)blur {
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    float x = self.bounds.origin.x;
    float y = self.bounds.origin.y;
    
    CGPoint leftMiddle   = CGPointMake(x-blur,y+(height/2)+blur);
    CGPoint rightMiddle  = CGPointMake(x+width+blur,y+(height/2)+blur);
    
    CGPoint topLeft      = CGPointMake(x-blur, y-blur);
    CGPoint topMiddle    = CGPointMake(x+(width/2),y-blur);
    CGPoint topRight     = CGPointMake(x+width+blur,y-blur);
    
    CGPoint bottomRight  = CGPointMake(x+width+blur,y+height+blur);
    CGPoint bottomMiddle = CGPointMake(x+(width/2),y+height+blur);
    CGPoint bottomLeft   = CGPointMake(x-blur,y+height+blur);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                    cornerRadius:radius];
    [path moveToPoint:topLeft];
    [path addQuadCurveToPoint:topRight
                 controlPoint:topMiddle];
    [path addQuadCurveToPoint:bottomRight
                 controlPoint:rightMiddle];
    [path addQuadCurveToPoint:bottomLeft
                 controlPoint:bottomMiddle];
    [path addQuadCurveToPoint:topLeft
                 controlPoint:leftMiddle];
    self.layer.shadowPath = path.CGPath;
}

- (void)hmLayerCornerRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

#pragma mark - Getter and Setter

- (void)setHmTop:(CGFloat)hmTop{
    self.frame = CGRectMake(self.hmLeft, hmTop, self.hmWidth, self.hmHeight);
}

- (CGFloat)hmTop{
    return self.frame.origin.y;
}

- (void)setHmBottom:(CGFloat)hmBottom {
    self.frame = CGRectMake(self.hmLeft,hmBottom-self.hmHeight,self.hmWidth,self.hmHeight);
}
- (CGFloat)hmBottom {
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setHmLeft:(CGFloat)hmLeft {
    self.frame = CGRectMake(hmLeft,self.hmTop,self.hmWidth,self.hmHeight);
}
- (CGFloat)hmLeft {
    return self.frame.origin.x;
}
- (void)setHmRight:(CGFloat)hmRight {
    self.frame = CGRectMake(hmRight-self.hmWidth,self.hmTop,self.hmWidth,self.hmHeight);
}
- (CGFloat)hmRight {
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setHmMiddleX:(CGFloat)hmMiddleX {
    self.frame = (CGRectMake(hmMiddleX - self.hmWidth / 2, self.hmTop, self.hmWidth, self.hmHeight));
}
- (CGFloat)hmMiddleX {
    return self.frame.origin.x + roundf(self.frame.size.width / 2);
}
- (void)setHmMiddleY:(CGFloat)hmMiddleY {
    self.frame = (CGRectMake(self.hmLeft, hmMiddleY - self.hmHeight / 2, self.hmWidth, self.hmHeight));
}
- (CGFloat)hmMiddleY {
    return self.frame.origin.y + roundf(self.frame.size.height / 2);
}
- (void)setHmWidth:(CGFloat)hmWidth {
    self.frame = (CGRectMake(self.hmLeft, self.hmTop, hmWidth, self.hmHeight));
}
- (CGFloat)hmWidth {
    return self.frame.size.width;
}
- (void)setHmHeight:(CGFloat)hmHeight {
    self.frame = CGRectMake(self.hmLeft, self.hmTop, self.hmWidth, hmHeight);
}
- (CGFloat)hmHeight {
    return self.frame.size.height;
}

- (CGSize)hmSize{
    return CGSizeMake(self.hmWidth, self.hmHeight);
}

- (CGPoint)hmBoundsCenter {
    return CGPointMake(roundf(self.hmWidth / 2.0), roundf(self.hmHeight / 2.0));
}

- (void)setHmLeftTopPoint:(CGPoint)hmLeftTopPoint {
    self.frame = CGRectMake(hmLeftTopPoint.x, hmLeftTopPoint.y, self.hmWidth, self.hmHeight);
}

- (CGPoint)hmLeftTopPoint {
    return CGPointMake(self.frame.origin.x, self.frame.origin.y);
}

- (UIView *)hmAddSubviewToFillContent:(UIView *)view {
    NSDictionary *viewsDictionary = @{ @"view" : view };
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:view];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[view]|" options:0 metrics:nil views:viewsDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:viewsDictionary]];
    return view;
}

- (void)hm_addTapActionWithBlock:(GestureActionBlock)block {
    UITapGestureRecognizer *gesture = [self hm_associatedValueForKey:_cmd];
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hm_handleActionForTapGesture:)];
        gesture.numberOfTapsRequired = 1;
        [self addGestureRecognizer:gesture];
        [self hm_setAssociateValue:gesture withKey:_cmd];
    }
    
    [self hm_setAssociateCopyValue:block withKey:&kActionHandlerTapBlockKey];
    self.userInteractionEnabled = YES;
}

- (void)hm_removeTapAction {
    GestureActionBlock block = [self hm_associatedValueForKey:&kActionHandlerTapBlockKey];
    if (block) {
        NSArray *gestures = [self gestureRecognizers];
        [gestures enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIGestureRecognizer *gesture = obj;
            if ([gesture isMemberOfClass:[UITapGestureRecognizer class]]) {
                [gesture removeTarget:self action:@selector(hm_handleActionForTapGesture:)];
            }
        }];
        [self hm_setAssociateCopyValue:nil withKey:&kActionHandlerTapBlockKey];
    }
}

- (void)hm_handleActionForTapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        GestureActionBlock block = [self hm_associatedValueForKey:&kActionHandlerTapBlockKey];
        if (block) {
            block(gesture);
        }
    }
}

- (void)hm_addLongPressActionWithBlock:(GestureActionBlock)block {
    UILongPressGestureRecognizer *gesture = [self hm_associatedValueForKey:_cmd];
    if (!gesture) {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                action:@selector(ora_handleActionForLongPressGesture:)];
        gesture.minimumPressDuration = 1;
        [self addGestureRecognizer:gesture];
        [self hm_setAssociateValue:gesture withKey:_cmd];
    }
    
    [self hm_setAssociateCopyValue:block withKey:&kActionHandlerLongPressBlockKey];
    self.userInteractionEnabled = YES;
}

- (void)hm_removeLongPressAction {
    GestureActionBlock block = [self hm_associatedValueForKey:&kActionHandlerLongPressBlockKey];
    if (block) {
        NSArray *gestures = [self gestureRecognizers];
        [gestures enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIGestureRecognizer *gesture = obj;
            if ([gesture isMemberOfClass:[UILongPressGestureRecognizer class]]) {
                [gesture removeTarget:self action:@selector(ora_handleActionForLongPressGesture:)];
            }
        }];
        [self hm_setAssociateCopyValue:nil withKey:&kActionHandlerLongPressBlockKey];
    }
}

- (void)ora_handleActionForLongPressGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        GestureActionBlock block = [self hm_associatedValueForKey:&kActionHandlerLongPressBlockKey];
        if (block) {
            block(gesture);
        }
    }
}
@end
