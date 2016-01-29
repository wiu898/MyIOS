//
//  ViewController.m
//  UISlider
//
//  Created by 李超 on 15/11/6.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:self.view.frame];
    
    //设定滑块范围
    slider.minimumValue = 0.0;
  //  slider.maximumValue = 50.0;
    
   // slider.value =0.5;
    
    
    [self.view addSubview:slider];
    
    //添加到导航栏
//    [self.navigationItem.titleView addSubview:slider];
    
    [slider setMinimumTrackImage:[UIImage imageNamed:@"1.jpeg"] forState:UIControlStateNormal];
    
    [slider setMaximumTrackImage:[UIImage imageNamed:@"5.jpeg"] forState:UIControlStateNormal];
    
    [[UIApplication sharedApplication].keyWindow addSubview:slider];
   // [slider addTarget:self action:@selector(valueChanged) forControlEvents:];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) valueChanged
{
    NSLog(@"aaaaa");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
