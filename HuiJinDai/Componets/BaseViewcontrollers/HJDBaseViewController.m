//
//  HJDBaseViewController.m
//  HuiJinDai
//
//  Created by SHANPX on 2018/8/31.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDBaseViewController.h"
#import "UITableView+HJD.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "HJDHttpResultView.h"

@interface HJDBaseViewController ()
@property(nonatomic, strong) HJDHttpResultView *resultView;
@end

@implementation HJDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = kControllerBackgroundColor;
    
    [self navigationBarLineHidden:YES];
    [self setBackBarButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavTitle:(NSString *)navTitle {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 35)];
    label.text = navTitle;
    label.textColor = kRGB_Color(0x33, 0x33, 0x33);
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = kFont17;
    label.adjustsFontSizeToFitWidth = YES;
    label.center = self.navigationController.navigationBar.center;
    self.navigationItem.titleView = label;
}

//隐藏导航条
- (void)hideNavigationBar {
    [self.navigationController setNavigationBarHidden:YES];
}

//显示导航条
- (void)showNavigationBar {
    [self.navigationController setNavigationBarHidden:NO];
}

//隐藏tabbleView 的多余线
- (void)setExtraCellLineHidden:(UITableView *)tableView {
    if (tableView != nil) {
        [tableView setExtraCellLineHidden:YES];
    }
}

//隐藏导航栏下面的细线
- (void)navigationBarLineHidden:(BOOL)hidden {
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        NSArray *list = self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {
                UIView *view = (UIView *)obj;
                if ([view isKindOfClass:[UIButton class]]) {
                    continue;
                }
                for (id obj2 in view.subviews) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *image2 = (UIImageView *)obj2;
                        image2.hidden = YES;
                    }
                }
            } else {
                if ([obj isKindOfClass:[UIImageView class]]) {
                    UIImageView *imageView = (UIImageView *)obj;
                    for (id obj2 in imageView.subviews) {
                        if ([obj2 isKindOfClass:[UIImageView class]]) {
                            UIImageView *imageView2 = (UIImageView *)obj2;
                            imageView2.hidden = hidden;
                        }
                    }
                }
            }
        }
    }
}

//设置按钮
- (void)setRightNavigationButton:(NSString *)title
                       backImage:(UIImage *)backImage
                highlightedImage:(UIImage *)highlightedImage
                           frame:(CGRect)frame {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:kRGB_Color(0x33, 0x33, 0x33) forState:UIControlStateNormal];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, -8)];
        button.titleLabel.font = kFont15;
    }
    [button addTarget:self
               action:@selector(navigationRightButtonClicked:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:frame];
    if (backImage) {
        [button setImage:backImage forState:UIControlStateNormal];
    }
    if (highlightedImage) {
        [button setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightBar;
}

- (void)navigationRightButtonClicked:(UIButton *)sender {
}

//返回按钮
- (void)setBackBarButton {
    if (self.navigationController.viewControllers.count <= 1) {
        return;
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 44, 44)];
    [button setImage:kImage(@"返回按钮") forState:UIControlStateNormal];
    [button setImage:kImage(@"返回按钮") forState:UIControlStateSelected];
    button.imageEdgeInsets = UIEdgeInsetsMake(4, -10, 4, 20);
    UIBarButtonItem *leftbutton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftbutton;
}

- (void)goBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 暂无数据 暂无网络
- (void)showNodataViewFrame:(CGRect)frame {
    HJDHttpResultView *resultView11 = [[HJDHttpResultView alloc] initWithFrame:frame];
    resultView11.showType = HJDHttpResultNoData;
    //resultView11.backgroundColor = [UIColor redColor];
    
    if (self.resultView == nil) {
        self.resultView = resultView11;
        [self.view addSubview:resultView11];
    } else {
        self.resultView.showType = HJDHttpResultNoData;
        self.resultView.hidden = NO;
    }
}

- (void)showNoNetworkViewFrame:(CGRect)frame callback:(void (^)(void))callback {
    HJDHttpResultView *resultView22 = [[HJDHttpResultView alloc] initWithFrame:frame];
    resultView22.showType = HJDHttpResultNoNetwork;
    //resultView22.backgroundColor = [UIColor redColor];
    resultView22.callBack = ^{
        callback();
    };
    
    if (self.resultView == nil) {
        self.resultView = resultView22;
        [self.view addSubview:resultView22];
    } else {
        self.resultView.showType = HJDHttpResultNoNetwork;
        self.resultView.hidden = NO;
    }
}

- (void)hideHttpResultView {
    if (self.resultView != nil) {
        self.resultView.hidden = YES;
    }
}

#pragma mark - 提示
- (void)showToast:(NSString *)message {
    [MBProgressHUD showError:message];
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
        [self showToast:@"SIM卡状态异常"];
        return NO;
    }
    return YES;
}
@end
