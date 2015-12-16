//
//  ViewController.m
//  UIPageControlText
//
//  Created by 李超 on 15/11/20.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewController.h"
#import "PageControl.h"

@interface ViewController ()

@end

@implementation ViewController

//初始化图片数组
- (NSArray *) dataArray{
    
    if (imageNames == nil){
        
        imageNames = [[NSArray alloc] initWithObjects:@"1.jpeg",@"5.jpeg",@"3.jpeg",@"2.jpg",nil];

    }

      return imageNames;
}

//- (UIScrollView *) helpScrView
//{
//    if (helpScrView == nil) {
//        
//        helpScrView = [[UIScrollView alloc] init];
//        
//        helpScrView.pagingEnabled = YES;   //设置YES按页面滑动
//        
//        helpScrView.bounces = NO;      // 取消UIScrollView的弹性属性
//        
//        [helpScrView setDelegate:self];
//        
//        //取消UIScrollView自己的进度条
//        helpScrView.showsHorizontalScrollIndicator = NO;
//        
//    }
//    
//    return helpScrView;
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect bounds = self.view.frame;    //获得图片区域
    
    //加载图片的数组
    imageNames = [self dataArray];
    
    //创建UIScrollView
    helpScrView = [[UIScrollView alloc] initWithFrame:
           CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, 600)];
    
    
    //设置内容的尺寸，这里图片是4张,所以宽度设置为界面宽度*4，高度和界面一致
    [helpScrView setContentSize:CGSizeMake(bounds.size.width*4, bounds.size.height)];
    
    helpScrView.pagingEnabled = YES;   //设置YES按页面滑动
    
    helpScrView.bounces = NO;      // 取消UIScrollView的弹性属性
    
    [helpScrView setDelegate:self];
    
    //取消UIScrollView自己的进度条
    helpScrView.showsHorizontalScrollIndicator = NO;
    
    
    //将最后一张图片放到首页位置
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:
                CGRectMake(0,bounds.origin.y,bounds.size.width,bounds.size.height)];
    
    [imgView setImage:[UIImage imageNamed:[imageNames objectAtIndex:[imageNames count] - 1 ]]];
    
    [helpScrView addSubview:imgView];
    
    
    
    for (int i =0; i<imageNames.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                CGRectMake(i*bounds.size.width, bounds.origin.y, bounds.size.width, bounds.size.height)];
        
        [imageView setImage:[UIImage imageNamed:imageNames[i]]];
        
        [helpScrView addSubview:imageView];
        
    }
    
    //将第一张图片放到最后一张
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:
         CGRectMake((imageNames.count)*bounds.size.width,bounds.origin.y,bounds.size.width,bounds.size.height)];
    
    [imgView1 setImage:[UIImage imageNamed:imageNames[0]]];
    
    [helpScrView addSubview:imgView1];
    
    
    [self.view addSubview:helpScrView];
    
    //创建UIPageControl
    
    pageControl = [[UIPageControl alloc] initWithFrame:
          CGRectMake(0,460,bounds.size.width,30)];
    
    pageControl.numberOfPages = 4;  //总图片页数
    
    timeCount = 0;
    
    pageControl.currentPage = timeCount;   //当前页
    
    pageControl.userInteractionEnabled = YES;
    
    //点击函数
    [pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:
           UIControlEventValueChanged];
    
    [self.view addSubview:pageControl];
    
    
    //定时器部分
    
     myTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
    
    
}

//定时器控制图片自动变化

- (void) scrollTimer {
    
    NSLog(@"进入定时器方法");
    
    timeCount++;
    
    if (timeCount >= 4) {      //如果到最后一页从头开始
        pageControl.currentPage = 0;
        timeCount = 0;
    }
    
    pageControl.currentPage = timeCount;

    CGSize viewSize = helpScrView.frame.size;
    
    CGRect rect = CGRectMake(timeCount*viewSize.width,0,viewSize.width,viewSize.height);
    
    [helpScrView scrollRectToVisible:rect animated:YES];


}

//点击函数

- (void) pageTurn:(UIPageControl *) sender
{

    NSLog(@"进入点击方法");
    //UIScrollView 滑动显示
    CGSize viewSize = helpScrView.frame.size;
    
    CGRect rect = CGRectMake(sender.currentPage*viewSize.width,0,viewSize.width,viewSize.height);
    
    [helpScrView scrollRectToVisible:rect animated:YES];
    
}

//滑动事件

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    //手动滑动的时候暂时关闭定时器
    [myTimer invalidate];
    
    myTimer = nil;
    
    myTimer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self
                selector:@selector(scrollTimer) userInfo:nil repeats:YES];
    
    //更新当前页
    CGPoint offset = scrollView.contentOffset;
    
    CGRect bounds = scrollView.frame;
    
    [pageControl setCurrentPage:offset.x/bounds.size.width];
    
    NSLog(@"%f",(offset.x/bounds.size.width));
    
    NSLog(@"%ld",imageNames.count);
    
    if ((offset.x/bounds.size.width) +1 >= imageNames.count) {
        timeCount = 0;
    }else{
        
        if ((offset.x/bounds.size.width) >timeCount) {
            timeCount ++;
        }
        
        if ((offset.x / bounds.size.width) < timeCount) {
            timeCount --;
        }

    }
    
    
    NSLog(@"%f",offset.x / bounds.size.width);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
