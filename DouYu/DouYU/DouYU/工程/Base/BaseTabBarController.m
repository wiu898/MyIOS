//
//  BaseTabBarController.m
//  DouYU
//
//  Created by 李超 on 16/3/22.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNaviController.h"
#import "RecommendController.h"
#import "ColumnController.h"
#import "OnlineViewController.h"
#import "MineController.h"
#import "Public.h"

@implementation BaseTabBarController

- (void)viewDidLoad{
  
    [super viewDidLoad];
    
    UIView *backView = [[UIView alloc] initWithFrame:self.view.frame];
    
    backView.backgroundColor = [UIColor whiteColor];
    
    [self.tabBar insertSubview:backView atIndex:0];
    
    self.tabBar.opaque = YES;
    
    self.tabBar.tintColor = TabBar_T_Color;
    
    //底部导航栏
    [self initChildViewControllers];
}

- (void)initChildViewControllers{

    NSMutableArray *childVCArray = [[NSMutableArray alloc]
        initWithCapacity:4];
    
    //底部导航栏
    
    //推荐
    RecommendController *recommendVC = [[RecommendController alloc] init];
    [recommendVC.tabBarItem setTitle:@"推荐"];
    [recommendVC.tabBarItem setImage:[UIImage
        imageNamed:@"btn_home_normal"]];
    [recommendVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"btn_home_selected"]];
    
    BaseNaviController *recommendNavC = [[BaseNaviController alloc] initWithRootViewController:recommendVC];
    
    [childVCArray addObject:recommendNavC];
    
    //栏目
    ColumnController *columnVC = [[ColumnController alloc] init];
    [columnVC.tabBarItem setTitle:@"栏目"];
    [columnVC.tabBarItem setImage:[UIImage
        imageNamed:@"btn_column_normal"]];
    [columnVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"btn_column_selected"]];
    
    BaseNaviController *columnNavC = [[BaseNaviController alloc] initWithRootViewController:columnVC];
    
    [childVCArray addObject:columnNavC];
    
    //直播
    OnlineViewController *onlineVC = [[OnlineViewController alloc] init];
    [onlineVC.tabBarItem setTitle:@"直播"];
    [onlineVC.tabBarItem setImage:[UIImage imageNamed:@"btn_live_normal"]];
    [onlineVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"btn_live_selected"]];
    
    BaseNaviController *onlineNavC = [[BaseNaviController alloc] initWithRootViewController:onlineVC];
    
    [childVCArray addObject:onlineNavC];
    
    //我的
    MineController *mineVC = [[MineController alloc] init];
    [mineVC.tabBarItem setTitle:@"我的"];
    [mineVC.tabBarItem setImage:[UIImage imageNamed:@"btn_user_normal"]];
    [mineVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"btn_user_selected"]];
    
    BaseNaviController *mineNavC = [[BaseNaviController alloc] initWithRootViewController:mineVC];
    
    [childVCArray addObject:mineNavC];
    
    [self setViewControllers:childVCArray];
}

- (void)didReceiveMemoryWarning{

    [super didReceiveMemoryWarning];
}

@end
