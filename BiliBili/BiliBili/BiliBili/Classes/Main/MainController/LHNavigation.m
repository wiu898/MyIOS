//
//  LHNavigation.m
//  BiliBili
//
//  Created by 李超 on 16/3/28.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHNavigation.h"

@interface LHNavigation() <UIGestureRecognizerDelegate>

@end

@implementation LHNavigation

- (void)viewDidLoad{

    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{

    if (self.childViewControllers.count == 1) {
        
        return false;
    }
    return true;
}

- (UIStatusBarStyle)preferredStatusBarStyle{

    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning{
   
    [super didReceiveMemoryWarning];
}

@end
