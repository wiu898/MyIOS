//
//  ViewController.m
//  NSOperationTest
//
//  Created by 李超 on 15/12/16.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //实例化操作队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(opAction) object:nil];
    
    //两种启动方式
   // [op1 start];   //第一种
    
    [queue addOperation:op1];   //第二种
    
    //模拟下载网络图像
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@",[NSThread currentThread]);
    }];
    
    //可以设置任务执行顺序，同时可以跨操作队列   指定依赖关系
    [op2 addDependency:op1];
    
    
    //使用主队列的两种方式
    
  //  [NSOperationQueue mainQueue] addOperation ^{
    
  //  };    //方式一
    
    [[NSOperationQueue mainQueue] addOperation:op1];   //方式二
    
    //设置同时并发的线程数量
    [queue setMaxConcurrentOperationCount:2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
