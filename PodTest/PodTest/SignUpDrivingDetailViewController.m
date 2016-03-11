//
//  SignUpDrivingDetailViewController.m
//  PodTest
//
//  Created by 李超 on 16/1/19.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "SignUpDrivingDetailViewController.h"
#import "ToolHeader.h"
#import "DrivingDetailCell.h"
#import "MapViewController.h"
#import "BLPFAlertView.h"
#import "DrivingInformationCell.h"
#import "DrivingIntroductionCell.h"
#import "SignUpViewController.h"
#import "DrivingSelectedCoachCell.h"
#import "DrvingDetailModel.h"
#import <SVProgressHUD.h>
#import "SignUpInfoManager.h"
#import "CoachModel.h"
#import "CoachDetailViewController.h"

static NSString *const kDrivingDetailUrl = @"driveschool/getschoolinfo/%@";

static NSString *const kGetDrivingCoachUrl = @"getschoolcoach/%@/%@";

static NSString *const kSaveMyLoveDriving = @"userinfo/favoriteschool/%@";

@interface SignUpDrivingDetailViewController()<UITableViewDataSource,
    UITableViewDelegate,UIActionSheetDelegate,DrivingSelectedCoachCellDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *phoneButton;
@property (strong, nonatomic) UIImageView *tableHeadImageView;

@property (strong, nonatomic) UIButton *signUpButton;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSArray *coachArray;

@end

@implementation SignUpDrivingDetailViewController

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UIButton *)signUpButton{
    if (_signUpButton == nil) {
        _signUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _signUpButton.backgroundColor = MAINCOLOR;
        _signUpButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_signUpButton addTarget:self action:@selector(dealSignUp:)
            forControlEvents:UIControlEventTouchUpInside];
        
        if ([[AccountManager manager].userApplystate isEqualToString:@"0"]) {
            
            [_signUpButton setTitle:@"报名" forState:UIControlStateNormal];
            
        }else if ([[AccountManager manager].userApplystate isEqualToString:@"1"]){
            
            [_signUpButton setTitle:@"报名申请中" forState:UIControlStateNormal];
            _signUpButton.userInteractionEnabled = NO;
            
        }else if ([[AccountManager manager].userApplystate isEqualToString:@"2"]){
            
            [_signUpButton setTitle:@"报名成功" forState:UIControlStateNormal];
            _signUpButton.userInteractionEnabled = NO;
            
        }
        [_signUpButton setTitleColor:[UIColor whiteColor]
            forState:UIControlStateNormal];
    }
    return _signUpButton;
}

- (UIButton *)phoneButton{
    if (_phoneButton == nil) {
        _phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _phoneButton.frame = CGRectMake(0, 0, 50, 50);
        
        [_phoneButton setBackgroundImage:[UIImage imageNamed:@"电话"]
            forState:UIControlStateNormal];
        [_phoneButton addTarget:self action:@selector(dealPhone:)
            forControlEvents:UIControlStateNormal];
    }
    return _phoneButton;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:
           CGRectMake(0, 64, kSystemWide, kSystemHeight-64-49)
           style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)configBarItem{
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
        target:nil action:nil];
    negativeSpacer.width = -15;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]
        initWithCustomView:self.phoneButton];
    
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,rightItem];
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"驾校详情";
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.signUpButton];
    self.tableView.tableHeaderView = [self tableHeadImageView];
    
    [self.signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
        make.height.mas_equalTo(@49);
    }];
    
    [self startDownLoad];
    
    [self startDownLoadCoach];
}

- (void)startDownLoadCoach{
    NSString *urlString = [NSString stringWithFormat:kGetDrivingCoachUrl,
        @"56163c376816a9741248b7f9",[NSNumber numberWithInt:1]];
    NSString *getCoachUrlString = [NSString stringWithFormat:BASEURL,urlString];
    
    [JENetwoking startDownLoadWithUrl:getCoachUrlString postParam:nil
        WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            DYNSLog(@"coachData = %@",data);
            NSDictionary *param = data;
            NSNumber *type = param[@"type"];
            NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
            if (type.integerValue == 1) {
                NSError *error = nil;
                self.coachArray = [MTLJSONAdapter modelsOfClass:CoachModel.class
                    fromJSONArray:param[@"data"] error:&error];
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath
                    indexPathForRow:3 inSection:0]]
                    withRowAnimation:UITableViewRowAnimationNone];
            }else{
                kShowFail(msg);
            }
        }];
}

- (void)startDownLoad{
    NSString *urlString = [NSString stringWithFormat:kDrivingDetailUrl,self.schoolId];
    NSString *url = [NSString stringWithFormat:BASEURL,urlString];
    [SVProgressHUD show];
    
    [JENetwoking startDownLoadWithUrl:url postParam:nil
        WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            DYNSLog(@"result = %@",data);
            NSDictionary *param = data;
            NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
            NSNumber *type = param[@"type"];
            if (type.integerValue == 1) {
                NSDictionary *dic= data[@"data"];
                NSError *error = nil;
                DrvingDetailModel *drivingDetailModel = [MTLJSONAdapter
                    modelOfClass:DrvingDetailModel.class
                    fromJSONDictionary:dic error:&error];
                DYNSLog(@"error = %@",error);
                [self.dataArray addObject:drivingDetailModel];
                [self.tableView reloadData];
                [SVProgressHUD dismiss];
                
                [self.tableHeadImageView sd_setImageWithURL:
                    [NSURL URLWithString:drivingDetailModel.logoimg.originalpic]
                     placeholderImage:[UIImage imageNamed:@"bigImage.png"]];
                
            }else{
                kShowFail(msg);
            }
        }];
}

- (UIImageView *)tableHeadImageView{
    if (_tableHeadImageView == nil) {
        _tableHeadImageView = [[UIImageView alloc] initWithFrame:
            CGRectMake(0, 0, kSystemWide, 240)];
        _tableHeadImageView.userInteractionEnabled = YES;
    }
    
    UIImageView *maskView = [[UIImageView alloc] initWithFrame:
            CGRectMake(0, 240-129, kSystemWide, 129)];
    maskView.image = [UIImage imageNamed:@"渐变"];
    [_tableHeadImageView addSubview:maskView];
    
    UIView *heart = [[UIView alloc] initWithFrame:
        CGRectMake(kSystemWide-15-50, 240-24, 50, 50)];
    heart.backgroundColor = [UIColor whiteColor];
    heart.layer.masksToBounds = YES;
    heart.layer.cornerRadius = heart.frame.size.width *0.5;
    heart.userInteractionEnabled = YES;
    [_tableHeadImageView addSubview:heart];
    
    UIView *mainColorView = [[UIView alloc] initWithFrame:
        CGRectMake(2, 2, 46, 46)];
    mainColorView.backgroundColor = MAINCOLOR;
    mainColorView.layer.cornerRadius = mainColorView.frame.size.width *0.5;
    mainColorView.userInteractionEnabled = YES;
    [heart addSubview:mainColorView];
    
    UIImageView *heartImageView = [[UIImageView alloc] initWithFrame:
        CGRectMake(46/2-21/2, 46/2-21/2, 21, 21)];
    heartImageView.image = [UIImage imageNamed:@"心Inner.png"];
    heartImageView.userInteractionEnabled = YES;
    [mainColorView addSubview:heartImageView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
        initWithTarget:self action:@selector(dealLike:)];
    [mainColorView addGestureRecognizer:tapGesture];
    
    return _tableHeadImageView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:
    (NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 86;
    }else if (indexPath.row == 1){
        return 105;
    }else if (indexPath.row == 2){
        return 105;
    }else if (indexPath.row == 3){
        return 150;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
    (NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
    (NSIndexPath *)indexPath{
    
    DrvingDetailModel *model = self.dataArray.firstObject;
    
    if (indexPath.row == 0) {
        static NSString *cellId = @"Addersscell";
        DrivingDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[DrivingDetailCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.drivingNameLabel.text = model.name;
        cell.locationLabel.text = [NSString stringWithFormat:@"地址%@",model.address];
        return cell;
        
    }else if (indexPath.row == 1){
        static NSString *cellId = @"InformationCell";
        DrivingInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[DrivingInformationCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.workTimeDetail.text = model.hours;
        cell.successRateDetailLabel.text = [NSString stringWithFormat:
            @"通过率%@%@",model.passingrate,@"%"];
        return cell;
        
    }else if (indexPath.row == 2){
      static NSString *cellId = @"Introduction";
        DrivingIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[DrivingIntroductionCell alloc]
               initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.drivingIntroductionDetail.text = model.introduction;
        return cell;
        
    }else if (indexPath.row == 3){
        static NSString *cellId = @"DrivingSelected";
        DrivingSelectedCoachCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[DrivingSelectedCoachCell alloc]
               initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell receiveGetCoachMessage:self.coachArray];
        return cell;
    }
    return nil;
}

#pragma mark - tableView selected

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
   (NSIndexPath *)indexPath{
    DrvingDetailModel *model = self.dataArray.firstObject;
    
    if (indexPath.row == 0) {
        MapViewController *mapView = [[MapViewController alloc] init];
        mapView.latitudeNum = model.latitude;
        mapView.longitudeNum = model.longitude;
        [self.navigationController pushViewController:mapView animated:YES];
    }
}

#pragma mark - buttonAction
- (void)dealSignUp:(UIButton *)sender{
    DrvingDetailModel *model = self.dataArray.firstObject;
    if (model.schoolid && model.name) {
        NSDictionary *schoolParam = @{kRealSchoolid:model.schoolid,
            @"name":model.name};
        [SignUpInfoManager signUpInfoSaveRealSchool:schoolParam];
    }
    for (UIViewController *targetVc in self.navigationController.viewControllers) {
        if ([targetVc isKindOfClass:[SignUpViewController class]]) {
            [self.navigationController popToViewController:targetVc animated:YES];
        }
    }
}

#pragma mark - delegateCoach
- (void)senderCoachModel:(CoachModel *)model{
    NSString *coachId = model.coachid;
    CoachDetailViewController *coachDetail = [[CoachDetailViewController alloc] init];
    coachDetail.coachUserId = coachId;
    [self.navigationController pushViewController:coachDetail animated:YES];
}

- (void)dealPhone:(UIButton *)sender{
    [BLPFAlertView showAlertWithTitle:@"练习驾校" message:@"18911088136"
        cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"]
        completion:^(NSUInteger selectedOtherButtonIndex) {
            NSLog(@"index = %ld",selectedOtherButtonIndex);
            if (selectedOtherButtonIndex == 0) {
                NSMutableString *str = [[NSMutableString alloc]
                    initWithFormat:@"teleprompt://%@",@"18911088136"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }else{
                return;
            }
        }];
}

- (void)dealLike:(UITapGestureRecognizer *)tap{
    NSString *kSaveUrl = [NSString stringWithFormat:kSaveMyLoveDriving,self.schoolId];
    NSString *urlString = [NSString stringWithFormat:BASEURL,kSaveUrl];
    DYNSLog(@"urlstring = %@",urlString);
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil
        WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            DYNSLog(@"data = %@",data);
            NSDictionary *param = data;
            NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
            if ([type isEqualToString:@"1"]) {
                [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
            }else{
                [SVProgressHUD showSuccessWithStatus:param[@"msg"]];
            }
        }];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    kShowDismiss;
}

@end
