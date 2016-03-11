//
//  StudentDetailViewController.m
//  PodTest
//
//  Created by 李超 on 16/1/22.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "StudentDetailViewController.h"
#import "SignUpViewController.h"
#import "StudentDetailCell.h"
#import "StudentCommentCell.h"
#import "StudentInformationCell.h"
#import <SVProgressHUD.h>
#import "StudentDetailModel.h"
#import "StudentCommentModel.h"

static NSString *const kStudentDetailInfo = @"/userinfo/getuserinfo/1/userid/%@";

static NSString *const kGetCommentInfo = @"courseinfo/getusercomment/2/%@/%@";

@interface StudentDetailViewController()<UITableViewDataSource,UITableViewDelegate>

@property (strong ,nonatomic) UIButton *messageBtn;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIImageView *tableHeadImageView;
@property (strong, nonatomic) StudentDetailModel *detailModel;
@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation StudentDetailViewController

- (UIImageView *)tableHeadImageView {
    if (_tableHeadImageView == nil) {
        _tableHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 240)];
        UIImageView *maskView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 240-129, kSystemWide, 129)];
        maskView.image = [UIImage imageNamed:@"渐变"];
        [_tableHeadImageView addSubview:maskView];
        
    }
    return _tableHeadImageView;
    
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, kSystemWide, kSystemHeight-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}



- (UIButton *)messageButton{
    if (_messageBtn == nil) {
        _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _messageBtn.frame = CGRectMake(0, 0, 50, 50);
        [_messageBtn setBackgroundImage:[UIImage imageNamed:@"聊天.png"]
            forState:UIControlStateNormal];
        [_messageBtn addTarget:self action:@selector(clickPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageBtn;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"学院详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self configBarItem];
    
    [self createUI];
    
    [self startDownLoad];
    
    [self startDownLoadComment];
}

- (void)startDownLoadComment{
    NSString *urlString = [NSString stringWithFormat:kGetCommentInfo,
        self.studetnId,[NSNumber numberWithInt:1]];
    NSString *urlComment = [NSString stringWithFormat:BASEURL,urlString];
    
    [JENetwoking startDownLoadWithUrl:urlComment postParam:nil
        WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            DYNSLog(@"data = %@",data);
            NSDictionary *param = data;
            NSError *error = nil;
            NSNumber *type = param[@"type"];
            NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
            if (type.integerValue == 1) {
                self.dataArray = [MTLJSONAdapter modelsOfClass:StudentCommentModel.class
                    fromJSONArray:param[@"data"] error:&error];
                DYNSLog(@"error = %@",error);
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1]
                    withRowAnimation:UITableViewRowAnimationNone];
            }else{
                kShowFail(msg);
            }
        }];
}

- (void)startDownLoad{
    NSString *infoString = [NSString stringWithFormat:kStudentDetailInfo,self.studetnId];
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,infoString];
    
    __weak StudentDetailViewController *weakSelf= self;
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil
        WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            DYNSLog(@"data = %@",data);
            NSError *error = nil;
            NSDictionary *param = data;
            NSNumber *type = param[@"type"];
            if (type.integerValue == 1) {
                StudentDetailModel *studentDetail =
                    [MTLJSONAdapter modelOfClass:StudentDetailModel.class
                     fromJSONDictionary:param[@"data"] error:&error];
                DYNSLog(@"error = %@",error);
                weakSelf.detailModel = studentDetail;
                DYNSLog(@"data = %@",weakSelf.detailModel);
                
                [weakSelf.tableHeadImageView sd_setImageWithURL:
                  [NSURL URLWithString:studentDetail.headportrait.originalpic]
                   placeholderImage:[UIImage imageNamed:@"bigImage.png"]];
                [weakSelf.tableView reloadData];
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"];
                return;
            }
        }];
}

- (void)configBarItem{
    UIBarButtonItem *negaticeSpacer = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
        target:nil action:nil];
    negaticeSpacer.width = -15;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]
        initWithCustomView:self.messageBtn];
    self.navigationItem.rightBarButtonItems = @[negaticeSpacer,rightItem];
}

- (void)createUI{
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = [self tableHeadImageView];
}

#pragma mark - delegation

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:
   (NSInteger)section{
    if (section == 1) {
        return 32;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:
   (NSInteger)section{
    if (section == 1) {
        UIView *backGroundView = [[UIView alloc] initWithFrame:
            CGRectMake(0, 0, kSystemWide, 18+14)];
        
        UILabel *studentComment = [WMUITool initWithTextColor:[UIColor blackColor]
            withFont:[UIFont boldSystemFontOfSize:14]];
        studentComment.frame = CGRectMake(15, 18, kSystemWide-15, 14);
        studentComment.text = @"教练评论";
        [backGroundView addSubview:studentComment];
        
        UIView *lineView = [[UIView alloc] initWithFrame:
            CGRectMake(15, 0, kSystemWide-15, 1)];
        lineView.backgroundColor = RGBColor(224, 224, 224);
        [backGroundView addSubview:lineView];
        return backGroundView;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:
   (NSIndexPath *)indexPath{
    if (indexPath.row == 0 && indexPath.section == 0) {
        return 73;
    }else if (indexPath.row == 1 && indexPath.section == 0){
        return 153;
    }
    return 96;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
   (NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return self.dataArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
   (NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        static NSString *cellId = @"cellOne";
        StudentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[StudentDetailCell alloc] initWithStyle:UITableViewCellStyleDefault
               reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.studentIdLabel.text = [NSString stringWithFormat:@"ID:%@",
            self.detailModel.displayuserid];
        cell.studentNameLabel.text = self.detailModel.name;
        return cell;
        
    }else if (indexPath.row == 1 && indexPath.section == 0){
        
        static NSString *cellId = @"cellTwo";
        StudentInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[StudentInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.rainingGroundDetail.text = self.detailModel.applyschoolinfo.name;
        cell.learnProgressDetail.text = self.detailModel.subjecttwo.progress;
        cell.carTypeDetail.text = self.detailModel.carmodel.name;
        cell.addressDetail.text = self.detailModel.address;
        return cell;
    }else if (indexPath.section == 1){
       static NSString *cellId = @"cellFour";
        StudentCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[StudentCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        StudentCommentModel *model = self.dataArray[indexPath.row];
        [cell receiveCommentMessage:model];
        return cell;
    }
    return nil;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    kShowDismiss
}

@end
