//
//  ViewController.m
//  UIAlertController
//
//  Created by 李超 on 15/12/21.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (UIButton *)button{
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor cyanColor];
        [_button setTitle:@"点击" forState:UIControlStateNormal];
        _button.layer.cornerRadius = 2;
        [_button setTitleColor:[UIColor redColor]
            forState:UIControlStateNormal];
        
        [_button addTarget:self action:@selector(dealAction) forControlEvents:UIControlEventTouchUpInside];
        
        _button.frame = CGRectMake(110, 100, 100, 40);
    }
    return _button;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"1";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.button];
    
}

- (void)dealAction{
    NSLog(@"显示弹窗");
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题"
        message:@"这是UIAlertController的默认样式"
        preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
        actionWithTitle:@"取消"
        style:UIAlertActionStyleCancel
        handler:^(UIAlertAction *action){
            NSLog(@"取消");
        }];
    
    UIAlertAction *okAction = [UIAlertAction
        actionWithTitle:@"确定"
        style:UIAlertActionStyleDefault
        handler:^(UIAlertAction *action){
            NSLog(@"确定");
        }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    /*  为alertController添加一个输入框
      
     [alertController addTextFieldWithConfigurationHandler:^(UITextField *  _Nonnull textField) {
        textField.backgroundColor = [UIColor orangeColor];
    }];
   
   */
    
    [self presentViewController:alertController
                       animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
