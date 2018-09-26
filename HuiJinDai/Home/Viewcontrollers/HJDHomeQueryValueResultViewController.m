//
//  HJDHomeQueryValueResultViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/24.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeQueryValueResultViewController.h"
#import "HJDCustomerServiceView.h"

@interface HJDHomeQueryValueResultViewController ()
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIView *topView;
@property(nonatomic, strong) HJDCustomerServiceView *customServiceView;
@property(nonatomic, strong) UIButton *declarationBtn;
@end

@implementation HJDHomeQueryValueResultViewController

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 76, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - 76)];
        _scrollView.backgroundColor = kWithe;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64 + 12 + 60)];
        _topView.backgroundColor = kMainColor;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 75, 20, 150, 44)];
        label.text = @"询值结果";
        label.textColor = kRGB_Color(0xff, 0xff, 0xff);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = kFont17;
        label.adjustsFontSizeToFitWidth = YES;
        [_topView addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:CGRectMake(0, 20, 44, 44)];
        [button setImage:kImage(@"返回按钮") forState:UIControlStateNormal];
        [button setImage:kImage(@"返回按钮") forState:UIControlStateSelected];
        [_topView addSubview:button];
    }
    return _topView;
}

- (HJDCustomerServiceView *)customServiceView {
    if (!_customServiceView) {
        _customServiceView = [[HJDCustomerServiceView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 70, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight, 140, 30)];
        _customServiceView.backgroundColor = kWithe;
    }
    return _customServiceView;
}

- (UIButton *)declarationBtn {
    if (!_declarationBtn) {
        _declarationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_declarationBtn setTitle:@"报单" forState:UIControlStateNormal];
        [_declarationBtn setTitleColor:kRGB_Color(0xff, 0xff, 0xff) forState:UIControlStateNormal];
        [_declarationBtn setBackgroundColor:kMainColor];
        _declarationBtn.titleLabel.font = kFont15;
        _declarationBtn.layer.masksToBounds = YES;
        _declarationBtn.layer.cornerRadius = 4.f;
        [_declarationBtn addTarget:self action:@selector(declarationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _declarationBtn;
}

- (void)declarationButtonClick:(id)sender {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self showNavigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.customServiceView];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.scrollView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(16 , 16)];
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.frame = self.scrollView.bounds;
    shapeLayer.path = bezierPath.CGPath;
    self.scrollView.layer.mask = shapeLayer;
    
    UIView *firstView = [self createViewWithTitle:@"世联评估" iconImg:kImage(@"我的默认头像") price:@"102719元" totalPrice:@"1007万元" frame:CGRectMake(16, 16, kScreenWidth - 32, 112)];
    [self.scrollView addSubview:firstView];
    
    UIView *secondView = [self createViewWithTitle:@"首佳评估" iconImg:kImage(@"我的默认头像") price:@"102719元" totalPrice:@"1007万元" frame:CGRectMake(16, 16 * 2 + 112, kScreenWidth - 32, 112)];
    [self.scrollView addSubview:secondView];
    
    UIView *thirdView = [self createViewWithFrame:CGRectMake(16, 16 * 3 + 112 * 2, kScreenWidth - 32, 112) number:@"5"];
    [self.scrollView addSubview:thirdView];
    
    [self.scrollView addSubview:self.declarationBtn];
    self.declarationBtn.frame = CGRectMake(16, CGRectGetHeight(self.scrollView.frame) - 64, kScreenWidth - 32, 44);
    
    //self.scrollView.contentSize = CGSizeMake(kScreenWidth, 16 * 4 + 112 * 3 + 30);
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetHeight(self.scrollView.frame));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)createViewWithFrame:(CGRect)frame number:(NSString *)number {
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 8.f;
    bgView.backgroundColor = kRGB_Color(0xf8, 0xf8, 0xf8);
    
    UIView *clickView = [[UIView alloc] init];
    clickView.backgroundColor = [UIColor clearColor];
    clickView.layer.masksToBounds = YES;
    clickView.layer.cornerRadius = 4.f;
    clickView.layer.borderWidth = 0.5f;
    clickView.layer.borderColor = kMainColor.CGColor;
    [bgView addSubview:clickView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"点击查看仁达询值结果";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = kMainColor;
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [clickView addSubview:titleLabel];
    
    UILabel *subLabel = [[UILabel alloc] init];
    NSString *str = [NSString stringWithFormat:@"您当前询值次数还剩%@次", number];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{ NSFontAttributeName : kFont10, NSForegroundColorAttributeName : kRGB_Color(0x99, 0x99, 0x99) }];
    [attributeStr setAttributes:@{ NSFontAttributeName : kFont10, NSForegroundColorAttributeName : kRGB_Color(0xff, 0x52, 0x52)} range:NSMakeRange(9, 2)];
    subLabel.attributedText = attributeStr;
    subLabel.textAlignment = NSTextAlignmentCenter;
    [clickView addSubview:subLabel];
    
    [clickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bgView);
        make.size.mas_equalTo(CGSizeMake(230, 44));
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(clickView);
        make.top.equalTo(clickView).offset(5);
        make.height.equalTo(@15);
    }];
    
    [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleLabel);
        make.top.equalTo(titleLabel.mas_bottom).offset(4);
        make.height.equalTo(@10);
    }];
    return bgView;
}

- (UIView *)createViewWithTitle:(NSString *)title iconImg:(UIImage *)icon price:(NSString *)price totalPrice:(NSString *)totalPrice frame:(CGRect)frame {
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 8.f;
    bgView.backgroundColor = kRGB_Color(0xf8, 0xf8, 0xf8);
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = kRGB_Color(0x33, 0x33, 0x33);
    titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [bgView addSubview:titleLabel];
    
    UIImageView *iconImgView = [[UIImageView alloc] initWithImage:icon];
    [bgView addSubview:iconImgView];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.text = price;
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.textColor = kMainColor;
    priceLabel.font = [UIFont boldSystemFontOfSize:17];
    [bgView addSubview:priceLabel];
    
    UILabel *priceLabel2 = [[UILabel alloc] init];
    priceLabel2.text = @"评估单价";
    priceLabel2.textAlignment = NSTextAlignmentCenter;
    priceLabel2.textColor = kRGB_Color(0x99, 0x99, 0x99);
    priceLabel2.font = kFont10;
    [bgView addSubview:priceLabel2];
    
    UILabel *total_priceLabel = [[UILabel alloc] init];
    total_priceLabel.text = totalPrice;
    total_priceLabel.textAlignment = NSTextAlignmentCenter;
    total_priceLabel.textColor = kRGB_Color(0xff, 0x52, 0x52);
    total_priceLabel.font = [UIFont boldSystemFontOfSize:17];
    [bgView addSubview:total_priceLabel];
    
    UILabel *total_priceLabel2 = [[UILabel alloc] init];
    total_priceLabel2.text = @"评估总价";
    total_priceLabel2.textAlignment = NSTextAlignmentCenter;
    total_priceLabel2.textColor = kRGB_Color(0x99, 0x99, 0x99);
    total_priceLabel2.font = kFont10;
    [bgView addSubview:total_priceLabel2];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(16);
        make.centerX.equalTo(iconImgView);
        make.width.equalTo(@60);
        make.height.equalTo(@12);
    }];
    
    [iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(30);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.bottom.equalTo(bgView).offset(-16);
    }];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(40);
        make.size.mas_equalTo(CGSizeMake(90, 17));
        make.right.equalTo(total_priceLabel2.mas_left).offset(-40);
    }];
    
    [priceLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(priceLabel);
        make.top.equalTo(priceLabel.mas_bottom).offset(8);
        make.height.equalTo(@10);
    }];
    
    [total_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceLabel);
        make.size.mas_equalTo(CGSizeMake(90, 17));
        make.right.equalTo(bgView).offset(-20);
    }];
    
    [total_priceLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(total_priceLabel);
        make.top.equalTo(total_priceLabel.mas_bottom).offset(8);
        make.height.equalTo(@10);
    }];
    
    return bgView;
}
@end
