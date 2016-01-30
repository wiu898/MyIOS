//
//  ViewController2.m
//  AutonLayout自动布局
//
//  Created by 李超 on 15/11/26.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@property (nonatomic,strong) UIView *subView;

@end

@implementation ViewController2

- (UIView *) subView{
    if (_subView == nil) {
        _subView = [[UIView alloc] init];
        _subView.backgroundColor = [UIColor orangeColor];
        [_subView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _subView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"second";
    
    self.view.frame = [UIApplication sharedApplication].keyWindow.bounds;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _subView = self.subView;
    
    [self.view addSubview:_subView];
    
    //子view的中心横坐标等于父view的中心横坐标
    NSLayoutConstraint *constrant1 = [NSLayoutConstraint constraintWithItem:_subView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    
    //子view的中心纵坐标等于父view的中心纵坐标
    NSLayoutConstraint *constrant2 = [NSLayoutConstraint constraintWithItem:_subView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    
    //子view的宽度为300
    NSLayoutConstraint *constrant3 = [NSLayoutConstraint constraintWithItem:_subView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:300.0];
    
    //子view的高度为200
    NSLayoutConstraint *constrant4 = [NSLayoutConstraint constraintWithItem:_subView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:200.0];
    
    NSArray *array = [NSArray arrayWithObjects:constrant1,constrant2,constrant3,constrant4,nil];
    
    [self.view addConstraints:array];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
