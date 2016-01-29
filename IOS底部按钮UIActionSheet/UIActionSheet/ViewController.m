//
//  ViewController.m
//  UIActionSheet
//
//  Created by 李超 on 15/12/21.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic)UIButton *button;

@end

@implementation ViewController

- (UIButton *)button{
    if(_button == nil){
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(110, 100, 100, 40);
        _button.backgroundColor = [UIColor cyanColor];
        _button.layer.cornerRadius = 3;
        [_button setTitle:@"点击" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor redColor]
            forState:UIControlStateNormal];
        
        [_button addTarget:self action:@selector(testActionSheet) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"first";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.button];

}

- (void)testActionSheet{
    
    NSLog(@"弹出按钮");

    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Are you sure"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"确定"
                                  otherButtonTitles:@"第一项",@"第二项",nil];
    
   // [actionSheet addButtonWithTitle:@"第三项"];
    [actionSheet showInView:self.view];
}

//点击按钮事件
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%li",buttonIndex);
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        NSLog(@"取消");
        return;
    }
    switch (buttonIndex) {
        case 0:{
            NSLog(@"确定");
            break;
        }
        case 1:{
            NSLog(@"第一项");
            break;
        }
        case 2:{
            NSLog(@"第二项");
            break;
        }
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
