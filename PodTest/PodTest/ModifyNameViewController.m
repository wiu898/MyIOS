//
//  ModifyNameViewController.m
//  PodTest
//
//  Created by 李超 on 15/12/22.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ModifyNameViewController.h"
#import "UIDevice+JEsystemVersion.h"
#import <SVProgressHUD.h>

static NSString *const kupdateUserInfo = @"userinfo/updateuserinfo";

@interface ModifyNameViewController()

@property (strong, nonatomic) UITextField *modifyNameTextField;
@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) UIButton *naviBarLeftButton;

@end

@implementation ModifyNameViewController

- (UITextField *)modifyNameTextField{
    if (_modifyNameTextField == nil) {
        _modifyNameTextField = [[UITextField alloc] initWithFrame:
            CGRectMake(0, 20, kSystemWide, 44)];
        _modifyNameTextField.backgroundColor = [UIColor whiteColor];
        if ([AccountManager manager].userName) {
            _modifyNameTextField.text = [AccountManager manager].userName;
        }
    }
    return _modifyNameTextField;
}

- (UIButton *)naviBarRightButton{
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"完成"
            withTitleColor:MAINCOLOR withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.frame = CGRectMake(0, 0, 44, 44);
        
        [_naviBarRightButton addTarget:self action:@selector(clickRight:)
            forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarRightButton;
}

- (UIButton *)naviBarLeftButton{
    if (_naviBarLeftButton == nil) {
        _naviBarLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_naviBarLeftButton setTitle:@"取消" forState:UIControlStateNormal];
        [_naviBarLeftButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        _naviBarLeftButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _naviBarLeftButton.frame = CGRectMake(0, 0, 44, 44);
        
        [_naviBarLeftButton addTarget:self action:@selector(clickLeft:)
            forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarLeftButton;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0) {
        //指定边缘延伸的方向
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"名字";
    self.view.backgroundColor = RGBColor(245,247,250);
    
    //右侧工具栏按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]
        initWithCustomView:self.naviBarRightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //左侧按钮
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]
        initWithCustomView:self.naviBarLeftButton];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.view addSubview:self.modifyNameTextField];
    
    [self.modifyNameTextField becomeFirstResponder];
}

- (void)clickLeft:(UIButton *)sender{
    if (self.modifyNameTextField.text == nil || self.modifyNameTextField.
        text.length == 0) {
        kShowFail(@"您还为填写信息");
    }
    [self.navigationController popViewControllerAnimated:YES];
}

//保存修改的姓名
- (void)clickRight:(UIButton *)sender{
    DYNSLog(@"上传");
    DYNSLog(@"username = %@",self.modifyNameTextField.text);
    
    NSString *updateUserInfoUrl = [NSString stringWithFormat:BASEURL,kupdateUserInfo];
    
    NSDictionary *dictParam =
        @{@"name":self.modifyNameTextField.text,@"userid":[AccountManager manager].userid};
    
    //网络请求
    [JENetwoking startDownLoadWithUrl:updateUserInfoUrl postParam:dictParam
        WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
           
            NSDictionary *dataParam = data;
            NSNumber *message = dataParam[@"type"];
            if (message.intValue == 1) {
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                [AccountManager saveUserName:self.modifyNameTextField.text];
               
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:kmodifyNameChange
                    object:nil];
                
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:@"修改失败"];
                return;
            }
        }];
}

@end
