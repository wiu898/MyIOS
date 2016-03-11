//
//  GenderViewController.m
//  PodTest
//
//  Created by 李超 on 15/12/22.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "GenderViewController.h"
#import "UIDevice+JEsystemVersion.h"
#import <SVProgressHUD.h>

static NSString *const kupdateUserInfo = @"userinfo/updateuserinfo";

@interface GenderViewController()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) UITextField *genderTextField;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) UIButton *naviBarLeftButton;
@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation GenderViewController

- (UITextField *)genderTextField{
    if (_genderTextField == nil) {
        _genderTextField = [[UITextField alloc] initWithFrame:
            CGRectMake(0, 20, kSystemWide, 44)];
        
        _genderTextField.backgroundColor = [UIColor whiteColor];
    }
    return _genderTextField;
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

- (UIPickerView *)pickerView{
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = RGBColor(245, 247, 250);
    }
    return _pickerView;
}

- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = @[@"男",@"女"];
    }
    return _dataArray;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if ([UIDevice jeSystemVersion] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.title = @"性别";
    self.view.backgroundColor = RGBColor(245, 247, 250);
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]
        initWithCustomView:self.naviBarRightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]
        initWithCustomView:self.naviBarLeftButton];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.view addSubview:self.genderTextField];
    
    self.genderTextField.inputView = self.pickerView;
    
    [self.genderTextField becomeFirstResponder];
    
}

- (void)clickLeft:(UIButton *)sender{
    if (self.genderTextField.text == nil || self.genderTextField.
        text.length == 0) {
        kShowFail(@"您还未填写信息");
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickRight:(UIButton *)sender{
    DYNSLog(@"usergender = %@",self.genderTextField.text);
    
    NSString *kupdateUserInfoUrl = [NSString stringWithFormat:BASEURL,kupdateUserInfo];
    
    NSDictionary *dicParam =
    @{@"gender":self.genderTextField.text,@"userid":[AccountManager manager].userid};
    
    [JENetwoking startDownLoadWithUrl:kupdateUserInfoUrl postParam:dicParam
        WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
            
            NSDictionary *dataParam = data;
            NSNumber *message = dataParam[@"type"];
            if (message.intValue == 1) {
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                [AccountManager saveUserGender:self.genderTextField.text];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:kGenderChange
                        object:nil];
                
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:@"修改失败"];
                return;
            }
        }];
}

//显示列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//显示行数
- (NSInteger)pickerView:(UIPickerView *)pickerView
    numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}

//每行显示的数据
- (NSString *)pickerView:(UIPickerView *)pickerView
    titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataArray[row];
}

//选中每行触发的事件
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *resultString = self.dataArray[row];
    self.genderTextField.text = resultString;
}

//进入页面时候显示条显示的内容
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([AccountManager manager].userGender) {
        self.genderTextField.text = [AccountManager manager].userGender;
        if([self.dataArray.firstObject isEqualToString:self.genderTextField.text]){
            [self.pickerView selectRow:0 inComponent:0 animated:YES];
        }else{
            [self.pickerView selectRow:1 inComponent:0 animated:YES];
        }
    }else{    //默认值
       self.genderTextField.text = @"男";
    }
}

@end
