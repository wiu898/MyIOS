//
//  ViewController.m
//  AutonLayout自动布局
//
//  Created by 李超 on 15/11/26.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) UIView *subView;

@end

@implementation ViewController

- (UIView *) subView{
    if (_subView == nil) {
        _subView = [[UIView alloc] init];
        _subView.backgroundColor = [UIColor redColor];
        //使用Auto Layout约束,禁止将Autoresizing Mask转换为约束
        [_subView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _subView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"first";
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.view.frame = [UIApplication sharedApplication].keyWindow.frame;
    
    _subView = self.subView;
    
    [self.view addSubview:_subView];
    
    //子view的上边距离父view上边缘40像素
    NSLayoutConstraint *contraint1 = [NSLayoutConstraint constraintWithItem:_subView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:40.0];
    
    //子view的左边距离父view左边缘40像素
    NSLayoutConstraint *contraint2 = [NSLayoutConstraint constraintWithItem:_subView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:40.0];
    
    //子view的下边距离父view下边缘40像素
    NSLayoutConstraint *contraint3 = [NSLayoutConstraint constraintWithItem:_subView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-90.0];
    
    //子view的右边距离父view右边缘40像素
    NSLayoutConstraint *contraint4 = [NSLayoutConstraint constraintWithItem:_subView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-40.0];
    
    NSArray *array = [NSArray arrayWithObjects:contraint1,contraint2,contraint3,contraint4, nil];
    
    [self.view addConstraints:array];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
