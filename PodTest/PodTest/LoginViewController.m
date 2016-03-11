//
//  LoginViewController.m
//  PodTest
//
//  Created by 李超 on 15/12/4.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import <SVProgressHUD.h>
#import <Masonry/Masonry.h>
#import "ToolHeader.h"
#import "RegisterViewController.h"
#import "ForgetViewController.h"
#import "AccountManager.h"
#import <JPush/APService.h>
#import "JENetwoking.h"
#import "NSString+DY_MD5.h"

static NSString *const kloginUrl = @"userinfo/userlogin";

static NSString *const kregisterUser = @"kregisterUser";

static NSString *const kmobileNum = @"mobile";

static NSString *const kpassword = @"password";

static NSString *const kuserType = @"usertype";

@interface LoginViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UITextField *phoneNumTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UIButton *forgetButton;
@property (strong, nonatomic) UIButton *registerButton;
@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UIButton *bottomButton;
@property (strong, nonatomic) UIImageView *rightImageView;
@property (strong, nonatomic) NSMutableDictionary *userParam;
@property (strong, nonatomic) UIView *bottomLineView;
@property (strong, nonatomic) UILabel *bottomLabel;

@end

@implementation LoginViewController

//登陆页面底部的划线
- (UIView *) bottomLineView{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(15, kSystemHeight-95, kSystemWide-30, 1)];
        _bottomLineView.backgroundColor = RGBColor(230,230,230);

    }
    return _bottomLineView;
}

//登陆页面底部Label
- (UILabel *) bottomLabel{
    if (_bottomLabel == nil) {
        _bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake((kSystemWide-30)/2-30/2, -15, 30, 30)];
        _bottomLabel.text = @"or";
        _bottomLabel.textColor = [UIColor blackColor];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.backgroundColor = [UIColor whiteColor];
    }
    return _bottomLabel;
}

//底部按钮图片
- (UIImageView *) rightImageView{
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"随便看看"];
    }
    return _rightImageView;
}

//登陆页面底部按钮
- (UIButton *) bottomButton{
    if (_bottomButton == nil) {
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomButton setTitle:@"先随便看看" forState:UIControlStateNormal];
        _bottomButton.layer.borderColor = RGBColor(253,86,50).CGColor;
        _bottomButton.layer.borderWidth = 1;
        [_bottomButton setTitleColor:RGBColor(255, 102, 51) forState:UIControlStateNormal];
        _bottomButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        //点击按钮方法
        [_bottomButton addTarget:self action:@selector(dealBottom:) forControlEvents:UIControlEventTouchUpInside];
        
        //按钮内部文字内边距
        [_bottomButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    }
    return _bottomButton;
}

//登陆框部分设置
- (UIView *) backGroundView{
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] init];
        
        //登陆信息边框
        _backGroundView.layer.borderColor = RGBColor(204, 204, 204).CGColor;
        _backGroundView.layer.borderWidth = 1;
        _backGroundView.userInteractionEnabled = YES;
    }
  return _backGroundView;
}

//账号密码之前的划线
- (UIView *) lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.layer.borderWidth = 1;
        _lineView.layer.borderColor = RGBColor(230, 230, 230).CGColor;
        
    }
    return _lineView;
}

//登陆界面logo
- (UIImageView *) logoImageView{
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.image = [UIImage imageNamed:@"logoImage.png"];
    }
    return _logoImageView;
}

//注册账号按钮
- (UIButton *) registerButton{
    if (_registerButton == nil) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.backgroundColor = [UIColor whiteColor];
        [_registerButton addTarget:self action:@selector(dealRegister:)
                  forControlEvents:UIControlEventTouchUpInside];
        [_registerButton setTitle:@"注册账号" forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_registerButton setTitleColor:RGBColor(255, 102, 51) forState:UIControlStateNormal];
    }
    return _registerButton;
}

//忘记密码按钮
- (UIButton *) forgetButton{
    if (_forgetButton == nil) {
        _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgetButton.backgroundColor = [UIColor whiteColor];
        [_forgetButton addTarget:self action:@selector(dealForget:)
                forControlEvents:UIControlEventTouchUpInside];
        [_forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        _forgetButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_forgetButton setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    }
    return _forgetButton;
}

//登陆按钮
- (UIButton *) loginButton{
    if (_loginButton == nil) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = RGBColor(255, 102, 51);
        
        [_loginButton addTarget:self action:@selector(dealLogin:)
               forControlEvents:UIControlEventTouchUpInside];
      
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
        [_loginButton setTitle:@"登陆" forState:UIControlStateNormal];
        
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    
    return _loginButton;
}

//账号登陆框
- (UITextField *) phoneNumTextField{
    if (_phoneNumTextField == nil) {
        _phoneNumTextField = [[UITextField alloc] init];
        
        _phoneNumTextField.delegate = self;
        
        _phoneNumTextField.font = [UIFont systemFontOfSize:15];
        _phoneNumTextField.textColor = RGBColor(51, 51, 51);
        _phoneNumTextField.placeholder = @" 请填写手机号";
        
        _phoneNumTextField.leftViewMode = UITextFieldViewModeAlways;
        
        UIImageView *leftView =[[UIImageView alloc] initWithFrame:CGRectMake(14, 0, 20, 20)];
        leftView.image = [UIImage imageNamed:@"账号"];
        _phoneNumTextField.leftView = leftView;
        
        _phoneNumTextField.tag = 100;
        
    }
    return _phoneNumTextField;
}

//密码登陆框
- (UITextField *) passwordTextField{
    if (_passwordTextField == nil) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.delegate = self;
        
        _passwordTextField.font = [UIFont systemFontOfSize:15];
        _passwordTextField.textColor = RGBColor(51,51,51);
        _passwordTextField.placeholder = @" 请填写密码";
        
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:
                        CGRectMake(14, 0, 20, 20)];
        leftView.image = [UIImage imageNamed:@"密码"];
        _passwordTextField.leftView = leftView;
        
        _passwordTextField.tag = 101;
        _passwordTextField.secureTextEntry = YES;  //设置密码格式
    }
    return _passwordTextField;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:
        @selector(DYdealRegister) name:kregisterUser object:nil];
    
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.backGroundView];
    
    [self.backGroundView addSubview:self.lineView];
    [self.backGroundView addSubview:self.phoneNumTextField];
    [self.backGroundView addSubview:self.passwordTextField];
    
    [self.view addSubview:self.forgetButton];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.bottomButton];
    
    [self.bottomButton addSubview:self.rightImageView];
    [self.view addSubview:self.bottomLineView];
    [self.bottomLineView addSubview:self.bottomLabel];
}

- (void)DYdealRegister {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealBottom:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealRegister:(UIButton *)sender{
    RegisterViewController *registerVc = [[RegisterViewController alloc] init];
    [self presentViewController:registerVc animated:YES
                     completion:nil];
}

- (void)dealForget:(UIButton *)sender{
    ForgetViewController *forgetVc = [[ForgetViewController alloc] init];
    [self presentViewController:forgetVc animated:YES completion:nil];
}

//登陆按钮方法实现
- (void)dealLogin:(UIButton *)sender{
    if (self.phoneNumTextField.text == nil || self.phoneNumTextField.text.length ==0) {
        [SVProgressHUD showInfoWithStatus:@"请输入手机号"];
        return;
    }
    
    if (self.passwordTextField.text ==nil || self.passwordTextField.text.length ==0) {
        [SVProgressHUD showInfoWithStatus:@"请输入密码"];
        return;
    }
    
    //网络请求
    [self.passwordTextField resignFirstResponder];
    [self.phoneNumTextField resignFirstResponder];
    [self.userParam setObject:@"1" forKey:kuserType];
    
    NSString *url = [NSString stringWithFormat:BASEURL,kloginUrl];
    DYNSLog(@"%@ %@",url,self.userParam);
    
    [SVProgressHUD show];
    [JENetwoking startDownLoadWithUrl:url postParam:self.userParam WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        NSDictionary *dataDic = data;
        NSString *type = [NSString stringWithFormat:@"%@",dataDic[@"type"]];
        
        NSLog(@"------------%@------------",type);
        
        if ([type isEqualToString:@"0"]) {
            [SVProgressHUD showErrorWithStatus:@"密码错误1"];
        }else if([type isEqualToString:@"1"]){
            [AccountManager configUserInformationWith:dataDic[@"data"]];
            [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
            [AccountManager saveUserName:self.phoneNumTextField.text
                andPassword:self.passwordTextField.text];
            
            if ([AccountManager manager].userid) {
                [APService setAlias:[AccountManager manager].userid callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
            
             [self loginWithUsername:[AccountManager manager].userid password:self.passwordTextField.text.DY_MD5];
            }
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

//点击登陆后的操作
- (void)loginWithUsername:(NSString *)username password:(NSString *)password{
    
   //  [self showHudInView:self.view hint:NSLocalizedString(@"login.ongoing", @"Is Login...")];
    
      //异步登陆账号
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:username
                                          password:password
                                          completion:
     ^(NSDictionary *loginInfo, EMError *error) {
       //  [self hideHud];
         if (loginInfo && !error) {
             DYNSLog(@"登录");
             //设置自动登录
             [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
             //旧数据转换(如果你的sdk是由2.1.2版本升级过来的需要加这句话)
             [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
             
             //获取群组列表
             // [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsList];
             
             EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager
                   pushNotificationOptions];
             options.nickname = [AccountManager manager].userName;
             options.displayStyle =
                   ePushNotificationDisplayStyle_messageSummary;
             
             //发送自动登录状态通知
//             [[NSNotificationCenter defaultCenter] postNotificationName:
//                 KNOTIFICATION_LOGINCHANGE object:@YES];
             
         }
                                              
     } onQueue:nil];
}

- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias{
    NSString *callbackString = [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n",
                                iResCode,tags,alias];
    DYNSLog(@"TagsAlias回调:%@",callbackString);
}

//手机号码校验
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag ==100) {
        NSString *phoneNum = textField.text;
        NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
        
        //用法类似SQL中的过滤
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        BOOL isMatch = [pred evaluateWithObject:phoneNum];
        
        if (!isMatch) {
            [SVProgressHUD showInfoWithStatus:@"请输入正确额手机号" maskType:
                SVProgressHUDMaskTypeBlack];
            return;
        }
        
        [self.userParam setObject:textField.text forKey:kmobileNum];
        
    }else if (textField.tag == 101){   //判断为密码输入框
        //MD5加密
        DYNSLog(@"password = %@",[textField.text DY_MD5]);
        [self.userParam setObject:[textField.text DY_MD5] forKey:kpassword];
    }
}


- (void) viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

#pragma make - 自动布局
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).with.offset(50);
        make.height.mas_equalTo(@90);
        make.width.mas_equalTo(@90);
    }];
    
    [self.backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-20);
        make.top.mas_equalTo(self.logoImageView.mas_bottom).with.offset(42);
        make.height.mas_equalTo(@80);
    }];
    
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).with.offset(0);
        
        make.right.mas_equalTo(self.backGroundView.mas_right).with.offset(0);
        
        make.top.mas_equalTo(self.backGroundView.mas_top).with.offset(0);
        
        make.height.mas_equalTo(@40);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).with.offset(0);
        
        make.right.mas_equalTo(self.backGroundView.mas_right).with.offset(0);
        
        make.top.mas_equalTo(self.phoneNumTextField.mas_bottom).with.offset(0);
        
        make.height.mas_equalTo(@40);
        
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backGroundView.mas_top).with.offset(40.5);
        make.left.mas_equalTo(self.backGroundView.mas_left).with.offset(0);
        make.right.mas_equalTo(self.backGroundView.mas_right).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        
        make.right.mas_equalTo(self.view.mas_right).with.offset(-20);
        
        make.top.mas_equalTo(self.backGroundView.mas_bottom).with.offset(20);
        
        make.height.mas_equalTo(@44);
        
    }];
    
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        make.top.mas_equalTo(self.loginButton.mas_bottom).with.offset(14);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@25);
    }];
    
    
    
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-32);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(@122);
        make.height.mas_equalTo(@34);
    }];
    
    
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.bottomButton.mas_top).offset(-50);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@25);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomButton.mas_centerY);
        make.right.mas_equalTo(self.bottomButton.mas_right).with.offset(-15);
        make.height.mas_equalTo(@15);
        make.width.mas_equalTo(@15);
    }];

    
}

@end
