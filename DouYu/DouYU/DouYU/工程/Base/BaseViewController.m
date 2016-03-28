//
//  BaseViewController.m
//  DouYU
//
//  Created by 李超 on 16/3/22.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController()

@property (strong, nonatomic) UIButton *leftButton;

@property (strong, nonatomic) UIButton *rightButton;

@property (strong, nonatomic) UIImageView *titleView;

@end

@implementation BaseViewController

- (UIButton *)leftButton{

    if (_leftButton == nil) {
        
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_leftButton setImage:[UIImage imageNamed:@"Image_scan"] forState:UIControlStateNormal];
        
        _leftButton.frame = CGRectMake(0, 0, 25, 25);
        
        [_leftButton addTarget:self action:@selector(SaoMiao) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton{
 
    if (_rightButton == nil) {
        
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _rightButton.frame = CGRectMake(0, 0, 25, 25);
        
        [_rightButton setImage:[UIImage imageNamed:@"btn_search"] forState:UIControlStateNormal];
        
        [_rightButton addTarget:self action:@selector(Search) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (UIImageView *)titleView{

    if (_titleView == nil) {
        
        _titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 104, 28)];
        
        _titleView.image = [UIImage imageNamed:@"logo"];
    }
    return _titleView;
}

- (void)viewDidLoad{

    [super viewDidLoad];
    
    //顶部导航栏左按钮
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
    
    //顶部导航栏右按钮
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    
    //顶部导航栏背景图片
    
    self.navigationItem.titleView = self.titleView;
    
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self setHidesBottomBarWhenPushed:NO];
}

-(void)SaoMiao
{
    NSLog(@"SaoMiao");
}

-(void)Search
{
    NSLog(@"Search");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
