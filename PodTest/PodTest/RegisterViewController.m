//
//  RegisterViewController.m
//  PodTest
//
//  Created by 李超 on 15/12/8.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "RegisterViewController.h"
#import <SVProgressHUD.h>
#import <Masonry/Masonry.h>
#import "MainViewController.h"
#import "ToolHeader.h"
#import "NSString+DY_MD5.h"
#import <JPush/APService.h>

static NSString *const kregisterUser = @"kregisterUser";

static NSString *const kregisterUrl = @"userinfo/signup";

static NSString *const kcodeGainUrl = @"code";

@interface RegisterViewController ()<UITextFieldDelegate>

@property (strong, nonatomic)UIButton *goBackButton;
@property (strong, nonatomic)UIButton *sendButton;
@property (strong, nonatomic)UIButton *registerButton;
@property (strong, nonatomic)UITextField *phoneTextField;
@property (strong, nonatomic)UITextField *authCodeTextField;
@property (strong, nonatomic)UITextField *passWordTextField;
@property (strong, nonatomic)UITextField *affirmTextField;
@property (strong, nonatomic)UITextField *invitationTextField;
@property (strong, nonatomic)UILabel *noteLabel;
@property (strong, nonatomic)UILabel *topLabel;

@property (strong, nonatomic)NSMutableDictionary *paramsPost;

@end

@implementation RegisterViewController

- (NSMutableDictionary *)paramsPost{
    if (_paramsPost == nil) {
        _paramsPost = [[NSMutableDictionary alloc] init];
    }
    return _paramsPost;
}

- (UILabel *)topLabel{
    if (_topLabel ==nil) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = [UIFont boldSystemFontOfSize:18];
        _topLabel.textColor = RGBColor(51,51,51);
        _topLabel.text = @"注册";
    }
   return _topLabel;
}

- (UILabel *)noteLabel{
    if (_noteLabel == nil) {
        _noteLabel = [[UILabel alloc] init];
        _noteLabel.textAlignment = NSTextAlignmentCenter;
        _noteLabel.backgroundColor = [UIColor whiteColor];
        [_noteLabel setTextColor:RGBColor(153,153,153)];
        [_noteLabel setText:@"点击注册则表示您同意《用户服务协议》"];
        _noteLabel.font = [UIFont systemFontOfSize:13];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                    action:@selector(clickTap:)];
        [_noteLabel addGestureRecognizer:tap];
    }
    return _noteLabel;
}

- (UIButton *)goBackButton{
    if (_goBackButton == nil) {
        _goBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goBackButton setBackgroundImage:[UIImage imageNamed:@"返回"]
                        forState:UIControlStateNormal];
        [_goBackButton setBackgroundImage:[UIImage imageNamed:@"返回_click"]
                        forState:UIControlStateNormal];
        [_goBackButton addTarget:self action:@selector(dealGoBack:)
                forControlEvents:UIControlEventTouchUpInside];
        
        [_goBackButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _goBackButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _goBackButton;
}

- (UIButton *)sendButton{
    if (_sendButton == nil) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.backgroundColor = RGBColor(255,102,51);
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [_sendButton addTarget:self action:@selector(dealSend:)
                forControlEvents:UIControlEventTouchUpInside];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    }
    return _sendButton;
}

- (UIButton *)registerButton{
    if (_registerButton == nil) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.backgroundColor = RGBColor(255,102,51);
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(dealRegister:)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UITextField *)phoneTextField{
    if (_phoneTextField == nil) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.delegate = self;
        _phoneTextField.tag = 102;
        _phoneTextField.placeholder = @"    手机号";
        _phoneTextField.layer.borderColor = RGBColor(204,204,204).CGColor;
        _phoneTextField.layer.borderWidth = 1;
        _phoneTextField.font = [UIFont systemFontOfSize:15];
        _phoneTextField.textColor = RGBColor(153,153,153);
    }
    return _phoneTextField;
}

- (UITextField *)passWordTextField{
    if (_passWordTextField == nil) {
        _passWordTextField = [[UITextField alloc] init];
        _passWordTextField.delegate = self;
        _passWordTextField.tag = 103;
        _passWordTextField.placeholder = @"   密码";
        _passWordTextField.layer.borderColor = RGBColor(204,204,204).CGColor;
        _passWordTextField.layer.borderWidth = 1;
        _passWordTextField.font = [UIFont systemFontOfSize:15];
        _passWordTextField.textColor = RGBColor(153,153,153);
        _passWordTextField.secureTextEntry = YES;
    }
    return _passWordTextField;

}

- (UITextField *)authCodeTextField{
    if (_authCodeTextField == nil) {
        _authCodeTextField = [[UITextField alloc] init];
        _authCodeTextField.delegate =self;
        _authCodeTextField.tag = 104;
        _authCodeTextField.placeholder = @"   验证码";
        _authCodeTextField.layer.borderColor = RGBColor(204,204,204).CGColor;
        _authCodeTextField.layer.borderWidth = 1;
        _authCodeTextField.font = [UIFont systemFontOfSize:15];
        _authCodeTextField.textColor = RGBColor(153,153,153);
    }
    return _authCodeTextField;
}

- (UITextField *)affirmTextField{
    if (_affirmTextField == nil) {
        _affirmTextField = [[UITextField alloc]init];
        _affirmTextField.delegate = self;
        _affirmTextField.tag = 105;
        _affirmTextField.placeholder = @"    确认密码";
        _affirmTextField.layer.borderColor = RGBColor(204, 204, 204).CGColor;
        _affirmTextField.layer.borderWidth = 1;
        _affirmTextField.font  = [UIFont systemFontOfSize:15];
        _affirmTextField.textColor = RGBColor(153, 153, 153);
        _affirmTextField.secureTextEntry = YES;
    }
    return _affirmTextField;
}

- (UITextField *)invitationTextField{
    if (_invitationTextField == nil) {
        _invitationTextField = [[UITextField alloc]init];
        _invitationTextField.delegate = self;
        _invitationTextField.tag = 106;
        _invitationTextField.placeholder = @"    输入邀请码,获得奖励";
        _invitationTextField.layer.borderColor = RGBColor(204, 204, 204).CGColor;
        _invitationTextField.layer.borderWidth = 1;
        _invitationTextField.font  = [UIFont systemFontOfSize:15];
        _invitationTextField.textColor = RGBColor(153, 153, 153);
    }
    return _invitationTextField;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [[IQKeyboardManager sharedManager] disableToolbarInViewControllerClass:self.class];
    
    [self.view addSubview:self.topLabel];
    
    [self.view addSubview:self.goBackButton];
    
    [self.view addSubview:self.sendButton];
    
    [self.view addSubview:self.registerButton];
    
    [self.view addSubview:self.phoneTextField];
    
    [self.view addSubview:self.authCodeTextField];
    
    [self.view addSubview:self.passWordTextField];

    [self.view addSubview:self.invitationTextField];
    
    [self.view addSubview:self.affirmTextField];
    
    [self.view addSubview:self.noteLabel];
}

#pragma make : 自动布局

- (void)viewWillLayoutSubviews{

    [super viewWillLayoutSubviews];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20);
        make.height.mas_equalTo(@50);
    }];
    
    [self.goBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@50);
    }];
    
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.goBackButton.mas_bottom).with.offset(7);
        make.height.mas_equalTo(@44);
    }];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@117);
    }];
    
    [self.authCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.sendButton.mas_left).with.offset(-10);
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@44);
    }];
    
    [self.passWordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.authCodeTextField.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@40);
    }];
    
    [self.affirmTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.passWordTextField.mas_bottom).offset(10);
        make.height.mas_equalTo(@40);
    }];
    
    [self.invitationTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.affirmTextField.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@40);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.invitationTextField.mas_bottom).with.offset(20);
        make.height.mas_equalTo(@44);
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        make.top.mas_equalTo(self.registerButton.mas_bottom).with.offset(20);
        make.height.mas_equalTo(@25);
        make.width.mas_equalTo(@250);
    }];

}

//http://www.ifanying.com/userAgreement.html 用户协议
//http://www.ifanying.com/coachAgreement.html 教练协议

- (void)clickTap:(UITapGestureRecognizer *)tap{

}

#pragma mark - 按钮点击事件

#define TIME 60

- (void)dealGoBack:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealSend:(UIButton *)sender{
    NSLog(@"发送验证码");
    
    if (self.phoneTextField.text == nil || self.phoneTextField.text.length<=0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号" maskType:SVProgressHUDMaskTypeGradient];
        return;
    }else{
        
        NSLog(@"开始发送");
        NSString *urlString = [NSString stringWithFormat:@"code/%@",self.phoneTextField.text];
        NSString *codeUrl = [NSString stringWithFormat:BASEURL,urlString];
        
        NSLog(@"%@",codeUrl);
        
        [JENetwoking startDownLoadWithUrl:codeUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
        }];
    }
    
    sender.userInteractionEnabled = NO;
    __block int count = TIME;
    
    //多线程部分
    dispatch_queue_t myQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, myQueue);
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);

    dispatch_source_set_event_handler(timer, ^{
        if (count <0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.sendButton.titleLabel.font = [UIFont systemFontOfSize:15];
                self.sendButton.backgroundColor = MAINCOLOR;
                [self.sendButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.sendButton.userInteractionEnabled = YES;
            });
        }else{
            NSString *str = [NSString stringWithFormat:@"剩余(%d)s",count];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.sendButton.backgroundColor = RGBColor(204,204,204);
                [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.sendButton setTitle:str forState:UIControlStateNormal];
            });
            count --;
        }
    });
    dispatch_resume(timer);
    
}

- (void)dealRegister:(UIButton *)sender{
    NSString *phoneNum = self.phoneTextField.text;
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [pred evaluateWithObject:phoneNum];
    
    if (!isMatch) {
        [SVProgressHUD showErrorWithStatus:@"情输入正确的手机号" maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    
    [self.paramsPost setObject:phoneNum forKey:@"mobile"];
    
    if (self.authCodeTextField.text.length <=0 || self.authCodeTextField.text ==nil) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码" maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    
    [self.paramsPost setObject:self.authCodeTextField.text forKey:@"smscode"];
    
    if (self.passWordTextField.text == nil ||self.passWordTextField.text.length <=0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码" maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    
    if (self.affirmTextField.text == nil || self.affirmTextField.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入确认密码" maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    
    NSString *passwordString = nil;
    if (![self.passWordTextField.text isEqualToString:self.affirmTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一样" maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    passwordString = self.passWordTextField.text;
    [self.paramsPost setObject:passwordString forKey:@"password"];
    
    //网络请求
    if (self.invitationTextField.text.length >0 && self.invitationTextField.text != nil) {
        [self.paramsPost setObject:self.invitationTextField.text forKey:@"referrerCode"];
    }
    
    [self.paramsPost setObject:@"1" forKey:@"usertype"];
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,kregisterUrl];
    [SVProgressHUD show];
    [JENetwoking startDownLoadWithUrl:urlString postParam:self.paramsPost WithMethod:
        JENetworkingRequestMethodPost   withCompletion:^(id data) {
            DYNSLog(@"data = %@",data);
            NSDictionary *dataDic = data;
            
            NSString *type = [NSString stringWithFormat:@"%@",dataDic[@"type"]];
            if ([type isEqualToString:@"0"]) {
                
                [SVProgressHUD showErrorWithStatus:dataDic[@"msg"]];
                 
            }else if ([type isEqualToString:@"1"]){
                     [AccountManager configUserInformationWith:dataDic[@"data"]];
                     [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                     [AccountManager saveUserName:self.phoneTextField.text andPassword:self.passWordTextField.text];
                    
                     if([AccountManager manager].userid){
                         [APService setAlias:[AccountManager manager].userid callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
                         [self registerUserId:[AccountManager manager].userid withPassword:self.passWordTextField.text.DY_MD5];
                     }
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginSuccess" object:nil];
                     [self dismissViewControllerAnimated:YES completion:^{
                         [[NSNotificationCenter defaultCenter] postNotificationName:kregisterUser object:nil];
                     }];
                 }
                 
                  }];
    
}

//注册账号
- (void)registerUserId:(NSString *)userid withPassword:(NSString *)password {
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:userid
                                          password:password
                                          withCompletion:
     ^(NSString *username, NSString *password, EMError *error) {
         if (!error) {
             [self loginWithUsername:userid password:password];
         }
                                
     } onQueue:nil];
   
}

//登陆后操作
- (void)loginWithUsername:(NSString *)username password:(NSString *)password
{
   //[self showHudInView:self.view hint:NSLocalizedString(@"login.ongoing", @"Is Login...")];
    
    //异步登陆账号
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:username
                                                        password:password
                                                      completion:
     ^(NSDictionary *loginInfo, EMError *error) {
       //  [self hideHud];
         if (loginInfo && !error) {
             DYNSLog(@"登录");
             
             //设置是否自动登录
             [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
             
             // 旧数据转换 (如果您的sdk是由2.1.2版本升级过来的，需要加这句话)
             [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
             
             //获取数据库中数据
             [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
             
             //获取群组列表
             //             [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsList];
             
             EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
             options.nickname = [AccountManager manager].userName;
             options.displayStyle = ePushNotificationDisplayStyle_messageSummary;
             
             
             //发送自动登陆状态通知
         //    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
             
             //保存最近一次登录用户名
         }
         else
         {
             switch (error.errorCode)
             {
                 case EMErrorNotFound:
                  //   TTAlertNoTitle(error.description);
                     break;
                 case EMErrorNetworkNotConnected:
                  //   TTAlertNoTitle(NSLocalizedString(@"error.connectNetworkFail", @"No network connection!"));
                     break;
                 case EMErrorServerNotReachable:
                  //   TTAlertNoTitle(NSLocalizedString(@"error.connectServerFail", @"Connect to the server failed!"));
                     break;
                 case EMErrorServerAuthenticationFailure:
                  //   TTAlertNoTitle(error.description);
                     break;
                 case EMErrorServerTimeout:
                  //   TTAlertNoTitle(NSLocalizedString(@"error.connectServerTimeout", @"Connect to the server timed out!"));
                     break;
                 default:
                  //   TTAlertNoTitle(NSLocalizedString(@"login.fail", @"Login failure"));
                     break;
             }
         }
     } onQueue:nil];

}




- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    NSString *callbackString =
    [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
     tags, alias];
    
    DYNSLog(@"TagsAlias回调:%@", callbackString);
}


@end
