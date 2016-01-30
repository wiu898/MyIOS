//
//  ViewController2.m
//  UITableView练习
//
//  Created by 李超 on 15/11/16.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewController2.h"


@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    
    view.backgroundColor = [UIColor orangeColor];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(60, 200, 200, 70)];
    
    textField.backgroundColor = [UIColor whiteColor];
    
    NSString *ss = @"您点击的是";
    
    textField.text = [NSString stringWithFormat:@"%@:%@",ss,self.info];
    
    [view addSubview:textField];
    
    [self.view addSubview:view];
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
