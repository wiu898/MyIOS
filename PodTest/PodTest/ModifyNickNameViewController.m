//
//  ModifyNickNameViewController.m
//  PodTest
//
//  Created by 李超 on 15/12/22.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ModifyNickNameViewController.h"
#import "UIDevice+JEsystemVersion.h"
#import <SVProgressHUD.h>

static NSString *const kupdateUserInfo = @"userinfo/updateuserinfo";

@interface ModifyNickNameViewController()

@property (strong, nonatomic) UITextField *modifyNameTextField;
@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) UIButton *naviBarLeftButton;

@end

@implementation ModifyNickNameViewController

- (UITextField *)modifyNameTextField{
    if (_modifyNameTextField == nil) {
        _modifyNameTextField = [[UITextField alloc]
            initWithFrame:CGRectMake(0, 20, kSystemWide, 44)];
        _modifyNameTextField.backgroundColor = [UIColor whiteColor];
        if ([AccountManager manager].userNickName) {
            _modifyNameTextField.text = [AccountManager manager].userNickName;
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
        _naviBarLeftButton = [WMUITool initWithTitle:@"取消"
            withTitleColor:MAINCOLOR withTitleFont:[UIFont systemFontOfSize:16]];
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
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.title = @"昵称";
    self.view.backgroundColor = RGBColor(245, 247, 250);
    
    UIBarButtonItem *rigthItem = [[UIBarButtonItem alloc]
        initWithCustomView:self.naviBarRightButton];
    
    self.navigationItem.rightBarButtonItem = rigthItem;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]
        initWithCustomView:self.naviBarLeftButton];
    
    self.navigationItem.leftBarButtonItem = leftItem;
 
    [self.view addSubview:self.modifyNameTextField];
    
    //第一响应的事件,直接弹出键盘
    [self.modifyNameTextField becomeFirstResponder];
}

- (void)clickLeft:(UIButton *)sender{
    if (self.modifyNameTextField.text == nil || self.modifyNameTextField.
        text.length == 0) {
        kShowFail(@"您还未填写信息");
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickRight:(UIButton *)sender{
    DYNSLog(@"上传");
    
    DYNSLog(@"usernickname = %@", self.modifyNameTextField.text);
    
    //接口url
    NSString *updateUserInfoUrl = [NSString stringWithFormat:BASEURL,kupdateUserInfo];
    
    //传递参数
    NSDictionary *dicParam =
    @{@"nickname":self.modifyNameTextField.text,@"userid":[AccountManager manager].userid};
    
    //网络请求
    [JENetwoking startDownLoadWithUrl:updateUserInfoUrl postParam:dicParam
        WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
            //取出传递的参数
            NSDictionary *dataParam = data;
            //执行状态
            NSNumber *message = dataParam[@"type"];
            if (message.intValue ==1) {
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                [AccountManager saveUserNickName:self.modifyNameTextField.text];
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:
                    kmodifyNickNameChange object:nil];
                //跳转页面
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:@"修改失败"];
                return;
            }
        }];
}



























@end
