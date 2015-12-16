//
//  ViewController3.m
//  GCDtest
//
//  Created by 李超 on 15/12/15.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewController3.h"

@interface ViewController3()

@end
//同步函数往并发队列中添加任务
@implementation ViewController3

- (void)viewDidLoad{
     [super viewDidLoad];
    
    //打印主线程
    NSLog(@"主线程----%@",[NSThread mainThread]);
    
    //创建并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    
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
