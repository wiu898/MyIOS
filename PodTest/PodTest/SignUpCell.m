//
//  SignUpCell.m
//  PodTest
//
//  Created by 李超 on 16/1/14.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "SignUpCell.h"
#import "ToolHeader.h"

@interface SignUpCell()<UITextFieldDelegate>

@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) UILabel *signUpLabel;
@property (strong, nonatomic) UITextField *signUpTextField;

@end

@implementation SignUpCell

- (UIView *)backGroundView{
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:
            CGRectMake(0, 0, kSystemWide, 44)];
    }
    return _backGroundView;
}

- (UILabel *)signUpLabel{
    if (_signUpLabel == nil) {
        _signUpLabel = [WMUITool initWithTextColor:RGBColor(153, 153, 153)
            withFont:[UIFont systemFontOfSize:14]];
        _signUpLabel.text = @"真实姓名";
    }
    return _signUpLabel;
}

- (UITextField *)signUpTextField{
    if (_signUpTextField == nil) {
        _signUpTextField = [[UITextField alloc] init];
        _signUpTextField.delegate = self;
        _signUpTextField.returnKeyType = UIReturnKeyDone;
    }
    return _signUpTextField;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:
    (NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    [self.contentView addSubview:self.backGroundView];
    [self.backGroundView addSubview:self.signUpLabel];
    [self.backGroundView addSubview:self.signUpTextField];
    
    [self.signUpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.centerY.mas_equalTo(self.backGroundView.mas_centerY);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@44);
    }];
    
    [self.signUpTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.signUpLabel.mas_right).offset(0);
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(-15);
        make.centerY.mas_equalTo(self.backGroundView.mas_centerY);
        make.height.mas_equalTo(@40);
    }];
}

- (void)receiveTitile:(NSString *)titleString andSignUpBlock:
    (SIGNUPCOMPLETION)signUpCompletion{
    [self clearCellUIData];
    self.signUpLabel.text = titleString;
    self.signUpCompletion = signUpCompletion;
}

- (void)receiveTextContent:(NSString *)content{
    DYNSLog(@"content = %@",content);
    self.signUpTextField.text = nil;
    self.signUpTextField.text = content;
}

- (void)clearCellUIData{
    self.signUpLabel.text = nil;
    //    self.signUpTextField.text = nil;
}

#pragma mark - delegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.signUpCompletion) {
        self.signUpCompletion(textField.text);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
