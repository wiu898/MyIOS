//
//  ViewController2.m
//  GCDtest
//
//  Created by 李超 on 15/12/15.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2()

@end

//异步函数往串行队列中添加任务
@implementation ViewController2

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //打印主线程
    NSLog(@"主线程----%@",[NSThread mainThread]);
    
    //创建串行队列
    //第一个参数为串行队列的名称,C语言标示符
    //第二个参数为队列的属性，一般来说串行队列不需要赋值任何属性
    dispatch_queue_t queue = dispatch_queue_create("wending",NULL);
    
    //添加任务到异步队列中
    dispatch_async(queue, ^{
        NSLog(@"下载图片1----%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"下载图片2----%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"下载图片3----%@",[NSThread currentThread]);
    });
    
}

@end
