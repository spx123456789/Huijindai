//
//  HJDCustomerServiceView.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/8.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDCustomerServiceView.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@interface HJDCustomerServiceView()
@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UILabel *phoneLabel;
@end

@implementation HJDCustomerServiceView
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithImage:kImage(@"客服电话")];
    }
    return _imgView;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.text = @"400-250-1234";
        _phoneLabel.textColor = kMainColor;
        _phoneLabel.font = kFont16;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [_phoneLabel addGestureRecognizer:tap];
    }
    return _phoneLabel;
}

- (void)tapGesture:(UITapGestureRecognizer *)tap {
    [self phoneCall:@"400-250-1234"];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imgView];
        [self addSubview:self.phoneLabel];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(18, 22));
        }];
        
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(12);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(110, 20));
        }];
    }
    return self;
}

#pragma mark - 打电话
- (void)phoneCall:(NSString *)phone {
    if ([self checkSIMCard]) {
        NSString *mobile = [NSString stringWithFormat:@"tel://%@", phone];
        NSURL *url = [NSURL URLWithString:mobile];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                
            }];
        }
    }
}

- (BOOL)checkSIMCard {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    if (!carrier.isoCountryCode && !carrier.mobileCountryCode && !carrier.mobileNetworkCode) {
        [MBProgressHUD showError:@"SIM卡状态异常"];
        return NO;
    }
    return YES;
}
@end
