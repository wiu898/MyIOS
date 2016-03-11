//
//  SignatureViewController.m
//  PodTest
//
//  Created by 李超 on 15/12/22.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "SignatureViewController.h"
#import "UIDevice+JEsystemVersion.h"
#import <SVProgressHUD.h>

static NSString *const kupdateUserInfo = @"userinfo/updateuserinfo";

@interface SignatureViewController()

@property (strong, nonatomic) UITextField *signatureTextField;
@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) UIButton *naviBarLeftButton;

@end

@implementation SignatureViewController

- (UITextField *)signatureTextField{
    if (_signatureTextField == nil) {
        _signatureTextField = [[UITextField alloc]
            initWithFrame:CGRectMake(0, 20, kSystemWide, 80)];
        _signatureTextField.backgroundColor = [UIColor whiteColor];
        
        if ([AccountManager manager].userSignature) {
            _signatureTextField.text = [AccountManager manager].userSignature;
        }
    }
    return _signatureTextField;
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
    
    self.title = @"个性签名";
    self.view.backgroundColor = RGBColor(245, 247, 250);
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]
        initWithCustomView:self.naviBarRightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]
        initWithCustomView:self.naviBarLeftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.view addSubview:self.signatureTextField];
    
    [self.signatureTextField becomeFirstResponder];
}

- (void)clickLeft:(UIButton *)sender{
    if (self.signatureTextField.text == nil || self.signatureTextField.
        text.length ==0) {
        kShowFail(@"您还为填写信息");
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickRight:(UIButton *)sender{
    DYNSLog(@"上传");
    DYNSLog(@"usersignature = %@",self.signatureTextField.text);
    
    NSString *updateUserInfoUrl = [NSString stringWithFormat:BASEURL,
        kupdateUserInfo];
    
    NSDictionary *dicParam = @{@"signature":self.signatureTextField.text,
        @"userid":[AccountManager manager].userid};
    
    //网络请求
    [JENetwoking startDownLoadWithUrl:updateUserInfoUrl postParam:dicParam
        WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
            
            NSDictionary *dataParam = data;
            NSNumber *message = dataParam[@"type"];
            if (message.intValue == 1) {
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                [AccountManager saveUserSignature:self.signatureTextField.text];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:
                     kSignatureChange object:nil];
                
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:@"修改失败"];
                return;
            }
        }];
}

@end
