//
//  UIAlertController+Blocks.h
//  HMHealth
//
//  Created by SHANPX on 2018/8/25.
//  Copyright © 2018年 HM iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UIAlertControllerCompletionBlock) (UIAlertController * __nonnull controller, UIAlertAction * __nonnull action, NSInteger buttonIndex);
typedef void (^UIAlertControllerTapBlock) (void);

@interface UIAlertController (Blocks)

//+ (nonnull instancetype)showInViewController:(nonnull UIViewController *)viewController
//                                   withTitle:(nullable NSString *)title
//                                     message:(nullable NSString *)message
//                              preferredStyle:(UIAlertControllerStyle)preferredStyle
//                           cancelButtonTitle:(nullable NSString *)cancelButtonTitle
//                      destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
//                           otherButtonTitles:(nullable NSArray *)otherButtonTitles
//                                    tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock;
//
//+ (nonnull instancetype)showAlertInViewController:(nonnull UIViewController *)viewController
//                                        withTitle:(nullable NSString *)title
//                                          message:(nullable NSString *)message
//                                cancelButtonTitle:(nullable NSString *)cancelButtonTitle
//                           destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
//                                otherButtonTitles:(nullable NSArray *)otherButtonTitles
//                                         tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock;

+ (nonnull instancetype)showAlertInViewController:(nonnull UIViewController *)viewController
                                        withTitle:(nullable NSString *)title
                                          message:(nullable NSString *)message
                                sureButtonTitle:(nullable NSString *)sureButtonTitle
                                      sureBlock:(nullable UIAlertControllerTapBlock)sureBlock;
+ (nonnull instancetype)showAlertInViewController:(nonnull UIViewController *)viewController
                                        withTitle:(nullable NSString *)title
                                          message:(nullable NSString *)message
                                cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                                      cancelBlock:(nullable UIAlertControllerTapBlock)cancelBlock
                                sureButtonTitle:(nullable NSString *)sureButtonTitle
                                      sureBlock:(nullable UIAlertControllerTapBlock)sureBlock;


+ (nonnull instancetype)showActionSheetInViewController:(nonnull UIViewController *)viewController
                                              withTitle:(nullable NSString *)title
                                                message:(nullable NSString *)message
                                      cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                                 destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
                                      otherButtonTitles:(nullable NSArray *)otherButtonTitles
                                               tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock;


@property (readonly, nonatomic) BOOL visible;
@property (readonly, nonatomic) NSInteger cancelButtonIndex;
@property (readonly, nonatomic) NSInteger firstOtherButtonIndex;
@property (readonly, nonatomic) NSInteger destructiveButtonIndex;

@end
