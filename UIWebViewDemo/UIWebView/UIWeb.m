//
//  UIWeb.m
//  UIWebView
//
//  Created by 李超 on 15/11/25.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "UIWeb.h"

@interface UIWeb()

//@property (nonatomic,copy) NSString *pathUrl;

@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) UIView *views;
@property (nonatomic,strong) UIActivityIndicatorView *activityView;

@end

@implementation UIWeb


#define kSystemWidth [UIScreen mainScreen].bounds.size.width

#define kSystemHeight [UIScreen mainScreen].bounds.size.height

- (UIWebView *) webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,kSystemWidth,kSystemHeight)];
        _webView.backgroundColor = [UIColor clearColor];
        [_webView setUserInteractionEnabled:NO];
        _webView.opaque = NO;
        [_webView setDelegate:self];
    }
    return _webView;
}

- (UIView *) views{
    if (_views ==nil ) {
        _views = [[UIView alloc] init];
        _views.backgroundColor = [UIColor blackColor];
        [_views setTag:103];
        [_views setAlpha:0.8];
    }
    return _views;

}

- (UIActivityIndicatorView *) activityView{

    if (_activityView == nil) {
        _activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
        [_activityView setCenter:_views.center];
        [_activityView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _activityView;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_pathUrl]];
    
//    [self.view addSubview:self.views];
//    [self.views addSubview:self.activityView];
    [self.view addSubview:self.webView];
    
    [_webView loadRequest:request];  //加载网页
    
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"开始加载");
   // [_activityView startAnimating];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"加载结束");
    _webView.hidden = NO;
//    [_activityView stopAnimating];
//    UIView *view = (UIView *)[self.view viewWithTag:103];
//    [view removeFromSuperview];
}


//加载出错后执行的方法
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
