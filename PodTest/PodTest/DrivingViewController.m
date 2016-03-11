
//
//  DrivingViewController.m
//  PodTest
//
//  Created by 李超 on 16/1/13.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "DrivingViewController.h"
#import "DrivingDetailViewController.h"
#import "DrivingCell.h"
#import <BaiduMapAPI/BMKLocationService.h>
#import "DrivingModel.h"
#import <SVProgressHUD.h>
#import "LoginViewController.h"
#import "SignUpInfoManager.h"
#import "BLPFAlertView.h"

static NSString *const kDrivingUrl = @"driveschool/nearbydriveschool?%@";

@interface DrivingViewController ()<UITableViewDelegate,
    UITableViewDataSource,BMKLocationServiceDelegate,JENetwokingDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) BMKLocationService *locationService;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) DrivingModel *detailModel;

@end

@implementation DrivingViewController

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UITableView *)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc] initWithFrame:
           CGRectMake(0, 64, kSystemWide, kSystemHeight-64)
           style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (UIButton *)naviBarRightButton{
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"完成"
            withTitleColor:MAINCOLOR withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.hidden = YES;
        _naviBarRightButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarRightButton addTarget:self action:@selector(clickRight:)
            forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarRightButton;
}

- (void)clickRight:(UIButton *)sender{
    if (![AccountManager isLogin]) {
        DYNSLog(@"islogin = %d",[AccountManager isLogin]);
        LoginViewController *login = [[LoginViewController alloc] init];
        [[UIApplication sharedApplication].keyWindow.rootViewController
            presentViewController:login animated:YES completion:nil];
        return;
    }
    if (![[AccountManager manager].userApplystate isEqualToString:@"0"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    
    DYNSLog(@"countId = %@",[AccountManager manager].applycoach.infoId);
    
    if (![AccountManager manager].applyschool.infoId) {
        if (self.detailModel.schoolid || self.detailModel.name) {
            NSDictionary *schlloParam = @{kRealSchoolid:self.detailModel.schoolid,
                @"name":self.detailModel.name};
            [SignUpInfoManager signUpInfoSaveRealSchool:schlloParam];
        }
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if ([[AccountManager manager].applyschool.infoId isEqualToString:self.detailModel.schoolid] ) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if (![[AccountManager manager].applyschool.infoId isEqualToString:self.detailModel.schoolid]) {
        [BLPFAlertView showAlertWithTitle:@"提示"
                message:@"您已经选择了教练和班级类型更换驾校后您可以重新做出选择"
                cancelButtonTitle:@"取消"
                otherButtonTitles:@[@"确定"]
                completion:^(NSUInteger selectedOtherButtonIndex) {
                    
                    DYNSLog(@"index = %ld",selectedOtherButtonIndex);
                    NSUInteger index = selectedOtherButtonIndex+1;
                    if (index == 0) {
                        return;
                    }else if (index == 1){
                        [SignUpInfoManager removeSignData];
                        
                        if (self.detailModel.schoolid || self.detailModel.name) {
                            NSDictionary *schoolParam = @{kRealSchoolid:self.detailModel.schoolid,@"name":self.detailModel.name};
                            [SignUpInfoManager signUpInfoSaveRealSchool:schoolParam];

                        }
                        [self.navigationController popViewControllerAnimated:YES];
                    }
            
        }];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD show];
    
    self.title = @"选择驾校";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]
        initWithCustomView:self.naviBarRightButton];
    DYNSLog(@"right = %@",self.naviBarRightButton);
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.view addSubview:self.tableView];
    
    [self locationManager];

}

- (void)locationManager{
    [BMKLocationService setLocationDesiredAccuracy:
         kCLLocationAccuracyNearestTenMeters];
    [BMKLocationService setLocationDistanceFilter:10000.0f];
    
    self.locationService = [[BMKLocationService alloc] init];
    self.locationService.delegate = self;
    [self.locationService startUserLocationService];
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,
          userLocation.location.coordinate.longitude);
    NSString *locationContent =[NSString stringWithFormat:
        @"latitude=%f&longitude=%f&radius=10000",userLocation.location.coordinate.latitude,
         userLocation.location.coordinate.longitude];
    NSString *urlString = [NSString stringWithFormat:kDrivingUrl,locationContent];
    NSString *url = [NSString stringWithFormat:BASEURL,urlString];
    
    [self.dataArray removeAllObjects];
    
    [JENetwoking initWithUrl:url WithMethod:JENetworkingRequestMethodGet
        WithDelegate:self];
    
}

- (void)jeNetworkingCallBackData:(id)data{
    DYNSLog(@"result = %@",data);
    NSArray *array = data[@"data"];
    for (NSDictionary *dic in array) {
        NSError *error = nil;
        DrivingModel *model = [MTLJSONAdapter modelOfClass:DrivingModel.class
            fromJSONDictionary:dic error:&error];
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
    [SVProgressHUD dismiss];
}

#pragma mark - tableView-delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:
   (NSIndexPath *)indexPath{
    return 100.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
   (NSInteger)section{
    if (self.dataArray.count == 0) {
        tableView.hidden = YES;
    }else{
        tableView.hidden = NO;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
   (NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    DrivingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[DrivingCell alloc] initWithStyle:UITableViewCellStyleDefault
            reuseIdentifier:cellId];
    }
    DrivingModel *model = self.dataArray[indexPath.row];
    [cell updateAllContentWith:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:
    (NSIndexPath *)indexPath{
    DrivingDetailViewController *selectVC = [[DrivingDetailViewController alloc] init];
    DrivingModel *model = self.dataArray[indexPath.row];
    self.detailModel = model;
    self.naviBarRightButton.hidden = NO;
    selectVC.schoolId = model.schoolid;
    [self.navigationController pushViewController:selectVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    kShowDismiss;
}

@end
