//
//  ViewController.m
//  UIPageControl控件滑动练习
//
//  Created by 李超 on 15/11/18.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect bounds = self.view.frame;  //获取图片区域
    
    //加载蒙版图片,限于篇幅,这里显示一张图片的方法
    UIImageView *imageView1 =[[UIImageView alloc] initWithFrame:
        CGRectMake(0, bounds.origin.y, bounds.size.width,
        bounds.size.height)] ;     //大小设为主界面大小
    
    
    [imageView1 setImage:[UIImage imageNamed:@"1.jpeg"]];
    
  //  imageView1.alpha = 0.5f;   //透明度设置成50%
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(1*bounds.size.width, bounds.origin.y, bounds.size.width, bounds.size.height)];
    
    [imageView2 setImage:[UIImage imageNamed:@"5.jpeg"]];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(2*bounds.size.width, bounds.origin.y, bounds.size.width, bounds.size.height)];
    
    [imageView3 setImage:[UIImage imageNamed:@"3.jpeg"]];
    
    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(3*bounds.size.width, bounds.origin.y, bounds.size.width, bounds.size.height)];
    
    [imageView4 setImage:[UIImage imageNamed:@"2.jpg"]];

    
    //创建UIScrollView
    helpScrView = [[UIScrollView alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, 600)];
    
    //设置内容的尺寸，这里图片是4张,所以宽度设置为界面宽度*4，高度和界面一致
    [helpScrView setContentSize:
        CGSizeMake(bounds.size.width*4, bounds.size.height)];
    
    helpScrView.pagingEnabled = YES;  //设置YES时,会按页滑动
    
    helpScrView.bounces = NO;  //取消UIScrollView的弹性属性
    
    [helpScrView setDelegate:self];
    
    //取消UIScrollView自己的进度条
    helpScrView.showsHorizontalScrollIndicator = NO;
    
    [helpScrView addSubview:imageView1];
    
    [helpScrView addSubview:imageView2];
    
    [helpScrView addSubview:imageView3];
    
    [helpScrView addSubview:imageView4];
    
    [self.view addSubview:helpScrView];   //将UIScrollView添加到主界面上
    
    
    //创建UIPageControl
    
    pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,460,bounds.size.width,30)];     //位置在屏幕的最下方
    
 //   pageCtrl.backgroundColor = [UIColor cyanColor];
    
    pageCtrl.numberOfPages = 4;    //总图片的页数
    
    pageCtrl.currentPage = 0;      //当前页
    
    pageCtrl.userInteractionEnabled = YES;
    
    [pageCtrl addTarget:self action:@selector(pageTurn:)
        forControlEvents:UIControlEventValueChanged];     //点击的响应函数
    
    [self.view addSubview:pageCtrl];
    
}


//点击触发函数实现

- (void) pageTurn:(UIPageControl *) sender
{
    NSLog(@"进入点击方法");
    //UIScrollView做出相应的滑动显示
    CGSize viewSize = helpScrView.frame.size;
    
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0,viewSize.width, viewSize.height);
    
  //  [helpScrView setContentOffset:CGPointMake(rect.origin.x, rect.origin.y)  animated:YES];
    
    [helpScrView scrollRectToVisible:rect animated:YES];

}


//滑动调用的函数

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    //更新当前页
    CGPoint offset = scrollView.contentOffset;
    
    CGRect bounds = scrollView.frame;
    
    [pageCtrl setCurrentPage:offset.x / bounds.size.width];
    
    NSLog(@"%f",offset.x / bounds.size.width);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
