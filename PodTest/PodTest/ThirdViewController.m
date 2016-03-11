//
//  ThirdViewController.m
//  PodTest
//
//  Created by 李超 on 15/12/15.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ThirdViewController.h"
#import "UserCenterViewController.h"
#import <Masonry/Masonry.h>
#import <SVProgressHUD.h>
#import "AppointmentViewController.h"
#import "DrivingViewController.h"
#import "ToolHeader.h"
#import "AppointmentDrivingViewController.h"
#import "CoachViewController.h"
#import "LoginViewController.h"
#import "BLAVPlayerViewController.h"
#import <SDCycleScrollView.h>

@interface ThirdViewController()

@property (strong, nonatomic) UIButton *coachButton;
@property (strong, nonatomic) UIImageView *coachImageView;
@property (strong, nonatomic) UILabel *coachLabel;

@property (strong, nonatomic) UIButton *signUpButton;
@property (strong, nonatomic) UIImageView *signUpImageView;
@property (strong, nonatomic) UILabel *signUpLabel;

@property (strong, nonatomic) UIButton *cardButton;
@property (strong, nonatomic) UIImageView *cardImageView;
@property (strong, nonatomic) UILabel *cardLabel;

@property (strong, nonatomic) UIButton *purseButton;
@property (strong, nonatomic) UIImageView *purseImageView;
@property (strong, nonatomic) UILabel *purseLabel;

@property (strong, nonatomic) UIButton *messageButton;
@property (strong, nonatomic) UIImageView *messageImageView;
@property (strong, nonatomic) UILabel *messageLabel;

@property (strong, nonatomic) UIButton *myselfButton;
@property (strong ,nonatomic) UIImageView *myselfImageView;
@property (strong, nonatomic) UILabel *myselfLabel;

@property (strong, nonatomic) UIScrollView *backGroundScrollView;
@property (strong, nonatomic) UIView *backGroundView;

@property (strong, nonatomic) SDCycleScrollView *loopView;

@end

@implementation ThirdViewController

- (UIView *)backGroundView{
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _backGroundView;
}

- (UIScrollView *)backGroundScrollView{
    if (_backGroundScrollView == nil) {
        _backGroundScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _backGroundScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _backGroundScrollView;
}

#pragma mark - 我的预约

- (UIButton *)coachButton{
    if (_coachButton == nil) {
        _coachButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _coachButton.backgroundColor = RGBColor(255,102,51);
        _coachButton.layer.cornerRadius = 2;
        
        [_coachButton setTitleColor:[UIColor blackColor]
            forState:UIControlStateNormal];
        [_coachButton addTarget:self action:@selector(dealCoach:)
            forControlEvents:UIControlEventTouchUpInside];
    }
    return _coachButton;
}

- (UIImageView *)coachImageView{
    if (_coachImageView == nil) {
        _coachImageView = [[UIImageView alloc] init];
        _coachImageView.image = [UIImage imageNamed:@"首页_我的预约"];
    }
    return _coachImageView;
}

- (UILabel *)coachLabel{
    if (_coachLabel == nil) {
        _coachLabel = [[UILabel alloc] init];
        _coachLabel.font = [UIFont systemFontOfSize:11];
        _coachLabel.textColor = [UIColor whiteColor];
        _coachLabel.text = @"科三预约列表";
        _coachLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _coachLabel;
}

#pragma mark - 预约学车

- (UIButton *)signUpButton{
    if (_signUpButton == nil) {
        _signUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _signUpButton.backgroundColor = RGBColor(255,153,0);
        _signUpButton.layer.cornerRadius = 2;
        
        [_signUpButton addTarget:self action:@selector(dealSignUp:)
            forControlEvents:UIControlEventTouchUpInside];
    }
    return _signUpButton;
}

- (UIImageView *)signUpImageView{
    if (_signUpImageView == nil) {
        _signUpImageView = [[UIImageView alloc] init];
        _signUpImageView.image = [UIImage imageNamed:@"首页_预约学车"];
    }
    return _signUpImageView;
}

- (UILabel *)signUpLabel{
    if (_signUpLabel == nil) {
        _signUpLabel = [[UILabel alloc] init];
        _signUpLabel.font = [UIFont systemFontOfSize:11];
        _signUpLabel.textColor = [UIColor whiteColor];
        _signUpLabel.text = @"我要学车";
        _signUpLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _signUpLabel;
}

#pragma mark - 课件

- (UIButton *)cardButton{
    if (_cardButton == nil) {
        _cardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cardButton.backgroundColor = RGBColor(189,31,74);
        _cardButton.layer.cornerRadius = 2;
        
        [_cardButton addTarget:self action:@selector(dealCard:)
            forControlEvents:UIControlEventTouchUpInside];
    }
    return _cardButton;
}

- (UIImageView *)cardImageView{
    if (_cardImageView == nil) {
        _cardImageView = [[UIImageView alloc] init];
        _cardImageView.image = [UIImage imageNamed:@"首页_课件"];
    }
    return _cardImageView;
}

- (UILabel *)cardLabel{
    if (_cardLabel == nil) {
        _cardLabel = [[UILabel alloc] init];
        _cardLabel.font = [UIFont systemFontOfSize:11];
        _cardLabel.textColor = [UIColor whiteColor];
        _cardLabel.text = @"科三课件";
        _cardLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _cardLabel;
}

#pragma mark - 钱包

- (UIButton *)purseButton{
    if (_purseButton == nil) {
        _purseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _purseButton.backgroundColor = RGBColor(1,160,0);
        _purseButton.layer.cornerRadius = 2;
        
        [_purseButton addTarget:self action:@selector(dealPurse:)
            forControlEvents:UIControlEventTouchUpInside];
    }
    return _purseButton;
}

- (UIImageView *)purseImageView{
    if (_purseImageView == nil) {
        _purseImageView = [[UIImageView alloc] init];
        _purseImageView.image = [UIImage imageNamed:@"首页_钱包"];
    }
    return _purseImageView;
}

- (UILabel *)purseLabel{
    if (_purseLabel == nil) {
        _purseLabel = [[UILabel alloc] init];
        _purseLabel.font = [UIFont systemFontOfSize:11];
        _purseLabel.textColor = [UIColor whiteColor];
        _purseLabel.text = @"钱包";
        _purseLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _purseLabel;
}

#pragma mark - 消息

- (UIButton *)messageButton{
    if (_messageButton == nil) {
        _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _messageButton.backgroundColor = RGBColor(0,148,166);
        _messageButton.layer.cornerRadius = 2;
        
        [_messageButton addTarget:self action:@selector(dealMessage:)
            forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageButton;
}

- (UIImageView *)messageImageView{
    if (_messageImageView == nil) {
        _messageImageView = [[UIImageView alloc] init];
        _messageImageView.image = [UIImage imageNamed:@"首页_消息"];
    }
    return _messageImageView;
}

- (UILabel *)messageLabel{
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont systemFontOfSize:11];
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.text = @"消息";
        _messageLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _messageLabel;
}

#pragma mark - 我的
- (UIButton *)myselfButton{
    if (_myselfButton == nil) {
        _myselfButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _myselfButton.backgroundColor = RGBColor(45,138,239);
        _myselfButton.layer.cornerRadius = 2;
        
        [_myselfButton addTarget:self action:@selector(dealMyself:)
            forControlEvents:UIControlEventTouchUpInside];
    }
    return _myselfButton;
}

- (UIImageView *)myselfImageView{
    if (_myselfImageView == nil) {
        _myselfImageView = [[UIImageView alloc] init];
        _myselfImageView.image = [UIImage imageNamed:@"首页_我的"];
    }
    return _myselfImageView;
}

- (UILabel *)myselfLabel{
    if (_myselfLabel == nil) {
        _myselfLabel = [[UILabel alloc] init];
        _myselfLabel.font = [UIFont systemFontOfSize:11];
        _myselfLabel.textColor = [UIColor whiteColor];
        _myselfLabel.text = @"我的";
        _myselfLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _myselfLabel;
}

- (void)viewDidLoad{

    [super viewDidLoad];
    
    if (kSystemHeight == 480) {
        self.backGroundView.frame = CGRectMake(0, 0, 320, 568);
        self.backGroundScrollView.contentSize = CGSizeMake(320,568);
    }
    
    _loopView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0,
        kSystemWide, kSystemWide*0.6)];
    
    _loopView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:
     @selector(bannerChange) name:@"kBannerChange" object:nil];
    
    [self.view addSubview:self.backGroundScrollView];
    
    [self.backGroundScrollView addSubview:self.backGroundView];
    
    [self.backGroundView addSubview:_loopView];
    
    [self.backGroundView addSubview:self.coachButton];
    
    [self.backGroundView addSubview:self.signUpButton];
    
    [self.backGroundView addSubview:self.cardButton];
    
    [self.backGroundView addSubview:self.purseButton];
    
    [self.backGroundView addSubview:self.messageButton];
    
    [self.backGroundView addSubview:self.myselfButton];
    
    //自动布局
    
    [self.coachButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loopView.mas_bottom).with.offset(5);
        make.left.mas_equalTo(self.backGroundView.mas_left).with.offset(5);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.64];
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.672];
        make.width.mas_equalTo(wide);
        make.height.mas_equalTo(height);
    }];
    
    [self.coachButton addSubview:self.coachImageView];
    [self.coachButton addSubview:self.coachLabel];
    
    [self.coachImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.coachButton.mas_centerX);
        make.centerY.mas_equalTo(self.coachButton.mas_centerY);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.184];
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.20];
        make.width.mas_equalTo(wide);
        make.height.mas_equalTo(height);
    }];
    
    [self.coachLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coachButton.mas_left).with.offset(8);
        make.bottom.mas_equalTo(self.coachButton.mas_bottom).with.offset(-8);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.31];
        make.width.mas_equalTo(wide);
    }];
    
    [self.signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coachButton.mas_top).with.offset(0);
        make.left.mas_equalTo(self.coachButton.mas_right).with.offset(5);
        make.right.mas_equalTo(self.backGroundView.mas_right).with.offset(-5);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.3281];
        make.height.mas_equalTo(height);
    }];
    
    [self.signUpButton addSubview:self.signUpImageView];
    [self.signUpButton addSubview:self.signUpLabel];
    
    [self.signUpImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.signUpButton.mas_centerX);
        make.centerY.mas_equalTo(self.signUpButton.mas_centerY);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.1];
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.098];
        make.width.mas_equalTo(wide);
        make.height.mas_equalTo(height);
    }];
    
    [self.signUpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.signUpButton.mas_left).with.offset(8);
        make.bottom.mas_equalTo(self.signUpButton.mas_bottom).with.offset(-8);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.195];
        make.width.mas_equalTo(wide);
    }];
    
    [self.cardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.signUpButton.mas_bottom).with.offset(5);
        make.right.mas_equalTo(self.backGroundView.mas_right).with.offset(-5);
        make.left.mas_equalTo(self.coachButton.mas_right).with.offset(5);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.3281];
        make.height.mas_equalTo(height);
    }];
    
    [self.cardButton addSubview:self.cardImageView];
    [self.cardButton addSubview:self.cardLabel];
    
    [self.cardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.cardButton.mas_centerX);
        make.centerY.mas_equalTo(self.cardButton.mas_centerY);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.1328];
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.08125];
        make.width.mas_equalTo(wide);
        make.height.mas_equalTo(height);
    }];
    
    [self.cardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cardButton.mas_left).with.offset(8);
        make.bottom.mas_equalTo(self.cardButton.mas_bottom).with.offset(-8);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.195];
        make.width.mas_equalTo(wide);
    }];
    
    [self.purseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coachButton.mas_bottom).with.offset(5);
        make.left.mas_equalTo(self.backGroundView.mas_left).with.offset(5);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.3125];
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.3281];
        make.width.mas_equalTo(wide);
        make.height.mas_equalTo(height);
    }];
    
    [self.purseButton addSubview:self.purseImageView];
    [self.purseButton addSubview:self.purseLabel];
    
    [self.purseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.purseButton.mas_centerX);
        make.centerY.mas_equalTo(self.purseButton.mas_centerY);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.10];
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.08];
        make.width.mas_equalTo(wide);
        make.height.mas_equalTo(height);
    }];
    
    [self.purseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.purseButton.mas_left).with.offset(8);
        make.bottom.mas_equalTo(self.purseButton.mas_bottom).with.offset(-8);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.195];
        make.width.mas_equalTo(wide);
    }];
    
    [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.purseButton.mas_right).with.offset(5);
        make.top.mas_equalTo(self.coachButton.mas_bottom).with.offset(5);
        NSNumber *wide =[NSNumber numberWithFloat:kSystemWide*0.3125];
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.3281];
        make.width.mas_equalTo(wide);
        make.height.mas_equalTo(height);
    }];
    
    [self.messageButton addSubview:self.messageImageView];
    [self.messageButton addSubview:self.messageLabel];
    
    [self.messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.messageButton.mas_centerX);
        make.centerY.mas_equalTo(self.messageButton.mas_centerY);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.095];
        make.width.mas_equalTo(wide);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.092];
        make.height.mas_equalTo(height);
    }];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.messageButton.mas_left).with.offset(8);
        make.bottom.mas_equalTo(self.messageButton.mas_bottom).with.offset(-8);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.195];
        make.width.mas_equalTo(wide);
    }];

    
    [self.myselfButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.centerY.mas_equalTo(self.purseButton.mas_centerY);
        
        make.left.mas_equalTo(self.messageButton.mas_right).with.offset(5);
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(-5);
        make.top.mas_equalTo(self.coachButton.mas_bottom).with.offset(5);
        
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.328];
        make.height.mas_equalTo(height);
    }];
    
    [self.myselfButton addSubview:self.myselfImageView];
    [self.myselfButton addSubview:self.myselfLabel];
    
    [self.myselfImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.myselfButton.mas_centerX);
        make.centerY.mas_equalTo(self.myselfButton.mas_centerY);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.09];
        make.width.mas_equalTo(wide);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.10];
        make.height.mas_equalTo(height);
    }];
    
    [self.myselfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.myselfButton.mas_left).with.offset(8);
        make.bottom.mas_equalTo(self.myselfButton.mas_bottom).with.offset(-8);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.195];
        make.width.mas_equalTo(wide);
    }];

}

//科三预约列表
- (void)dealCoach:(UIButton *)sender{
    DYNSLog(@"我的预约列表");
    AppointmentViewController *appointment = [[AppointmentViewController alloc] init];
    appointment.title = @"科三预约列表";
    appointment.markNum = [NSNumber numberWithInteger:3];
    [self.navigationController pushViewController:appointment animated:YES];
    
}

//科三课件
- (void)dealCard:(UIButton *)sender{
    BLAVPlayerViewController *player = [[BLAVPlayerViewController alloc] init];
    player.title = @"科三课件";
    player.markNum = [NSNumber numberWithInteger:3];
    [self.navigationController pushViewController:player animated:YES];
}

//我要预约
- (void)dealSignUp:(UIButton *)sender{
    AppointmentDrivingViewController *appointment =
       [[AppointmentDrivingViewController alloc] init];
    [self.navigationController pushViewController:appointment animated:YES];
}

//个人中心
- (void)dealMyself:(UIButton *)sender {
    if (![AccountManager isLogin]) {
        DYNSLog(@"islogin = %d",[AccountManager isLogin]);
        LoginViewController *login = [[LoginViewController alloc] init];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:nil];
        return;
    }
    UserCenterViewController *userCenter = [[UserCenterViewController alloc] init];
    [self.navigationController pushViewController:userCenter animated:YES];
}

- (void)bannerChange{
    NSMutableArray *bannerUrl = [[NSMutableArray alloc] init];
    NSMutableArray *titleArray = [[NSMutableArray alloc] init];
    for (BannerModel *banner in [AccountManager getBannerUrlArray]) {
        [bannerUrl addObject:banner.headportrait.originalpic];
        [titleArray addObject:banner.newsname];
    }
    
    _loopView.imageURLStringsGroup = bannerUrl;
    _loopView.titlesGroup = titleArray;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    kShowDismiss
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSMutableArray *bannerUrl = [[NSMutableArray alloc] init];
    NSMutableArray *titleArray = [[NSMutableArray alloc] init];
    for (BannerModel *banner in [AccountManager getBannerUrlArray]) {
        [bannerUrl addObject:banner.headportrait.originalpic];
        [titleArray addObject:banner.newsname];
    }
    _loopView.imageURLStringsGroup = bannerUrl;
    _loopView.titlesGroup = titleArray;
}



@end
