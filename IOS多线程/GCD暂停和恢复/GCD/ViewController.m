//
//  ViewController.m
//  GCD
//
//  Created by 李超 on 16/1/29.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) UIButton *button;

@end


@implementation ViewController

- (UIView *)backGroundView{
    if(_backGroundView == nil){
        _backGroundView = [[UIView alloc] initWithFrame:self.view.frame];
        _backGroundView.backgroundColor = [UIColor cyanColor];
    }
    return _backGroundView;
}

- (UIButton *)button{
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(110, 180, 100, 50);
        _button.backgroundColor = [UIColor orangeColor];
        [_button setTitle:@"点击" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button.layer.cornerRadius = 2;
        [_button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.backGroundView];
    [self.backGroundView addSubview:self.button];
}

- (void)click:(UIButton *)sender{
    NSLog(@"进入按钮方法");
    
    dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
   
    //挂起可以暂停线程，但是不能保证立即停止队列上正在运行的block，暂停的是后续的线程
    //block1已经在运行所以无法停止，但是block要等唤醒后才能执行
    
    //提交第一个block延迟2秒
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"After 2s");
    });
    
    //提交第二个block
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"queue2 for 5s");
    });
    
    //挂起队列
    NSLog(@"sleep");
    dispatch_suspend(queue);
    //延时5s
    [NSThread sleepForTimeInterval:10];
    NSLog(@"Sleep 10s");
    
    //恢复队列
    NSLog(@"resume");
    dispatch_resume(queue);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
