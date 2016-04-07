//
//  LHSpController.m
//  BiliBili
//
//  Created by 李超 on 16/3/28.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHSpController.h"
#import "LHParam.h"
#import "LHShop.h"
#import "LHBtnBar.h"
#import "LHSpScrollView.h"
#import "LHWebAVPlayer.h"
#import "MoviePlayerViewController.h"
#import "UIImageView+WebCache.h"

@interface LHSpController() <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView* icon;

@property (weak, nonatomic) IBOutlet UILabel* name;

@property (weak, nonatomic) IBOutlet UILabel* play;

@property (weak, nonatomic) IBOutlet UILabel* danmu;

@property (weak, nonatomic) IBOutlet UILabel* timeLink;

@property (weak, nonatomic) IBOutlet UILabel* avNum;

@property (nonatomic, strong) NSArray* arrDict;

@property (weak, nonatomic) IBOutlet UIView* topView;

@property (weak, nonatomic) IBOutlet UIView* senView;

@property (weak, nonatomic) IBOutlet LHBtnBar* btnBar;

@property (nonatomic, assign) CGFloat lastY;

@property (weak, nonatomic) IBOutlet LHSpScrollView* spScrollView;

@end

@implementation LHSpController

- (NSArray *)arrDict{

    if (_arrDict == nil) {
        _arrDict = [NSArray arrayWithObjects:@"承包商排行",@"番剧详情",@"评论",nil];
    }
    return _arrDict;
}

- (void)viewDidLoad{

    [super viewDidLoad];
    
    //番剧图片
    [self.icon sd_setImageWithURL:[NSURL URLWithString:self.cellM.cover]];
    
    //番剧名称
    self.name.text = self.cellM.title;
    
    //番剧播放次数
    self.play.text = [NSString stringWithFormat:@"%@", self.cellM.play_count > 10000 ? [NSString stringWithFormat:@"%0.1f万", (self.cellM.play_count / 10000.0)] : [NSString stringWithFormat:@"%zd", self.cellM.play_count]];
    
    //番剧弹幕数量
    self.danmu.text = [NSString stringWithFormat:@"%@", self.cellM.danmaku_count > 10000 ? [NSString stringWithFormat:@"%0.1f万", (self.cellM.danmaku_count / 10000.0)] : [NSString stringWithFormat:@"%zd", self.cellM.danmaku_count]];
    
    //是连载状态还是完结
    if (self.cellM.is_finish == 0) {
        
        self.timeLink.text = [NSString stringWithFormat:@"连载中,每周%zd更新",self.cellM.weekday];
    }else{
    
      self.timeLink.text = @"完结";
    }
    
    self.btnBar.titleArr = self.arrDict;   //三大标题--承包商排行、番剧详情、评论
    
    self.spScrollView.delegate = self;
    
    self.spScrollView.cellM = self.cellM;
    
    __weak typeof(self) weakSelf = self;
    
    //点击三大标题,变化X
    self.btnBar.clickBtn = ^(NSInteger tag){
    
       weakSelf.spScrollView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width * (tag - 1), 0);
    };
    
    self.spScrollView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width, 0);
    
    [self scrollViewDidScroll:self.spScrollView];
    
    [self scrollViewDidEndDecelerating:self.spScrollView];
    
    [self.view bringSubviewToFront:self.topView];
    
    //注册观察者
    
    //点击标题
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveSpTopBarDid:) name:@"moveSpTopBar" object:nil];
    
    //视频播放
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerSpAV:) name:@"playerSpAV" object:nil];
}

//点击标题触发事件
- (void)moveSpTopBarDid:(NSNotification *)note{
 
    CGFloat moveY = [note.object floatValue];
    
    CGFloat moveRY = moveY - self.lastY;
    
    if (self.btnBar.transform.ty - moveRY >= -160 && self.btnBar.transform.ty - moveRY <= 0) {
        
        self.btnBar.transform = CGAffineTransformTranslate(self.btnBar.transform, 0, -moveRY);
        self.senView.transform = CGAffineTransformTranslate(self.btnBar.transform, 0, -moveRY);
        
        self.spScrollView.transform = CGAffineTransformTranslate(self.spScrollView.transform, 0, -moveRY);
    }
    
    else if (self.btnBar.transform.ty - moveRY < -160) {
        
        self.btnBar.transform = CGAffineTransformMakeTranslation(0, -160);
        
        self.senView.transform = CGAffineTransformMakeTranslation(0, -160);
        
        self.spScrollView.transform = CGAffineTransformMakeTranslation(0, -160);
    }
    
    else if (self.btnBar.transform.ty - moveRY > 0) {
        
        self.btnBar.transform = CGAffineTransformMakeTranslation(0, 0);
        
        self.senView.transform = CGAffineTransformMakeTranslation(0, 0);
        
        self.spScrollView.transform = CGAffineTransformMakeTranslation(0, 0);
    }
    
    self.lastY = moveY;

}

- (void)playerSpAV:(NSNotification *)note{

    self.view.userInteractionEnabled = NO;
    
    LHParam *param = note.object;
    
    LHWebAVPlayer *player = [[LHWebAVPlayer alloc] init];
    
    MoviePlayerViewController *movieController = [[MoviePlayerViewController alloc] init];
    
    __weak typeof(movieController) weakMovie = movieController;
    
    __weak typeof(self) weakSelf = self;
    
    //点击播放视频
    player.AVPlayer = ^(NSArray *url){
       
        NSString *urlString = [url firstObject];
        
        weakMovie.url = urlString;
        
        weakMovie.danmaku = param.danmaku;
        
        if (urlString.length) {
            
            if (weakSelf.presentedViewController == nil) {
                
                [weakSelf presentViewController:movieController animated:NO completion:nil];
            }
        }else{
        
            self.view.userInteractionEnabled = YES;
        }
    };
    
    player.param = param.param;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    self.btnBar.bottomView.transform = CGAffineTransformMakeTranslation(scrollView.contentOffset.x / 5, 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSUInteger tagNum = (scrollView.contentOffset.x + [UIScreen mainScreen].bounds.size.width * 0.5) / [UIScreen mainScreen].bounds.size.width + 1;
    
    [self.btnBar changeBtnColor:tagNum];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
    self.view.userInteractionEnabled = YES;
}


- (IBAction)popBtn:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];
}

//删除观察者
- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning{

    [super didReceiveMemoryWarning];
}

@end
