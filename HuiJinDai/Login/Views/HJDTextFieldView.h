//
//  HJDTextFieldView.h
//  HuiJinDai
//
//  Created by GXW on 2018/8/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJDTextFieldView : UIView
@property(nonatomic, strong) UILabel *textLabel;
@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, copy) NSString *fieldPlaceholder;
@property(nonatomic, assign) BOOL fieldCanEdit;

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text fieldPlaceholder:(NSString *)placeholder tag:(NSInteger)fieldTag;
@end

@interface HJDRegisterAgreementView : UIView
@property(nonatomic, assign) BOOL selected;
@end
