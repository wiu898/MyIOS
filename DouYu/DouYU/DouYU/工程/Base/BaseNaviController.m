//
//  BaseNaviController.m
//  DouYU
//
//  Created by 李超 on 16/3/22.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "BaseNaviController.h"
#import "Public.h"

@implementation BaseNaviController

- (void)viewDidLoad{

    [super viewDidLoad];
    
   // self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 80);
    
    self.navigationBar.barTintColor = TabBar_T_Color;
    
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
