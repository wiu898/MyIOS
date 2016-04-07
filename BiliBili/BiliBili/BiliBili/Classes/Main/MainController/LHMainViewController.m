//
//  LHMainViewController.m
//  BiliBili
//
//  Created by 李超 on 16/3/28.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

//主界面

#import "LHMainViewController.h"
#import "LHMainScroll.h"
#import "LHDescModel.h"
#import "LHDescView.h"
#import "LHTopView.h"
#import "LHSearchController.h"
#import "LHSearchView.h"
#import "LHCellController.h"
#import "LHSlideView.h"
#import "LHHistoryController.h"
#import "LHDownLoadController.h"
#import "LHSpController.h"
#import "LHShop.h"
#import <SDImageCache.h>

#define SCR [UIScreen mainScreen]

@interface LHMainViewController() <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView* scrollViewM;

@property (weak, nonatomic) IBOutlet LHTopView* topView;

@property (strong, nonatomic) NSArray *arrDict;

@property (weak, nonatomic) LHSlideView *slidView;

@property (assign, nonatomic) CGFloat lastY;

@property (strong, nonatomic) SDImageCache *imageCache;

@end

@implementation LHMainViewController

- (NSArray *)arrDict{
  
    if (_arrDict == nil) {
        
        _arrDict= [[NSArray alloc] init];
        
        _arrDict = [NSArray arrayWithObjects:@"番剧",@"推荐",@"分区",@"关注",@"发现",nil];
    }
    return _arrDict;
}

- (SDImageCache *)imageCache{

    if (_imageCache == nil) {
        _imageCache = [SDImageCache sharedImageCache];
    }
    return _imageCache;
}

- (IBAction)searchBtn:(UIButton *)sender{

    LHSearchView *searchView = [LHSearchView searchView];
    
    searchView.frame = self.view.bounds;
    
    searchView.alpha = 0;
    
    [self.view addSubview:searchView];
     
    [UIView animateWithDuration:0.25 animations:^{
        
        searchView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        searchView.alpha = 1;
        
        [self.view bringSubviewToFront:searchView];
    }];
    
    __weak typeof(self) weakSelf = self;
    
    searchView.searchBlock = ^(NSString *key){
    
        LHSearchController *seaC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"search"];
        
        seaC.keyWord = key;
        
        [weakSelf.navigationController pushViewController:seaC animated:YES];
    };
}

- (IBAction)downLoad:(id)sender{

    LHDownLoadController *vcC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DownLoad"];
    
    [self.navigationController pushViewController:vcC animated:YES];
}

- (void)viewDidLoad{

    [super viewDidLoad];
    
    self.imageCache.maxCacheAge = 60 * 60 *24;
    
    self.imageCache.shouldDecompressImages = YES;
    
    self.navigationController.navigationBarHidden = YES;
    
    [self.imageCache cleanDisk];
    
    //设置顶部五个分区数据
    self.topView.titleArr = self.arrDict;
    
    self.scrollViewM.delegate = self;
    
    LHSlideView *slideV = [LHSlideView slideViewWith];
    
    slideV.frame = CGRectMake(-SCR.bounds.size.width + 15, 0, SCR.bounds.size.width, SCR.bounds.size.height);
    
    [self.navigationController.view addSubview:slideV];
    
    [self.navigationController.view bringSubviewToFront:slideV];
    
    self.slidView = slideV;
    
    __weak typeof(self) weakSelf = self;
    
    self.topView.clickBtn = ^(NSInteger tag){
    
        weakSelf.scrollViewM.contentOffset = CGPointMake(SCR.bounds.size.width * (tag - 1), 0);
    };
    
    //添加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchBtn:) name:@"UITouchText.search" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slideView) name:@"ShowSlideView" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveTopBarDid:) name:@"moveTopBar" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushController:) name:@"pushController" object:nil];
    
    //    pushSpController
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushSpController:) name:@"pushSpController" object:nil];
    
    self.slidView.showSlide = ^(){
    
        [UIView animateWithDuration:0.5 animations:^{
            
            weakSelf.slidView.transform = CGAffineTransformMakeTranslation(SCR.bounds.size.width - 15, 0);
            
            weakSelf.slidView.shadeView.alpha = 0.55;
        }];
    };
    
    self.slidView.pushBlock = ^(UIViewController *vc){
    
        if ([vc isKindOfClass:[LHDownLoadController class]]) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                weakSelf.slidView.alpha = 0;
            });
        }
        
        [weakSelf.navigationController pushViewController:vc animated:NO];
    };
}

- (void)pushController:(NSNotification *)note{

    self.slidView.hidden = YES;
    
    LHDescModel *cellM = note.object;
    
    LHCellController *cellController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"nextView"];
    
    cellController.cellM = cellM;
    
    [self.navigationController pushViewController:cellController animated:YES];
}

- (void)pushSpController:(NSNotification *)note{

    self.slidView.hidden = YES;
    
    //推荐番剧页面数据
    LHShop *cellM = note.object;
    
    //推荐番剧页面
    LHSpController *cellController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SPView"];
    
    cellController.cellM = cellM;
    
    [self.navigationController pushViewController:cellController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
   
    [super viewWillAppear:animated];
    
    self.slidView.hidden = NO;
    
    self.slidView.alpha = 1;
}

- (void)slideView{

    [self.view bringSubviewToFront:self.slidView];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.slidView.transform = CGAffineTransformMakeTranslation(SCR.bounds.size.width - 15, 0);
        
        self.slidView.shadeView.alpha = 0.55;
    }
     completion:^(BOOL finished) {
      
         [UIView animateWithDuration:0.3 animations:^{
             
         }];
     }];
}

- (void)moveTopBarDid:(NSNotification *)note{

    CGFloat moveY = [note.object floatValue];
    
    CGFloat moveRY = moveY - self.lastY;
    
    if (self.topView.transform.ty - moveRY >= -70 && self.topView.transform.ty - moveRY <= 0) {
        
        self.topView.transform = CGAffineTransformTranslate(self.topView.transform, 0, -moveRY);
        
        self.scrollViewM.transform = CGAffineTransformTranslate(self.scrollViewM.transform, 0, -moveRY);
    }
    
    else if (self.topView.transform.ty - moveRY < -70) {
        
        self.topView.transform = CGAffineTransformMakeTranslation(0, -70);
        
        self.scrollViewM.transform = CGAffineTransformMakeTranslation(0, -70);
    }
    else if (self.topView.transform.ty - moveRY > 0) {
        
        self.topView.transform = CGAffineTransformMakeTranslation(0, 0);
        
        self.scrollViewM.transform = CGAffineTransformMakeTranslation(0, 0);
    }
    
    self.lastY = moveY;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

   self.topView.bottomView.transform = CGAffineTransformMakeTranslation(scrollView.contentOffset.x / 5, 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSUInteger tagNum = (scrollView.contentOffset.x + SCR.bounds.size.width * 0.5) / SCR.bounds.size.width + 1;
    
    [self.topView changeBtnColor:tagNum];
}

- (void)dealloc{
   
    //移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
}

@end
