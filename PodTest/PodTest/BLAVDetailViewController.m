//
//  BLAVDetailViewController.m
//  PodTest
//
//  Created by 李超 on 15/12/25.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "BLAVDetailViewController.h"
#import <SVProgressHUD.h>
#import "ToolHeader.h"
#import "AppDelegate.h"
#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>

@interface BLAVDetailViewController()<UIWebViewDelegate,
    NJKWebViewProgressDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NJKWebViewProgress *webviewProgress;
@property (strong, nonatomic) NJKWebViewProgressView *progressView;

@end

@implementation BLAVDetailViewController

- (UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64,
            kSystemWide, kSystemHeight - 64)];
        _webView.delegate = self;
    }
    return _webView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.webView];
    
    _webviewProgress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = _webviewProgress;
    self.webviewProgress.webViewProxyDelegate = self;
    self.webviewProgress.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.0f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height,
        navigationBarBounds.size.width, progressBarHeight);
    
    self.progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    self.progressView.progressBarView.backgroundColor = MAINCOLOR;
    self.progressView.hidden = YES;
    
    NSString *urlString = self.avPlayerString;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:
        [NSURL URLWithString:urlString]];
    
    [self.webView loadRequest:request];
}

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:
     (float)progress{
    
    [self.progressView setProgress:progress animated:YES];

}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    DYNSLog(@"startLoad");
    self.progressView.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    DYNSLog(@"finishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"加载失败"];
    DYNSLog(@"error");
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    NSString *string = [self.webView
        stringByEvaluatingJavaScriptFromString:@"save()"];
    DYNSLog(@"store = %@",string);
    [_progressView removeFromSuperview];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}
@end
