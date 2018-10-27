//
//  HJDHomeDatePickerView.m
//  HuiJinDai
//
//  Created by GXW on 2018/10/21.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeDatePickerView.h"
#import "NSDate+FSExtension.h"

#define kPickerYearCount 100
#define kPickerSelectedYearIndex 50
#define kPickerRowHeight 45.0

@interface HJDHomeDatePickerView()<UIPickerViewDelegate, UIPickerViewDataSource>
@property(nonatomic, strong) NSDate *selectDatetime;
@property(nonatomic, strong) UIPickerView *pickerView;
@end

@implementation HJDHomeDatePickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.selectDatetime = [NSDate date];
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, 150)];
        self.pickerView.backgroundColor = [UIColor clearColor];
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.pickerView.showsSelectionIndicator = NO;
        [self addSubview:self.pickerView];
        
        [self.pickerView reloadAllComponents];
        [self.pickerView selectRow:kPickerSelectedYearIndex inComponent:0 animated:NO];
        [self.pickerView selectRow:[self.selectDatetime fs_month] - 1 inComponent:1 animated:NO];
        [self.pickerView selectRow:[self.selectDatetime fs_day] - 1 inComponent:2 animated:NO];
        
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerView:selectTime:)]) {
        //2018-10-21 05:51:31 +0000
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        [self.delegate datePickerView:self selectTime:[formatter stringFromDate:self.selectDatetime]];
    }
    [self removeFromSuperview];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger count = 0;
    switch (component) {
        case 0:
            count = kPickerYearCount;
            break;
        case 1:
            count = 12;
            break;
        case 2:
            count = [self.selectDatetime fs_numberOfDaysInMonth];
            break;
        default:
            break;
    }
    return count;
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat width = 0.0;
    switch (component) {
        case 0:
            width = pickerView.frame.size.width / 3.0;
            break;
        case 1:
            width = pickerView.frame.size.width / 4.0;
            break;
        case 2:
            width = pickerView.frame.size.width / 4.0;
            break;
        default:
            break;
    }
    return width;
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
    pickerLabel.text = @"";
    switch (component) {
        case 0: {
            NSInteger year = [self.selectDatetime fs_year] - (kPickerSelectedYearIndex - row);
            pickerLabel.text = [NSString stringWithFormat:@"%ld年", (long)year];
        }
            break;
        case 1:
            pickerLabel.text = [NSString stringWithFormat:@"%ld月", (long)row + 1];
            break;
        case 2:
            pickerLabel.text = [NSString stringWithFormat:@"%ld日", (long)row + 1];
            break;
        default:
            break;
    }
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
            if (row != kPickerSelectedYearIndex) {
                self.selectDatetime = [self.selectDatetime fs_dateByAddingYears:-(kPickerSelectedYearIndex - row)];
                [pickerView reloadComponent:0];
                [pickerView selectRow:kPickerSelectedYearIndex inComponent:0 animated:NO];
                if ([self.selectDatetime fs_numberOfDaysInMonth] != [pickerView selectedRowInComponent:2]) {
                    [pickerView reloadComponent:2];
                    [self.pickerView selectRow:[self.selectDatetime fs_day] - 1 inComponent:2 animated:NO];
                }
            }
            break;
        case 1:
            self.selectDatetime = [self.selectDatetime fs_dateByAddingMonths:row + 1 - self.selectDatetime.fs_month];
            if ([self.selectDatetime fs_numberOfDaysInMonth] != [pickerView selectedRowInComponent:2]) {
                [pickerView reloadComponent:2];
                [self.pickerView selectRow:[self.selectDatetime fs_day] - 1 inComponent:2 animated:NO];
            }
            break;
        case 2:
            self.selectDatetime = [self.selectDatetime fs_dateByAddingDays:row + 1 - self.selectDatetime.fs_day];
            break;
        default:
            break;
    }
}

@end