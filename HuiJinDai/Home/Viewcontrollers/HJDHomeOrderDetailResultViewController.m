//
//  HJDHomeOrderDetailResultViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/10/21.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeOrderDetailResultViewController.h"
#import "HJDNetAPIManager.h"

@interface HJDHomeOrderDetailResultViewController ()<UIDocumentInteractionControllerDelegate, UIWebViewDelegate>
@property(nonatomic, strong) UIWebView *webView;
@end

@implementation HJDHomeOrderDetailResultViewController

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
    
    [self.view addSubview:self.webView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.wordUrl]]];
}


/**
 下载文件
 
 @param docPath 文件路径
 @param fileName 文件名
 */
- (void)downloadDocxWithDocPath:(NSString *)docPath fileName:(NSString *)fileName {
    [MBProgressHUD showMessage:@"正在下载文件"];
    NSString *urlString = @"http://66.6.66.111:8888/UploadFile/";
    urlString = [urlString stringByAppendingString:fileName];
    
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *savePath = @"";
    
    [[HJDNetAPIManager sharedManager] downloadWithUrl:urlString tofilePath:savePath progress:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        NSLog(@"%lld   %lld",totalBytesRead, totalBytesExpectedToRead);
    } success:^(NSURLSessionDownloadTask *task, NSURLResponse *response) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:@"下载完成,正在打开"];
        [self openDocxWithPath:savePath];
    } failure:^(NSURLSessionDownloadTask *task, NSError *error) {
        
    }];
}

- (void)readWord:(NSString *)docPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths lastObject];

    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:docPath]; //docPath为文件名
    if ([fileManager fileExistsAtPath:filePath]) {
        [self openDocxWithPath:filePath];
    } else {
        //文件不存在,要下载
        [self downloadDocxWithDocPath:documentsDirectory fileName:docPath];
    }
}

/**
 打开文件
 
 @param filePath 文件路径
 */
- (void)openDocxWithPath:(NSString *)filePath {
    UIDocumentInteractionController *doc= [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filePath]];
    doc.delegate = self;
    [doc presentPreviewAnimated:YES];
}

//本人使用的是UIDocumentInteractionController,还可以使用QuickLook或者webView打开文件,后面会贴小demo.设置UIDocumentInteractionController代理,添加代理方法.
#pragma mark - UIDocumentInteractionControllerDelegate
//必须实现的代理方法 预览窗口以模式窗口的形式显示，因此需要在该方法中返回一个view controller ，作为预览窗口的父窗口。如果你不实现该方法，或者在该方法中返回 nil，或者你返回的 view controller 无法呈现模式窗口，则该预览窗口不会显示。
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    return self;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller {
    return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController*)controller {
    
    return CGRectMake(0, 30, kScreenWidth, kScreenHeight - 30);
}




@end
