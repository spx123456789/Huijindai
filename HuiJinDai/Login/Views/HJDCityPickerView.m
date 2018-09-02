//
//  HJDCityPickerView.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/8/31.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDCityPickerView.h"

@interface HJDCityPickerView()<UIPickerViewDelegate, UIPickerViewDataSource>
@property(nonatomic, strong) UIButton *cancelButton;
@property(nonatomic, strong) UIButton *sureButton;
@property(nonatomic, strong) UIPickerView *pickerView;
@property(nonatomic, strong) NSArray *dataSource;
@property(nonatomic, assign) NSInteger selectIndex;
@end

@implementation HJDCityPickerView

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 160)];
        _pickerView.backgroundColor = kWithe;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        topView.backgroundColor = kRGB_Color(227, 227, 227);
        [self addSubview:topView];
        
        _cancelButton = [self createButtonWithTitle:@"取消" selector:@selector(cancelButtonClick:)];
        _cancelButton.frame = CGRectMake(10, 0, 40, 40);
        [topView addSubview:_cancelButton];
        
        _sureButton = [self createButtonWithTitle:@"完成" selector:@selector(sureButtonClick:)];
        _sureButton.frame = CGRectMake(kScreenWidth - 50, 0, 40, 40);
        [topView addSubview:_sureButton];
        
        self.dataSource = @[ @"上海市", @"天津市", @"北京市", @"石家庄市", @"深圳", @"武汉市", @"广州" ];
        [self addSubview:self.pickerView];
        
    }
    return self;
}

- (void)cancelButtonClick:(id)btn {
    [self removeFromSuperview];
}

- (void)sureButtonClick:(id)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedCity:)]) {
        [self.delegate didSelectedCity:self.dataSource[_selectIndex]];
    }
    [self removeFromSuperview];
}

- (UIButton *)createButtonWithTitle:(NSString *)title selector:(SEL)selector {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 25;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *str = [self.dataSource objectAtIndex:row];
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:str attributes:@{ NSFontAttributeName : kFont10, NSForegroundColorAttributeName : kRGB_Color(0, 255, 255)}];
    return attriString;
}

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    NSString *str = [self.dataSource objectAtIndex:row];
//    return str;
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _selectIndex = row;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource.count;
}

@end
