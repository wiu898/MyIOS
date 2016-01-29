//
//  UIScrollViewController.m
//  UIScrollview
//
//  Created by 李超 on 15/11/6.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "UIScrollViewController.h"

@interface UIScrollViewController ()<UIScrollViewAccessibilityDelegate,UIScrollViewDelegate>

@end

@implementation UIScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    
    //是否支持滑动最顶端
    scrollView.scrollsToTop = YES;
    
    //设置代理
    scrollView.delegate = self;
    
    //设置大小
    scrollView.contentSize = CGSizeMake(320,460*10);
    
    //是否同时运动
    scrollView.directionalLockEnabled = YES;
    
    [scrollView flashScrollIndicators];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 40)];
    
    label.backgroundColor = [UIColor yellowColor];
    
    label.text = @"学习scrolleview";
    
    [self.view addSubview:scrollView];
    
    [scrollView addSubview:label];
    
}


//开始拖动

//- (void) scrollViewDidScroll:(UIScrollView *)scrollView
//
//{
//    NSLog(@"aaaaa");
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
