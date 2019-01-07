//
//  HJDHomeBankViewController.m
//  HuiJinDai
//
//  Created by GXW on 2018/12/26.
//  Copyright © 2018 shanpx. All rights reserved.
//

#import "HJDHomeBankViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>


@interface HJDHomeBankViewController ()<UIWebViewDelegate>
@property(nonatomic, strong) UIWebView *webView;

@end

@implementation HJDHomeBankViewController

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight)];
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //后面是数字类型的工单id，不是工单编号
    NSString *str = [NSString stringWithFormat:@"%@%@%@", kAPIMainURL, @"wap/loan/register_bank/", self.order_id];
    
    //NSString *str = @"file:///Users/gengxiaowei/Desktop/test.html";
    
    
    [self.view addSubview:self.webView];
    
    NSURL *url = [[NSURL alloc] initWithString:str];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //获取当前页面的title
    NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self setNavTitle:title];
    
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"close"] = ^{
        
        NSLog(@"-----js close()");
    };
}
@end
