//
//  WSNewsContainerController.m
//  WangYiNews
//
//  Created by 李超 on 16/2/29.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "WSNewsContainerController.h"
#import "UIView+Frame.h"
#import "WSContainerController.h"
#import "WSNewsController.h"
#import "WSChannel.h"
#import "WSSearchController.h"
#import "WSDayNewsController.h"

@interface WSNewsContainerController ()

@property (strong, nonatomic) NSArray *news;

@end

@implementation WSNewsContainerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *vcs = [NSMutableArray arrayWithCapacity:self.news.count];
    
    for (WSChannel *ch in self.news) {
        
        WSNewsController *newVC = [WSNewsController newsController];
        newVC.channelUrl = ch.channelURL;
        newVC.title = ch.tname;
        newVC.channelID = ch.tid;
        [vcs addObject:newVC];
    }
    
    WSContainerController *containVC = [WSContainerController containerControllerWithSubControlers:vcs parentController:self];
    containVC.navigationBarBackgroundColor = [UIColor whiteColor];
    
    [self loadInterface];
}


- (void)loadInterface {
    
    //titleView
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar_netease"]];
    self.navigationItem.titleView = imageView;
    
    //leftitem
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navi_bell_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //rightItem
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}

- (void)leftItemClick {
    
    WSDayNewsController *dayNews = [WSDayNewsController dayNews];
    [self.navigationController pushViewController:dayNews animated:YES];
}

- (void)rightItemClick {
    
    WSSearchController *searchVC = [[WSSearchController alloc] init];
    
    [self.navigationController pushViewController:searchVC animated:YES];
    
}

#pragma mark - lazy loading

- (NSArray *)news{
    
    if (!_news) {
        
        NSArray *newArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"News.plist" ofType:nil]];
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:newArr.count];
        
        for (NSDictionary *dict in newArr) {
            
            WSChannel *ch = [WSChannel channelWithDict:dict];
            [arrM addObject:ch];
        }
        
        _news = arrM.copy;
        
    }
    return _news;
}

@end