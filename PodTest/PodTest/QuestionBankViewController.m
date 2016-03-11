//
//  QuestionBankViewController.m
//  PodTest
//
//  Created by 李超 on 15/12/17.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "QuestionBankViewController.h"
#import <SVProgressHUD.h>
#import "ToolHeader.h"
#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>

// NJKWebViewProgress 加载进度条控件

@interface QuestionBankViewController ()<NJKWebViewProgressDelegate,UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NJKWebViewProgress *webviewProgress;
@property (strong, nonatomic) NJKWebViewProgressView *progressView;

@end

@implementation QuestionBankViewController

- (UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64,
            kSystemWide, kSystemHeight-64)];
        _webView.hidden = YES;
    }
    return _webView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    DYNSLog(@"request = %@", self.questionlisturl);
    
    [self.view addSubview:self.webView];
    
    _webviewProgress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = _webviewProgress;
    self.webviewProgress.webViewProxyDelegate = self;
    self.webviewProgress.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height,
       navigationBarBounds.size.width, progressBarHeight);
    
    self.progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    self.progressView.progressBarView.backgroundColor = MAINCOLOR;
    self.progressView.hidden = YES;
    
    NSString *urlString = self.questionlisturl;
    
    NSURLRequest *request = [[NSURLRequest alloc]
        initWithURL:[NSURL URLWithString:urlString]];
    
    [self.webView loadRequest:request];
    
}

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress{
   
    [self.progressView setProgress:progress animated:YES];

}

//开始加载的时候执行该方法
- (void)webViewDidStartLoad:(UIWebView *)webView{
    DYNSLog(@"startLoad");
    self.progressView.hidden = NO;
}

//加载完成的时候执行的方法
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    DYNSLog(@"finished");
    _webView.hidden = NO;
}

//加载出错的时候执行的方法
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    DYNSLog(@"error");
    [SVProgressHUD showErrorWithStatus:@"加载失败"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    NSString *string = [self.webView stringByEvaluatingJavaScriptFromString:@"save()"];
    DYNSLog(@"store = %@",string);
    [_progressView removeFromSuperview];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}


@end
