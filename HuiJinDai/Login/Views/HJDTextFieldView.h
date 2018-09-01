//
//  HJDTextFieldView.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/8/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJDTextFieldView : UIView

@property(nonatomic, strong) NSString *fieldText;
- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text fieldPlaceholder:(NSString *)placeholder tag:(NSInteger)fieldTag;
@end

@interface HJDRegisterAgreementView : UIView
@property(nonatomic, assign) BOOL selected;
@end

@interface HJDCustomerServiceView : UIView

@end
