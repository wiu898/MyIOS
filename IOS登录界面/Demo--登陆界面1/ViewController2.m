//
//  ViewController2ViewController.m
//  Demo--登陆界面1-Test
//
//  Created by 李超 on 15/11/11.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewController2.h"
#import "UserInfo.h"

@interface ViewController2()
    
@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  //  self.title = @"second";
    
    UIView *views = [[UIView alloc] initWithFrame:self.view.frame];
    
    views.backgroundColor = [UIColor whiteColor];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:self.view.frame];
    
    [image setImage:[UIImage imageNamed:@"1.jpeg"]];
    
  
    
    UITextField *userAccount = [[UITextField alloc] initWithFrame:CGRectMake(19, 180, self.view.frame.size.width-40,50)];
    
    userAccount.text = self.user.userAccount;
    
    [[userAccount layer] setCornerRadius:5.0];
    
    [userAccount setBackgroundColor:[UIColor whiteColor]];
    
    UITextField *userPassword = [[UITextField alloc] initWithFrame:CGRectMake(19,220, self.view.frame.size.width-40, 50)];
    
    [userPassword setBackgroundColor:[UIColor whiteColor]];
    
    userPassword.text = self.user.userPassword;
    
    [image addSubview:userAccount];
    [image addSubview:userPassword];
    
    [views addSubview:image];
    
    [self.view addSubview:views];
    
  //  [self.view addSubview:userAccount];
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
