//
//  GainPasswordViewController.m
//  PodTest
//
//  Created by 李超 on 15/12/14.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "GainPasswordViewController.h"
#import <Masonry/Masonry.h>
#import <SVProgressHUD.h>
#import "ToolHeader.h"
#import "NSString+DY_MD5.h"

static NSString *const kchangePassword = @"kchangePassword";

static NSString *const kchangePasswordUrl = @"/userinfo/updatepwd";

@interface  GainPasswordViewController()

@property (strong ,nonatomic) UIButton *acccomplishButton;
@property (strong, nonatomic) UITextField *passWordTextField;
@property (strong, nonatomic) UITextField *affirmTextField;
@property (strong, nonatomic) UILabel *topLabel;
@property (strong, nonatomic) UIButton *goBackButton;

@end

@implementation GainPasswordViewController

- (UILabel *)topLabel{
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = [UIFont systemFontOfSize:18];
        _topLabel.textColor = RGBColor(51,51,51);
        _topLabel.text = @"更改密码";
    }
    return  _topLabel;
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
        [_goBackButton setTitleColor:[UIColor blackColor]
            forState:UIControlStateNormal];
        _goBackButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _goBackButton;
}

- (UIButton *)acccomplishButton{
    if (_acccomplishButton == nil) {
        _acccomplishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _acccomplishButton.backgroundColor = RGBColor(255,102,51);
        _acccomplishButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_acccomplishButton setTitleColor:[UIColor whiteColor]
            forState:UIControlStateNormal];
        [_acccomplishButton addTarget:self action:@selector(dealNext:)
            forControlEvents:UIControlEventTouchUpInside];
        [_acccomplishButton setTitle:@"完成"
            forState:UIControlStateNormal];
    }
    return _acccomplishButton;
}

- (UITextField *)passWordTextField{
    if (_passWordTextField == nil) {
        _passWordTextField = [[UITextField alloc] init];
        _passWordTextField.tag = 105;
        _passWordTextField.placeholder = @"    请输入新的密码";
        _passWordTextField.layer.borderColor = RGBColor(204,204,204).CGColor;
        _passWordTextField.layer.borderWidth = 1;
        _passWordTextField.font = [UIFont systemFontOfSize:15];
        _passWordTextField.textColor = RGBColor(153,153,153);
        _passWordTextField.secureTextEntry = YES;
    }
    return _passWordTextField;
}

- (UITextField *)affirmTextField{
    if (_affirmTextField == nil) {
        _affirmTextField = [[UITextField alloc] init];
        _affirmTextField.tag = 106;
        _affirmTextField.placeholder = @"     确认新密码";
        _affirmTextField.layer.borderColor = RGBColor(204,204,204).CGColor;
        _affirmTextField.layer.borderWidth =1;
        _affirmTextField.font = [UIFont systemFontOfSize:15];
        _affirmTextField.textColor = RGBColor(153,153,153);
        _affirmTextField.secureTextEntry = YES;
    }
    return _affirmTextField;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.topLabel];
    [self.view addSubview:self.passWordTextField];
    [self.view addSubview:self.acccomplishButton];
    [self.view addSubview:self.affirmTextField];
    [self.view addSubview:self.goBackButton];
    
    [self.goBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@50);
    }];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20);
        make.height.mas_equalTo(@50);
    }];
    
    [self.passWordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20+55);
        make.height.mas_equalTo(@44);
    }];
    
    [self.affirmTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.passWordTextField.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@44);
    }];
    
    [self.acccomplishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.affirmTextField.mas_bottom).with.offset(20);
        make.height.mas_equalTo(@44);
    }];
}

- (void)dealNext:(UIButton *)sender{
    if (![self.passWordTextField.text isEqualToString:self.affirmTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入相同密码"];
        return;
    }
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,kchangePasswordUrl];
    
    NSDictionary *param = @{@"smscode":self.confirmString,@"password":
        [self.passWordTextField.text DY_MD5],@"mobile":self.mobile};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:param WithMethod:
        JENetworkingRequestMethodPost withCompletion:^(id data) {
            NSDictionary *param = data;
            DYNSLog(@"param = %@",param[@"msg"]);
            NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
            if ([type isEqualToString:@"1"]) {
                kShowSuccess(@"修改成功");
                [self dismissViewControllerAnimated:YES completion:^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:
                         kchangePassword object:nil];
                }];
            }else{
                kShowFail(param[@"msg"]);
            }
        }];
}

- (void)dealGoBack:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
