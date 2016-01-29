//
//  ViewController.m
//  Demo--登陆界面2
//
//  Created by 李超 on 15/11/9.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
//{
//    UITextField *nameField;
//    UITextField *pwdField;
//}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITableView *loginView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped];
    loginView.delegate = self;
    loginView.dataSource = self;
    loginView.scrollEnabled = NO;
    loginView.backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    
//    UIImageView *image = [[UIImageView alloc] initWithFrame:loginView.frame];
//    
//    [image setImage:[UIImage imageNamed:@"3.jpeg"]];
//    
//    [loginView addSubview:image];
    
    [self.view addSubview:loginView];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return 2;
    }else
    {
        return 1;
    }
}

//设置tableview第二栏头文字内容

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section ==1) {
        return @"忘记密码？请点击这里";
    }else{
        return  nil;
    }
}

//设置tableview第二栏头高度

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return  20;
    }else
    {
        return 0;
    }
}

//设置第一组的cell不能点击

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 用户点击tableview第二栏，第一行的时候
    if (indexPath.section == 1 && [indexPath row] == 0)
    {
   //     [self doRegister];
    }
}

//设置登陆框内容

// 设置<span>登录</span>框
- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"loginCell";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
    }
    if (indexPath.section == 0) {  // 设置第一组的<span>登录</span>框内容
        switch ([indexPath row]) {
            case 0:
                cell.textLabel.text = @"账号"; // 设置label的文字
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone; // 设置不能点击
    
                self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(60, 7, 230, 30)];
                [self.nameField setBorderStyle:UITextBorderStyleNone]; //外框类型
                self.nameField.placeholder = @"请输入账号";
                self.nameField.clearButtonMode = YES; // 设置清除输入文本
                self.nameField.returnKeyType = UIReturnKeyNext;
                [cell.contentView addSubview:self.nameField];
                break;
            default:
                cell.textLabel.text = @"密码";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                self.pwdField = [[UITextField alloc] initWithFrame:CGRectMake(60, 7, 230, 30)];
                [self.pwdField setBorderStyle:UITextBorderStyleNone]; //外框类型
                self.pwdField.placeholder = @"请输入密码";
                self.pwdField.clearButtonMode = YES;
                self.pwdField.returnKeyType = UIReturnKeyDone;
                [cell.contentView addSubview:self.pwdField];
                break;
        }
    } else {  // 设置第二组注册框内容
        cell.textLabel.text = @"赶快去注册吧！";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; // 设置向>箭头
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
