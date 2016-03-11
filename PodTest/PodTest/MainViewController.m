//
//  MainViewController.m
//  PodTest
//
//  Created by 李超 on 15/12/4.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "MainViewController.h"
#import "BottomMenu.h"
#import <SVProgressHUD.h>
#import "FirstViewController.h"
#import "SubjectFirstViewController.h"
#import "SubjectSecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "BaseContainViewController.h"
#import "UIView+CalculateUIView.h"
#import "AccountManager.h"


static NSString *kConversationChatter = @"ConversationChatter";

static NSString *const kBnnerImageUrl = @"info/headlinenews";

static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";

@interface MainViewController ()<BaseContainViewControllerDelegate,BottomMenuDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) BaseContainViewController *baseContain;
@property (strong, nonatomic) BottomMenu *menu;
@property (strong, nonatomic) NSArray *titleNameArray;
@property (strong, nonatomic) NSDate *lastPlaySoundDate;

@end

@implementation MainViewController

- (NSArray *)titleNameArray {
    if (_titleNameArray == nil) {
        _titleNameArray = @[@"报名",@"科目1",@"科目2"];
    }
    return _titleNameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"kLoginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(quitSuccess) name:@"kQuitSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userapplysuccess) name:@"kuserapplysuccess" object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"一步学车";
    
    FirstViewController *firstViewController = [[FirstViewController alloc] init];
    firstViewController.title = @"报名";
    
    SubjectFirstViewController *subjectFirst = [[SubjectFirstViewController alloc] init];
    subjectFirst.title = @"科目一";
    
    SubjectSecondViewController *subjectSecond = [[SubjectSecondViewController alloc] init];
    subjectSecond.title = @"科目二";
    
    ThirdViewController *third = [[ThirdViewController alloc] init];
    third.title = @"科目三";
    
    FourViewController *four = [[FourViewController alloc] init];
    four.title = @"科目四";
    
    _baseContain = [[BaseContainViewController alloc] initWIthChildViewControllerItems:@[firstViewController,subjectFirst,subjectSecond,third,four]];
    
    _baseContain.delegate = self;
    
    [self addChildViewController:_baseContain];
    [self.view addSubview:_baseContain.view];
    [_baseContain didMoveToParentViewController:self];
    
    _menu = [[BottomMenu alloc] initWithFrame:CGRectMake(0, self.view.calculateFrameWithHeight-44, self.view.calculateFrameWithWide, 44)
            withItems:@[firstViewController,subjectFirst,subjectSecond,third,four]];

    _menu.delegate = self;
    [self.view addSubview:_menu];
}

//视图即将可见时调用,默认情况下不执行任何操作
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

//视图被返回是调用，覆盖或者以其他方式隐藏，默认不执行
- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)horizontalScrollPageIndex:(NSUInteger)index {
    
    
    [_menu menuScrollWithIndex:index];
    //    self.title = self.titleNameArray[index];
}
- (void)horizontalMenuScrollPageIndex:(NSUInteger)index {
    
    [_baseContain replaceVcWithIndex:index];
    //    self.title = self.titleNameArray[index];
    
}

- (void)userapplysuccess{
    [_menu menuScrollWithIndex:1];
    [_baseContain replaceVcWithIndex:1];
}

- (void)quitSuccess{
    [_menu menuScrollWithIndex:0];
    [_baseContain replaceVcWithIndex:0];
}

- (void)loginSuccess{
    NSUInteger index = [AccountManager manager].userSubject.subjectId.integerValue;
    [_menu menuScrollWithIndex:index];
    [_baseContain replaceVcWithIndex:index];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
