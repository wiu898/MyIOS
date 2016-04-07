//
//  LHCmHeaderView.m
//  BiliBili
//
//  Created by 李超 on 16/4/6.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHCmHeaderView.h"
#import "LHAtScrollView.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "LHDescModel.h"
#import "LHDescView.h"
#import "LHScrollViewM.h"

#define COUNT 6

@interface LHCmHeaderView () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView* headScrollV;

@property (weak, nonatomic) IBOutlet UIPageControl* pageView;

@property (nonatomic, strong) NSTimer* time;

@property (nonatomic, strong) NSArray* arrDict;

@property (nonatomic, strong) NSArray* imageArr;

@end

@implementation LHCmHeaderView

- (void)showSubView{

    for (NSInteger i = 0; i < 4; i++) {
        
        LHDescView *tv = [LHDescView viewWithNib];
        
        UIView *org = [self viewWithTag:i + 1];
        
        tv.testM = self.arrDict[i];
        
        [org addSubview:tv];
    }
}

- (void)setScrollCell{

    LHScrollViewM * scroll = [LHScrollViewM scrollViewM];
    
    scroll.arrDict = self.arrDict;
    
    [[self viewWithTag:110] addSubview:scroll];
    
    scroll.backgroundColor = [UIColor clearColor];
}


//广告轮播图
- (void)makeADScroll{
    
    NSLog(@"进入广告");

    UIScreen *SCRC = [UIScreen mainScreen];
    
    CGFloat imageW = SCRC.bounds.size.width;
    
    CGFloat imageH = self.headScrollV.bounds.size.height;
    
    CGFloat imageX = 0;
    
    CGFloat imageY = 0;
    
    for (NSInteger i = 0; i < self.imageArr.count; i++) {
        
        UIImageView *image = [[UIImageView alloc] init];
        
        [image sd_setImageWithURL:[NSURL URLWithString:self.imageArr[i]]];
        
        imageX = imageW * (i + 1);
        
        image.frame = CGRectMake(imageX, imageY, imageW, imageH);
        
        [self.headScrollV addSubview:image];
    }
    
    UIImageView *imageF = [[UIImageView alloc] init];
    
    [imageF sd_setImageWithURL:[NSURL URLWithString:[self.imageArr lastObject]]];
    
    imageF.frame = CGRectMake(0, imageY, imageW, imageH);
    
    [self.headScrollV addSubview:imageF];
    
    UIImageView* imageL = [[UIImageView alloc] init];
    
    [imageL sd_setImageWithURL:[NSURL URLWithString:[self.imageArr firstObject]]];
    
    imageL.frame = CGRectMake(imageW * (self.imageArr.count + 1), imageY, imageW, imageH);
    
    [self.headScrollV addSubview:imageL];
    
    self.headScrollV.contentSize = CGSizeMake((self.imageArr.count + 2) * imageW, 0);
    
    self.headScrollV.contentOffset = CGPointMake(imageW, 0);
    
    self.headScrollV.pagingEnabled = YES;
    
    self.headScrollV.showsHorizontalScrollIndicator = NO;
    
    self.headScrollV.showsVerticalScrollIndicator = NO;
    
    self.headScrollV.delegate = self;
    
    self.pageView.currentPage = 0;
    
    self.pageView.numberOfPages = self.imageArr.count;
    
    //轮播时间设置
    [self time];
}

- (void)awakeFromNib{

    //    NSURL* URLAD = [NSURL URLWithString:@"http://app.bilibili.com/bangumi/operation_module?_device=android&_hwid=130a7709aeac1793&_ulv=10000&access_key=b938b895c8a7a0af574a6ae76f5631c8&appkey=c1b107428d337928&build=402003&module=banner&platform=android&screen=xxhdpi&test=0&ts=1450886166000&sign=cc078495cc06a087f954e29724bf7958"];
    
    AFHTTPSessionManager* managerAD = [AFHTTPSessionManager manager];
    
    [managerAD GET:@"http://app.bilibili.com/bangumi/operation_module?_device=android&_hwid=130a7709aeac1793&_ulv=10000&access_key=b938b895c8a7a0af574a6ae76f5631c8&appkey=c1b107428d337928&build=402003&module=banner&platform=android&screen=xxhdpi&test=0&ts=1450886166000&sign=cc078495cc06a087f954e29724bf7958" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dictM = [responseObject valueForKey:@"list"];
        
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:COUNT];
        
        for (NSDictionary *dic in dictM) {
            
            NSString *icon = [dic valueForKey:@"imageurl"];
            
            [mutablePosts addObject:icon];
        }
        
        self.imageArr = mutablePosts;
        
        [self makeADScroll];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://app.bilibili.com/bangumi/operation_module?_device=android&_hwid=130a7709aeac1793&_ulv=10000&access_key=b938b895c8a7a0af574a6ae76f5631c8&appkey=c1b107428d337928&build=402003&module=index&platform=android&screen=xxhdpi&test=0&ts=1450884356000" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *arrD = [responseObject valueForKeyPath:@"result"];
        
        NSDictionary *dictM = arrD[0];
        
        [self getDataWith:dictM];
        
        [self showSubView];
        
        NSDictionary *dictTM = arrD[1];
        
        [self getDataWith:dictTM];
        
        [self setScrollCell];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)getDataWith:(NSDictionary *)dict{

    NSArray *arr = [dict valueForKey:@"body"];
    
    NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:arr.count];
    
    for (NSInteger i = 0; i < arr.count; i++) {
        
        LHDescModel *post = [LHDescModel cellMWithDict:arr[i]];
        
        [mutablePosts addObject:post];
    }
    
    self.arrDict = mutablePosts;
}

- (void)nextPage{

    NSInteger page = self.pageView.currentPage;
    
    if (page == self.imageArr.count - 1) {
        
        page = 0;
    
    }else{
        page ++;
        
        [self.headScrollV setContentOffset:CGPointMake(self.headScrollV.bounds.size.width * (page + 1),0) animated:YES];
        
        self.pageView.currentPage = page;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [_time invalidate];
    
    _time = nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSInteger page = (self.headScrollV.bounds.size.width * 0.5 + self.headScrollV.contentOffset.x) / (self.headScrollV.bounds.size.width);
    
    if (page >= 1 && page <= self.imageArr.count) {
        
        self.pageView.currentPage = page - 1;
    }
    else if (page == 0){
        self.pageView.currentPage = self.imageArr.count - 1;
    }
    else if (page == self.imageArr.count +1){
    
        self.pageView.currentPage = 0;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    [self time];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSInteger page = self.pageView.currentPage;
    
    if (page == self.imageArr.count -1) {
        
        self.headScrollV.contentOffset = CGPointMake(self.headScrollV.bounds.size.width * (page + 1), 0);
    }
    else if (page == 0){
    
        self.headScrollV.contentOffset = CGPointMake(self.headScrollV.bounds.size.width * (page + 1), 0);
    }
}

- (NSTimer *)time{

    if (_time == nil) {
        
        NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        
        _time = time;
    }
    return _time;
}

+ (instancetype)collectionHeadWith{

    return [[[NSBundle mainBundle] loadNibNamed:@"LHCmHeaderView" owner:nil options:nil] lastObject];
}

@end
