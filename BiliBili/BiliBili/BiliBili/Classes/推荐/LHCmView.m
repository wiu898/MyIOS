//
//  LHCmView.m
//  BiliBili
//
//  Created by 李超 on 16/3/28.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHCmView.h"
#import "AFNetWorking.h"
#import "LHCmHeaderView.h"
#import "LHCmTwoView.h"
#import "LHDescModel.h"
#import "LHDescView.h"
#import "LHScrollViewM.h"
#import "LHbottomView.h"
#import "YiRefreshHeader.h"
#import "UIImageView+WebCache.h"

@interface LHCmView () <UIScrollViewDelegate>{
  
    YiRefreshHeader *refreshHeader;
}

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) LHScrollViewM *scrollM;

@property (nonatomic, strong) NSMutableDictionary *dict;

@end


@implementation LHCmView

- (NSMutableDictionary *)dict{

    if (_dict == nil) {
        _dict = [NSMutableDictionary dictionary];
    }
    return _dict;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        
        //滑动区域
        scrollView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        self.scrollView = scrollView;
        
        self.scrollView.delegate = self;
        
        self.scrollView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:scrollView];
        
        //头部
        LHCmHeaderView *headView = [LHCmHeaderView collectionHeadWith];
        
        headView.backgroundColor = [UIColor clearColor];
        
        headView.frame = CGRectMake(0, 0, scrollView.frame.size.width, 870);
        
        [self.scrollView addSubview:headView];
        
        //中部
        LHCmTwoView *twoView = [LHCmTwoView towViewWith];
        
        twoView.backgroundColor = [UIColor clearColor];
        
        twoView.frame = CGRectMake(0, 870, scrollView.frame.size.width, 859);
        
        [self.scrollView addSubview:twoView];
        
        //中部滑动部分
        LHScrollViewM *scroll = [LHScrollViewM scrollViewM];
        
        scroll.frame = CGRectMake(0, 859 + 870 + 7 * 438, self.scrollView.frame.size.width, 244);
        
        self.scrollM = scroll;
        
        scroll.backgroundColor = [UIColor clearColor];
        
        [self.scrollView addSubview:scroll];
        
        //底部区域分为8个部分
        for (NSInteger i = 0; i < 8; i++) {
            
            LHbottomView *bottomView = [LHbottomView bottomViewWith];
            
            bottomView.backgroundColor = [UIColor clearColor];
            
            bottomView.tag = i + 300;
            
            if (i == 7) {
                 bottomView.frame = CGRectMake(0, 859 + 870 + 7 * 438 + 244, self.scrollView.frame.size.width, 438);
            }
            else{
                
                 bottomView.frame = CGRectMake(0, 859 + 870 + i * 438, self.scrollView.frame.size.width, 438);
            }
            
            [self.scrollView addSubview:bottomView];
        }
        
            self.scrollView.contentSize = CGSizeMake(0, 859 + 880 + 244 + 8 * 438 + 120);
            
            __weak typeof(self) weakSelf = self;
            
            //头部刷新
            refreshHeader = [[YiRefreshHeader alloc] init];
            
            refreshHeader.scrollView = self.scrollView;
            
            [refreshHeader header];
            
            refreshHeader.beginRefreshingBlock = ^(){
             
                //后台执行
                [weakSelf getWebData];
            };
            
            //是否在进入该界面的时候就开始进入刷新状态
            [refreshHeader beginRefreshing];
        }
    
        return self;
}

- (void)getWebData{

    [self.dict removeAllObjects];
    
    //    NSURL* URL = [NSURL URLWithString:@"http://app.bilibili.com/bangumi/operation_module?_device=android&_hwid=130a7709aeac1793&_ulv=10000&access_key=b938b895c8a7a0af574a6ae76f5631c8&appkey=c1b107428d337928&build=402003&module=index&platform=android&screen=xxhdpi&test=0&ts=1450884356000"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://app.bilibili.com/bangumi/operation_module?_device=android&_hwid=130a7709aeac1793&_ulv=10000&access_key=b938b895c8a7a0af574a6ae76f5631c8&appkey=c1b107428d337928&build=402003&module=index&platform=android&screen=xxhdpi&test=0&ts=1450884356000"  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *arr = [responseObject valueForKeyPath:@"result"];
        
        for (NSInteger i = 4; i < arr.count; i ++) {
            
            NSDictionary *dictM = arr[i];
            
            [self getDataWith:dictM];
        }
        
        [self setBottomViewData];
        
        [refreshHeader endRefreshing];
        
        [self.dict removeAllObjects];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

- (void)getDataWith:(NSDictionary *)dict{

    NSArray *arr = [dict valueForKey:@"body"];
    
    NSDictionary *arr1 = [dict valueForKey:@"head"];
    
    NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:arr.count];
    
    for (NSInteger i = 0; i < arr.count; i++) {
        
        LHDescModel *post = [LHDescModel cellMWithDict:arr[i]];
        
        [mutablePosts addObject:post];
    }
    
    [self.dict setValue:mutablePosts forKey:[NSString stringWithFormat:@"%@",[arr1 valueForKey:@"title"]]];
}

- (void)setBottomViewData{

    __block NSInteger num = 0;
    
    [self.dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSArray *arr = obj;
        
        if (arr.count == 4) {
            if (num == 8) {
                return;
            }
            
            //底部分块
            LHbottomView *bottom = (LHbottomView *)[self viewWithTag:num + 300];
            
            bottom.arrDict = arr;
            
            bottom.titleLbl.text = [key length] ? key : @"动画";
            
            num++;
        }
        if (arr.count == 6) {
            
            //中部滚动部分
            self.scrollM.arrDict = arr;
            
            self.scrollM.titleLbl.text = [key length] ? key : @"推荐番剧";
        }
        
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.y >= 0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"moveToBar" object:@(scrollView.contentOffset.y)];
    }
}

@end
