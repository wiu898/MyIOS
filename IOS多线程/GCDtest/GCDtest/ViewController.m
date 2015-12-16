//
//  ViewController.m
//  GCDtest
//
//  Created by 李超 on 15/12/15.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //异步并发队列
    
    //1.获得全局并发队列
    dispatch_queue_t MyQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    
    //2.添加任务到队列中，就可以执行任务
    //异步函数：具备开启新线程的能力
    
    dispatch_async(MyQueue, ^{
        NSLog(@"下载图片1----%@",[NSThread currentThread]);
    });
    
    dispatch_async(MyQueue, ^{
        NSLog(@"下载图片2----%@",[NSThread currentThread]);
    });
    
    dispatch_async(MyQueue, ^{
        NSLog(@"下载图片3----%@",[NSThread currentThread]);
    });
    
    //打印主线程
    NSLog(@"主线程----%@",[NSThread mainThread]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
