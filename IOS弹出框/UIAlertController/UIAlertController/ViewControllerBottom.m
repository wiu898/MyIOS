//
//  ViewControllerBottom.m
//  UIAlertController
//
//  Created by 李超 on 15/12/21.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewControllerBottom.h"

@interface ViewControllerBottom()

@property (strong, nonatomic) UIButton *button;

@end

@implementation ViewControllerBottom

- (UIButton *)button{
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor blackColor];
        [_button setTitle:@"点击" forState:UIControlStateNormal];
        _button.layer.cornerRadius = 2;
        [_button setTitleColor:[UIColor redColor]
                      forState:UIControlStateNormal];
        
        [_button addTarget:self action:@selector(dealAction) forControlEvents:UIControlEventTouchUpInside];
        
        _button.frame = CGRectMake(110, 100, 100, 40);
    }
    return _button;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"2";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.button];
}

- (void)dealAction{
    
    UIAlertController *alertController = [UIAlertController        alertControllerWithTitle:@"底部AlertController"
        message:@"Are you ok?"
        preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction
       actionWithTitle:@"取消"
       style:UIAlertActionStyleCancel
       handler:^(UIAlertAction * _Nonnull action) {
           NSLog(@"取消");
       }];
    
    UIAlertAction *okAction = [UIAlertAction
        actionWithTitle:@"确定"
        style:UIAlertActionStyleDestructive
        handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"确定");
        }];
    
    UIAlertAction *otherAction = [UIAlertAction
        actionWithTitle:@"第一项"
        style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"第一项");
        }];
    
    [alertController addAction:okAction];
    [alertController addAction:otherAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController
        animated:YES completion:nil];
}

@end
