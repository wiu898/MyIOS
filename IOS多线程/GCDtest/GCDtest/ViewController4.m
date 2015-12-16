//
//  ViewController4.m
//  GCDtest
//
//  Created by 李超 on 15/12/15.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewController4.h"

@interface ViewController4()

@end

@implementation ViewController4

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //打印主线程
    NSLog(@"主线程----%@",[NSThread mainThread]);
    
    //创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("wending", NULL);
    
    //添加任务到队列中执行
    dispatch_sync(queue, ^{
        NSLog(@"下载图片1----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"下载图片2----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"下载图片3----%@",[NSThread currentThread]);
    });
}

@end
