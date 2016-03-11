//
//  UserCenterViewController.m
//  PodTest
//
//  Created by 李超 on 15/12/18.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "UserCenterViewController.h"
#import "UserCenterHeadView.h"
#import "EditorUserViewController.h"
#import "UIView+CalculateUIView.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import <JPush/APService.h>
#import "UserCenterCell.h"
#import "SetupViewController.h"

@interface UserCenterViewController ()<UITableViewDelegate,
   UITableViewDataSource,UserCenterHeadViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *tableHeadView;
@property (strong, nonatomic) UserCenterHeadView *userCenterView;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) NSArray *signArray;

@end

@implementation UserCenterViewController

- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = @[@[@"报考驾校",@"报考车型"],@[@"我的喜欢",@"我的教练",
            @"钱包"],@[@"设置"]];
    }
    return _dataArray;
}

- (NSArray *)imageArray{
    if (_imageArray == nil) {
        _imageArray = @[@[@"驾校",@"车型"],@[@"喜欢",@"我的教练",@"钱包"]
            ,@[@"设置"]];
    }
    return _imageArray;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
            style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGBColor(245, 247, 250);
    }
    return _tableView;
}

- (UserCenterHeadView *)userCenterView{
    if (_userCenterView == nil) {
        _userCenterView = [[UserCenterHeadView alloc] initWithFrame:
            CGRectMake(0, 0, self.view.calculateFrameWithWide, 80)
                withUserPortrait:[AccountManager manager].userHeadImageUrl
                withUserPhoneNum:[AccountManager manager].userDisplaymobile
                withUserIdNum:[NSString stringWithFormat:@"ID:%@",
                        [AccountManager manager].userDisplayuserid]];
        _userCenterView.delegate = self;
    }
    return _userCenterView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"个人中心";
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [self tableFootView];
    
    self.tableView.tableHeaderView = self.userCenterView;
    
}

- (UIButton *)tableFootView{
    UIButton *quit = [UIButton buttonWithType:UIButtonTypeCustom];
    quit.backgroundColor = [UIColor whiteColor];
    [quit setTitle:@"退出" forState:UIControlStateNormal];
    quit.titleLabel.font = [UIFont systemFontOfSize:14];
    [quit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    quit.frame = CGRectMake(0, 0, kSystemWide, 44);
    [quit addTarget:self action:@selector(clickQuit:)
        forControlEvents:UIControlEventTouchUpInside];
    return quit;
}

- (void)clickQuit:(UIButton *)sender{
    
    NSLog(@"退出-----------------");
    
    [AccountManager removeAllData];
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES
            completion:^(NSDictionary *info, EMError *error) {
                DYNSLog(@"退出成功 = %@ %@",info,error);
                if (!error && info) {
                    return ;
                }
    } onQueue:nil];
    
    LoginViewController *login = [[LoginViewController alloc] init];
    
    [APService setAlias:@"" callbackSelector:@selector
        (tagsAliasCallback:tags:alias:) object:self];
   
    [[UIApplication sharedApplication].keyWindow.rootViewController
        presentViewController:login animated:YES completion:nil];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [[NSNotificationCenter defaultCenter]
        postNotificationName:@"kQuitSuccess" object:nil];
    
}

//取消别名标识
- (void)tagsAliasCallback:(int)isResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias{

    NSString *callbackString = [NSString stringWithFormat:
        @"%d, \ntags: %@, \nalias: %@\n",isResCode,tags,alias];
    DYNSLog(@"TagsAlias回调:%@",callbackString);
}

- (void)userCenterClick{
    EditorUserViewController *editor = [[EditorUserViewController alloc] init];
    [self.navigationController pushViewController:editor animated:YES];
}

//指定个性标题
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:
    (NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGBColor(245, 247, 250);
    return view;
}

//table中的分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //return 3;
    return [self.dataArray count];
}

//指定高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:
    (NSInteger)section{
    return 20;
}

//指定每个分区行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section == 0) {
//        return 2;
//    }else if (section == 1){
//        return 3;
//    }else if (section ==2){
//        return 1;
//    }
//    return 0;
    
    return [[self.dataArray objectAtIndex:section] count];
}

//绘制Cell
- (UITableViewCell *)tableView:(UITableView *)tableView
    cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cell";
    
    UserCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[UserCenterCell alloc] initWithStyle:
            UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.contentLabel.text = self.dataArray[indexPath.section][indexPath.row];
    cell.leftImageView.image = [UIImage imageNamed:
        self.imageArray[indexPath.section][indexPath.row]];
    
    if (indexPath.section == 0) {
        //第一分区显示内容样式设置
        cell.detailTextLabel.text = self.signArray[indexPath.row];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }

    return cell;
}

//点击cell触发事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
    (NSIndexPath *)indexPath{

    if (indexPath.row == 0 && indexPath.section == 0) {
        
    }else if(indexPath.row == 0 && indexPath.section == 1){
    
    }else if(indexPath.row == 1 && indexPath.section == 0){
    
    }else if(indexPath.row == 1 && indexPath.section == 1){
       
    }else if(indexPath.section == 2){
    
        SetupViewController *setup = [[SetupViewController alloc] init];
        [self.navigationController pushViewController:setup animated:YES];
        
    }else if(indexPath.section == 1 && indexPath.row == 2){
    
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
    NSLog(@"sssssssssssssssss");
#pragma mark - 更新头像
    
    DYNSLog(@"url = %@",[AccountManager manager].userHeadImageUrl);
//
//    [self.userCenterView.userPortrait sd_setImageWithURL:[NSURL
//       URLWithString:[AccountManager manager].userHeadImageUrl]
//       placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
//    
//    DYNSLog(@"account = %@ %@",[AccountManager manager].applyschool.name,
//            [AccountManager manager].userCarmodels.name);
  
//    NSString *schoolName = [AccountManager manager].applyschool.name;
//    NSString *carModelName = [AccountManager manager].userCarmodels.name;
    
//    if (schoolName == nil) {
//        schoolName = @"";
//    }
//    
//    if (carModelName == nil) {
//        carModelName = @"";
//    }
//    _signArray = @[schoolName,carModelName];
//    [self.tableView reloadData];
}

@end
