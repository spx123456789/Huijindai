//
//  HJDHomeSelectPickerView.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/10/21.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeSelectPickerView.h"

#define kPickerRowHeight 45.0

@interface HJDHomeSelectPickerView()<UIPickerViewDelegate, UIPickerViewDataSource>
@property(nonatomic, assign) NSInteger selectIndex;
@property(nonatomic, strong) UIPickerView *pickerView;
@end

@implementation HJDHomeSelectPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWithe;
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, 150)];
        self.pickerView.backgroundColor = kWithe;
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.pickerView.showsSelectionIndicator = NO;
        [self addSubview:self.pickerView];
        
        [self.pickerView reloadAllComponents];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        button.backgroundColor = kMainColor;
        [button setTitleColor:kRGB_Color(0x66, 0x66, 0x66) forState:UIControlStateNormal];
        button.frame = CGRectMake(kScreenWidth - 50 - 16, 0, 50, 25);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = 5.f;
        button.layer.masksToBounds = YES;
        [self addSubview:button];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 29, kScreenWidth, 1)];
        line.backgroundColor = kLineColor;
        [self addSubview:line];
    }
    return self;
}

- (void)buttonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectPickerView:didSelecIndex:)]) {
        [self.delegate selectPickerView:self didSelecIndex:self.selectIndex];
    }
    [self removeFromSuperview];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource.count;
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return pickerView.frame.size.width;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return kPickerRowHeight;
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(nullable UIView *)view {
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGFloat width = [self pickerView:pickerView widthForComponent:component];
        CGRect frame = CGRectMake(0, 0, width, kPickerRowHeight);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:kFont18];
        [pickerLabel setTextColor:kRGB_Color(0x66, 0x66, 0x66)];
    }
    pickerLabel.text = self.dataSource[row];
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectIndex = row;
}
@end
