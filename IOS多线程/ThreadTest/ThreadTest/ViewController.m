//
//  ViewController.m
//  ThreadTest
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
    
    //Thread初始化有三种方式
    
    //方法一
    [NSThread detachNewThreadSelector:@selector(Demo1) toTarget:self withObject:nil];
    
    //方法二
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(Demo2) object:nil];
    
    [thread start];  //启动线程
    
    //方法三 NSThread简单使用
    [self performSelectorInBackground:@selector(Demo3) withObject:nil];
    
   
    //在thread调用的方法中要使用autoreleasepool进行内存管理，否则容易内存泄露
    
    @autoreleasepool {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
