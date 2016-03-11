//
//  BaseContainViewController.m
//  PodTest
//
//  Created by 李超 on 15/12/4.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "BaseContainViewController.h"
#import <SVProgressHUD.h>
#import "LoginViewController.h"
#import "UIView+CalculateUIView.h"
#import "AccountManager.h"

@interface BaseContainViewController ()<UIScrollViewDelegate>
@property (copy, nonatomic) NSArray *items;
@property (strong, nonatomic) UIScrollView *scrollView;
@end

@implementation BaseContainViewController

- (UIScrollView *) scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:
            CGRectMake(0,0,self.view.calculateFrameWithWide,self.view.calculateFrameWithHeight)];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
       
        //事件可以正常的传递给该视图图像
        //当设为NO的时候，用户触发的事件，如触摸，键盘等，将会被该视图忽略，并且该视图对象也会从响应队列中移除
        _scrollView.userInteractionEnabled = YES;
    }
    return _scrollView;
}

- (id)initWIthChildViewControllerItems:(NSArray *)itemsVc{
    if (self == [super init]) {
        _items = itemsVc;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //此属性默认为YES，这样如果有一个UIScrollView或者子类，那么会自动留出空白
    //但是每个UIViewController只能有唯一一个UIScrollerView或者其子类，如果超过一个将这个属性设置为NO
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createScrollView];
    
    [self addChildVc];
    
}

- (void)createScrollView{
    self.scrollView.contentSize =CGSizeMake(self.view.calculateFrameWithWide*_items.count
               ,self.view.calculateFrameWithHeight);
    [self.view addSubview:self.scrollView];
}

- (void)addChildVc{
    [self.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = (UIViewController *)obj;
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self]; // 通知child父子关系建立完毕
    }];
    
    UIViewController *vc = self.childViewControllers.firstObject;
    vc.view.frame = CGRectMake(0, 0,self.scrollView.calculateFrameWithWide,self.scrollView.calculateFrameWithHeight-64);
    [self.scrollView addSubview:vc.view];
    
}

//滑动触发的事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
}

//滑动停止时调用的方法，手触摸时执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

//滚动动画停止时执行
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    if(scrollView.contentOffset.x > self.view.calculateFrameWithWide && ![AccountManager isLogin]){
        DYNSLog(@"scrollView");
        scrollView.contentOffset = CGPointMake(kSystemWide,0);
        LoginViewController *login = [[LoginViewController alloc] init];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:nil];
        return;
    }
    
//    if ([[AcountManager manager].userApplystate isEqualToString:@"0"] && scrollView.contentOffset.x > self.view.calculateFrameWithWide) {
//        scrollView.contentOffset = CGPointMake(kSystemWide, 0);
//        
//        SignUpListViewController *signUpList = [[SignUpListViewController alloc] init];
//        UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//        [nav pushViewController:signUpList animated:YES];
//        return;
//    }

    
    NSUInteger index = scrollView.contentOffset.x/self.view.calculateFrameWithWide;
    UIViewController *vc = self.childViewControllers[index];
    
    if ([_delegate respondsToSelector:@selector(horizontalScrollPageIndex:)]) {
        [_delegate horizontalScrollPageIndex:index];
    }
    
    if (vc.view.superview) {
        return;
    }else{
   
        vc.view.frame = CGRectMake(self.scrollView.calculateFrameWithX+
            (index*self.view.calculateFrameWithWide),0 ,self.scrollView.calculateFrameWithWide,
                        self.scrollView.calculateFrameWithHeight-64);
    }
    [self.scrollView addSubview:vc.view];
    
}

- (void)replaceVcWithIndex:(NSUInteger)index{
    if (index >=2 && ![AccountManager isLogin]) {
        LoginViewController *login = [[LoginViewController alloc] init];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:nil];
    }
    
//    if ([[AccountManager manager].userApplystate isEqualToString:@"0"] && index>=2) {
//        return;
//    }
    
    [self.scrollView setContentOffset:CGPointMake(
                    index*self.scrollView.calculateFrameWithWide,0) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
