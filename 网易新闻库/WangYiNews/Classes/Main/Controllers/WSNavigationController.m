//
//  WSNavigationController.m
//  WangYiNews
//
//  Created by 李超 on 16/2/18.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "WSNavigationController.h"
#define kNavigationBarColor [UIColor colorWithRed:213/255.0 green:40/255.0 blue:43/255.0 alpha:1]

@interface WSNavigationController()

@end

@implementation WSNavigationController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationBar.tintColor = [UIColor whiteColor];  //控制颜色
    
   [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_navigation_background"] forBarMetrics:UIBarMetricsDefault];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //隐藏底部任务栏
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

@end
