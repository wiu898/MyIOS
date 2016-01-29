//
//  ViewController.m
//  Demo--登陆界面1-Test
//
//  Created by 李超 on 15/11/9.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewController.h"
#import "UIViewLine.h"
#import "ViewController2.h"
#import "UserInfo.h"

@interface ViewController ()
{
    UITextField *account;
    UITextField *password;
    UIButton *loginButton;
    UIViewLine *background;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"登陆";
    
    //半透明
  //  [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:51/255.0 green:204/255.0 blue:255/255.0 alpha:1]];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:self.view.frame];
    // 开启交互
    image.userInteractionEnabled= YES;
    
    [image setImage:[UIImage imageNamed:@"3.jpeg"]];
    

    background = [[UIViewLine alloc] initWithFrame:CGRectMake(20, 200, self.view.frame.size.width-40, 100)];

    [background setBackgroundColor:[UIColor whiteColor]];
    
    
    [[background layer] setCornerRadius:5];
    
    [[background layer] setMasksToBounds:YES];
    
    
  //  [background addSubview:image];
    
    [image addSubview:background];
    
    [self.view addSubview:image];
    
    
    
    //账号输入框
    
    account = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-40,50)];
    
    [account setBackgroundColor:[UIColor whiteColor]];
    
     account.placeholder = [NSString stringWithFormat:@"Email"];
    
    //圆角大小
    
    [[account layer] setCornerRadius:5.0];
    
    [background addSubview:account];
    
    
    //密码登陆框
    password = [[UITextField alloc] initWithFrame:CGRectMake(10,50,self.view.frame.size.width-40,50)];
    
    password.backgroundColor = [UIColor whiteColor];
    
    password.placeholder = [NSString stringWithFormat:@"Password"];
    
    //圆角大小
    password.layer.cornerRadius = 5.0;
    
    [background addSubview:password];
    
    
    //登陆按钮
    loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    
    [loginButton setFrame:CGRectMake(20, 320, self.view.frame.size.width-40, 50)];
    
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    
    [loginButton setBackgroundColor:[UIColor colorWithRed:51/255.0 green:102/255.0 blue:255/255.0 alpha:1]];
    
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [loginButton addTarget:self action:@selector(Go) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginButton];

    
}

//键盘回收
- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [account resignFirstResponder];
    [password resignFirstResponder];
}

- (void) Go
{
    NSLog(@"%ld",account.text.length);
    
    if(account.text.length == 0 || password.text.length == 0){
                
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"账号或密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction *actions){
        
            NSLog(@"您输入的密码或账号为空！");
            return;
            
        }];
        
        [alertController addAction:action];
        
        [self presentViewController:alertController animated:YES completion:nil];
    
        
//       UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"账号或密码不能为空"
//            delegate: nil
//            cancelButtonTitle:@"确定"
//            otherButtonTitles:nil];
//        
//        [alert show];
   
    }
    
    UserInfo *user = [[UserInfo alloc] init];
    
    user.userAccount = account.text;
    
    user.userPassword = password.text;
    
    ViewController2 *vc2 = [[ViewController2 alloc] init];
    
//     ViewController2 *viewController2 = [[ViewController2 alloc] initWithNibName:@"ViewController2" bundle:[NSBundle mainBundle]];
    
    vc2.user = user;
    
    //跳转页面
    [self.navigationController pushViewController:vc2 animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
