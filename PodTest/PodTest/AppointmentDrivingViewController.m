//
//  AppointmentDrivingViewController.m
//  PodTest
//
//  Created by 李超 on 15/12/28.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "AppointmentDrivingViewController.h"
#import "AppointmentCoachModel.h"
#import "AppointmentcoachTimeInfoModel.h"
#import "UIDevice+JEsystemVersion.h"
#import "NSString+CurrentTimeDay.h"
#import "BLInformationManager.h"
#import "AppointmentDrivingCell.h"
#import "CoachHeadCell.h"
#import "CoachViewController.h"
#import <SVProgressHUD.h>

static NSString *const kappointmentCoachUrl = @"userinfo/getusefulcoach/index/1";
static NSString *const kuserUpdateParam = @"courseinfo/userreservationcourse";
//http://101.200.204.240:3000/api/v1/courseinfo/getcoursebycoach?coachid=5616352721ec29041a9af889&date=2015-10-10
//http://101.200.204.240:3000/api/v1/courseinfo/userreservationcourse

static NSString *const kappointmentCoachTimeUrl = @"courseinfo/getcoursebycoach?coachid=%@&date=%@";

@interface AppointmentDrivingViewController()<UITableViewDataSource,
    UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,AppointmentDrivingCellDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UICollectionView *coachHeadCollectionView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) NSArray *coachTimeArray;

@property (strong, nonatomic) UIView *bottomTooBar;

@property (strong, nonatomic) UIButton *submitBtn;

@property (strong, nonatomic) AppointmentCoachModel *coachModel;

@property (strong, nonatomic) UIScrollView *menuScrollview;

@property (strong, nonatomic) NSMutableArray *buttonArray;

@property (strong, nonatomic) NSString *updateTimeString;

@property (strong, nonatomic) UIButton *naviBarRightButton;

@property (strong, nonatomic) UILabel *contentLabel;

@property (assign, nonatomic) BOOL is_AddCoachModel;

@end

@implementation AppointmentDrivingViewController

- (UIButton *)naviBarRightButton{
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"更多教练"
            withTitleColor:MAINCOLOR withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.frame = CGRectMake(0, 0, 100, 44);
       
        [_naviBarRightButton addTarget:self action:@selector(clickRight:)
            forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarRightButton;
}

- (UIScrollView *)menuScrollview{
    if (_menuScrollview == nil) {
        _menuScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
            0, kSystemWide, 44)];
    }
    return _menuScrollview;
}

- (NSMutableArray *)buttonArray{
    if (_buttonArray == nil) {
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
}

- (UIView *)bottomTooBar{
    if (_bottomTooBar == nil) {
        _bottomTooBar = [[UIView alloc] init];
        _bottomTooBar.backgroundColor  = [UIColor whiteColor];
        _bottomTooBar.layer.borderColor = TEXTGRAYCOLOR.CGColor;
        _bottomTooBar.layer.borderWidth = 0.5;
    }
    return _bottomTooBar;
}

- (UIButton *)submitBtn{
    if (_submitBtn == nil) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.backgroundColor = MAINCOLOR;
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_submitBtn addTarget:self action:@selector(submitClick:)
             forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

#pragma mark - 头教练视图

- (UICollectionView *)coachHeadCollectionView{
    if (_coachHeadCollectionView == nil) {
        UICollectionViewFlowLayout *flowLayout =
             [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 15;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _coachHeadCollectionView  = [[UICollectionView alloc]
             initWithFrame:CGRectMake(0, 0, kSystemWide, 90)
             collectionViewLayout:flowLayout];
        _coachHeadCollectionView.backgroundColor = [UIColor whiteColor];
        _coachHeadCollectionView.delegate = self;
        _coachHeadCollectionView.dataSource = self;
        
        [_coachHeadCollectionView registerClass:[CoachHeadCell class]
             forCellWithReuseIdentifier:@"collectionCell"];
    }
    return _coachHeadCollectionView;
}

#pragma mark - tableview
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:
            CGRectMake(0, 0, kSystemWide, kSystemHeight-49-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)clickRight:(UIButton *)sender{
    DYNSLog(@"更多教练");
//    CoachViewController *coach = [[CoachViewController alloc] init];
//    coach.markNum = 2;
//    [self.navigationController pushViewController:coach animated:YES];

}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:
        @selector(kCellChange) name:@"kCellChange" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:
        @selector(kAddCoachModel) name:@"kAddCoachModel" object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我要预约";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if ([UIDevice jeSystemVersion] >= 7.0) {
        //当你的容器是navigation controller时，默认的布局将从navigation bar的顶部开始。这就是为什么所有的UI元素都往上漂移了44pt
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self.view addSubview:self.tableView];
    
    [self conformNavItem];
    
    self.tableView.tableHeaderView = [self tableViewHeadView];
    
    self.tableView.tableFooterView = [self tableViewFootView];
    
    [self.view addSubview:self.submitBtn];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(0);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.height.mas_equalTo(@44);
    }];
    
    [self startDownLoadCoach];
}

#pragma mark - NotificationCenter
- (void)kCellChange{
    NSArray *array = [BLInformationManager sharedInstance].appointmentData;
    
    NSArray *resultArray = [array sortedArrayUsingComparator:^
        NSComparisonResult(AppointmentCoachTimeInfoModel *  _Nonnull obj1,
            AppointmentCoachTimeInfoModel *  _Nonnull obj2) {
        
            return obj1.coursetime.numMark > obj2.coursetime.numMark;
            
    }];
    AppointmentCoachTimeInfoModel *firstModel = resultArray.firstObject;
    AppointmentCoachTimeInfoModel *lastModel = resultArray.lastObject;
    
    NSArray *beginArray = [firstModel.coursetime.begintime
        componentsSeparatedByString:@":"];
    NSString *beginString = beginArray.firstObject;
    
    NSArray *endArray = [lastModel.coursetime.endtime
        componentsSeparatedByString:@":"];
    NSString *endString = endArray.firstObject;
    
    self.contentLabel.text = [NSString stringWithFormat:@"当前预约为科目二的第%@-%@时段",
        beginString,endString];
    DYNSLog(@"self.contentLabel.text");
}

- (void)kAddCoachModel{
    if (_is_AddCoachModel == NO) {
        [self.dataArray insertObject:[BLInformationManager
            sharedInstance].appointmentCoachModel atIndex:0];
        self.is_AddCoachModel = YES;
    }else if(_is_AddCoachModel == YES){
        [self.dataArray replaceObjectAtIndex:0 withObject:
            [BLInformationManager sharedInstance].appointmentCoachModel];
    }
    [self.coachHeadCollectionView reloadData];
}

#pragma mark - 导航button

- (void)conformNavItem{
    UIBarButtonItem *navMessageItem = [[UIBarButtonItem alloc]
        initWithCustomView:self.naviBarRightButton];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = 15;
    self.navigationItem.rightBarButtonItems = @[spaceItem,navMessageItem];
}

#pragma mark - 开始下载
- (void)startDownLoadCoach{
    [SVProgressHUD show];
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,kappointmentCoachUrl];
    DYNSLog(@"url = %@",urlString);
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil
        WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            
            NSDictionary *param = data;
            NSNumber *type = param[@"type"];
            NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
            if (type.integerValue == 1) {
                DYNSLog(@"data = %@",data);
                NSArray *array = param[@"data"];
                NSError *error = nil;
                [self.dataArray addObjectsFromArray:[MTLJSONAdapter
                    modelsOfClass:AppointmentCoachModel.class fromJSONArray:array
                      error:&error]];
                [self.coachHeadCollectionView reloadData];
            }else{
                kShowFail(msg);
            }
        }];
}

#pragma mark - footView

- (UIView *)tableViewFootView{
    UIView *backGroundView = [[UIView alloc] initWithFrame:
        CGRectMake(0, 0, kSystemWide, 10)];
    _contentLabel = [[UILabel alloc] initWithFrame:
        CGRectMake(15, 9, kSystemWide-100, 50)];
    _contentLabel.numberOfLines = 2;
    _contentLabel.textColor = TEXTGRAYCOLOR;
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.text = @"";
    
    [backGroundView addSubview:_contentLabel];
    
    return backGroundView;
}

#pragma mark - headView

- (UIView *)tableViewHeadView{
    UIView *backGroundView = [[UIView alloc] initWithFrame:
       CGRectMake(0, 0, kSystemWide, 90)];
    backGroundView.userInteractionEnabled = YES;
    backGroundView.backgroundColor = [UIColor whiteColor];
    [backGroundView addSubview:self.coachHeadCollectionView];
    return backGroundView;
}

#pragma mark - collectionviewdelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
      cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"collectionCell";
    CoachHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:
        cellId forIndexPath:indexPath];
    AppointmentCoachModel *coachModel = self.dataArray[indexPath.row];
    
    [cell recevieCoachData:coachModel];
    
    if(indexPath.row == 0){
        self.coachModel = coachModel;
        NSString *dateString = [NSString getDayWithAddCountWithData:0];
        NSString *urlString = [NSString stringWithFormat:
            kappointmentCoachTimeUrl,coachModel.coachid,dateString];
        NSString *url = [NSString stringWithFormat:BASEURL,urlString];
        
        [JENetwoking startDownLoadWithUrl:url postParam:nil
            WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
                
                DYNSLog(@"appointment = %@",data);
                NSDictionary *param = data;
                DYNSLog(@"msg = %@",param[@"msg"]);
                NSString *type = [NSString stringWithFormat:@"%@",param[@"msg"]];
                
                if ([type isEqualToString:@"0"]) {
                    [SVProgressHUD showInfoWithStatus:param[@"msg"]];
                }else{
                    NSArray *array = param[@"data"];
                    NSError *error = nil;
                    self.coachTimeArray = [MTLJSONAdapter modelsOfClass:
                        AppointmentCoachTimeInfoModel.class fromJSONArray:array error:&error];
                    DYNSLog(@"error = %@",error);
                    
                    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath
                         indexPathForRow:0 inSection:0]]
                        withRowAnimation:UITableViewRowAnimationNone];
                }
            }];
    }
    if (!cell) {
        DYNSLog(@"创建错误");
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize cellSize = CGSizeMake(kSystemWide*0.8125, 78);
    return cellSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:
    (UICollectionViewLayout *)collectionViewLayout
     insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView
     didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    DYNSLog(@"click");
    [SVProgressHUD show];
    self.coachModel = self.dataArray[indexPath.row];
    
    NSString *dateString = [NSString getDayWithAddCountWithData:0];
    NSString *urlString = [NSString stringWithFormat:kappointmentCoachTimeUrl,
        self.coachModel.coachid,dateString];
    NSString *url = [NSString stringWithFormat:BASEURL,urlString];
    
    [JENetwoking startDownLoadWithUrl:url postParam:nil
        WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            
            DYNSLog(@"appointment = %@",data);
            [SVProgressHUD dismiss];
            NSDictionary *param = data;
            DYNSLog(@"msg = %@",param[@"msg"]);
            
            NSString *type = [NSString stringWithFormat:@"%@",param[@"msg"]];
            
            if ([type isEqualToString:@"0"]) {
                [SVProgressHUD showInfoWithStatus:param[@"msg"]];
            }else{
                NSArray *array = param[@"data"];
                NSError *error = nil;
                self.coachTimeArray = [MTLJSONAdapter modelsOfClass:
                      AppointmentCoachTimeInfoModel.class
                    fromJSONArray:array error:&error];
                DYNSLog(@"error = %@",error);
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
}

#pragma mark - tableviewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 269.0f-44.0f;
    }
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
    (NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:
    (NSInteger)section{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:
    (NSInteger)section{
    
    if (section == 0) {
        UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 44)];
        backGroundView.backgroundColor  = [UIColor whiteColor];
        [backGroundView addSubview:self.menuScrollview];
        UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 1)];
        upLine.backgroundColor = RGBColor(221, 221, 221);
        UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, 43, kSystemWide, 1)];
        downLine.backgroundColor = RGBColor(221, 221, 221);
        [backGroundView addSubview:upLine];
        [backGroundView addSubview:downLine];
        [self createButtonWith:backGroundView];
        return backGroundView;
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
    cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 && indexPath.section == 0 ) {
        static NSString *cellId = @"cell";
        AppointmentDrivingCell *cell = [tableView
            dequeueReusableCellWithIdentifier:cellId];
        
        if (!cell) {
            cell = [[AppointmentDrivingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.delegate = self;
        }
        DYNSLog(@"self.coachTimeArray = %ld",self.coachTimeArray.count);
        [cell receiveCoachTimeData:self.coachTimeArray];
        return cell;
        
    }else{
        static NSString *cellId = @"cell";
        UITableViewCell *cell = [tableView
            dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = @"接送地址";
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
        
        cell.detailTextLabel.text = [AccountManager manager].userAddress;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
        UIImageView *rightView = [[UIImageView alloc] initWithFrame:
            CGRectMake(0, 0, 23, 23)];
        rightView.image = [UIImage imageNamed:@"地点.png"];
        cell.accessoryView = rightView;
        
        return cell;
    }
    return nil;

}

#pragma mark - 日历button

- (void)createButtonWith:(UIView *)backGroundView{
    for (NSUInteger i = 0; i<30; i++) {
        
        //用button组成日历
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.frame = CGRectMake(15+(65+15)*i, 44/2-28/2, 65, 28);
        
        [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [b setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        //每个按钮显示的日期，其实每个日期就是一个按钮
        [b setTitle:[NSString getDayWithAddCountWithData:i]
           forState:UIControlStateNormal];
        b.titleLabel.font = [UIFont systemFontOfSize:12];
        b.tag = 100 +i;
        b.layer.cornerRadius = 2;
        
        [b addTarget:self action:@selector(clickButton:)
           forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            b.selected = YES;
            b.backgroundColor = MAINCOLOR;
            self.updateTimeString = [NSString getDayWithAddCountWithData:0];
        }
        [self.buttonArray addObject:b];
        [self.menuScrollview addSubview:b];
    }
    self.menuScrollview.contentSize = CGSizeMake((65+15)*30, 44);
}

//点击日历事件
- (void)clickButton:(UIButton *)sender{
    NSUInteger index = sender.tag - 100;
    for (UIButton *b in self.buttonArray) {
        b.selected = NO;
        b.backgroundColor = [UIColor whiteColor];
    }
    sender.backgroundColor = MAINCOLOR;
    sender.selected = YES;
    
    [self calendarClick:[NSString getDayWithAddCountWithData:index]];
    self.updateTimeString = [NSString getDayWithAddCountWithData:index];
}

#pragma mark - AppointmentDrivingCellDelegate

- (void)calendarClick:(NSString *)dateString{
    [SVProgressHUD show];
    
    NSString *urlString = [NSString stringWithFormat:
        kappointmentCoachTimeUrl,self.coachModel.coachid,dateString];
    
    NSString *url = [NSString stringWithFormat:BASEURL,urlString];
    
    [JENetwoking startDownLoadWithUrl:url postParam:nil
        WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            
            [SVProgressHUD dismiss];
            DYNSLog(@"data = %@",data);
            
            NSDictionary *param = data;
            NSArray *array = param[@"data"];
            NSError *error = nil;
            NSNumber *type = param[@"type"];
            NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
            DYNSLog(@"msg = %@",msg);
            
            if (type.integerValue == 1) {
                self.coachTimeArray = [MTLJSONAdapter modelsOfClass:
                   AppointmentCoachTimeInfoModel.class
                   fromJSONArray:array error:&error];
                DYNSLog(@"error = %@",error);
                DYNSLog(@"count = %ld",self.coachTimeArray.count);
                
                [self.tableView reloadRowsAtIndexPaths:
                   @[[NSIndexPath indexPathForRow:0 inSection:0]]
                   withRowAnimation:UITableViewRowAnimationNone];
            }else{
                kShowFail(msg);
            }
        }];
}

#pragma mark - 日历按钮点击
- (void)submitClick:(UIButton *)sender{
    NSArray *array = [BLInformationManager sharedInstance].appointmentData;
    NSArray *resultArray = [array sortedArrayUsingComparator:^
       NSComparisonResult(AppointmentCoachTimeInfoModel * _Nonnull obj1,
        AppointmentCoachTimeInfoModel *  _Nonnull obj2) {
       
           return obj1.coursetime.numMark > obj2.coursetime.numMark;
    }];
    DYNSLog(@"submit = %@",resultArray);
    
    AppointmentCoachTimeInfoModel *firstModel = resultArray.firstObject;
    DYNSLog(@"startTime = %@",firstModel.coursetime.begintime);
    
    NSString *updateBeginTime = [NSString stringWithFormat:@"%@ %@",
        self.updateTimeString,firstModel.coursetime.begintime];
    DYNSLog(@"startTime = %@",updateBeginTime);
    
    AppointmentCoachTimeInfoModel *lastModel = resultArray.lastObject;
    NSString *updateEndTime = [NSString stringWithFormat:@"%@ %@",
        self.updateTimeString,lastModel.coursetime.endtime];
    DYNSLog(@"updateEndTime = %@",updateEndTime);
    
    NSString *userid = [AccountManager manager].userid;
    
    NSString *coachid = self.coachModel.coachid;
    
    NSString *is_shuttle = [NSString stringWithFormat:@"%d",self.coachModel.is_shuttle];
    
    NSString *address = @"";
    
    if ([AccountManager manager].userAddress) {
        address = [AccountManager manager].userAddress;
    }
    
    NSMutableString *courselistString = [[NSMutableString alloc] init];
    for (NSInteger i = 0; i<resultArray.count; i++) {
        AppointmentCoachTimeInfoModel *model = resultArray[i];
        if (i == 0) {
            [courselistString appendString:[NSString
                stringWithFormat:@"%@",model.infoId]];
        }else{
            [courselistString appendString:[NSString
                stringWithFormat:@",%@",model.infoId]];
        }
    }
    
    NSDictionary *param =
       @{@"userid":userid,@"coachid":coachid,@"courselist":courselistString,
          @"is_shuttle":is_shuttle,@"address":address,@"begintime":updateBeginTime,
          @"endtime":updateEndTime};
    DYNSLog(@"param = %@",param);
    NSString *urlString = [NSString stringWithFormat:BASEURL,kuserUpdateParam];
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:param
        WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
            
            NSDictionary *param = data;
            DYNSLog(@"param = %@",param[@"data"]);
            NSNumber *type = param[@"type"];
            NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
            if (type.integerValue == 1) {
                [SVProgressHUD showSuccessWithStatus:@"预约成功"];
            }else{
                kShowFail(msg);
            }
            
        }];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    kShowDismiss
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
