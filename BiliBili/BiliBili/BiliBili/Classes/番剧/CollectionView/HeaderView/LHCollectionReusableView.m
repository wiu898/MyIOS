//
//  LHCollectionReusableView.m
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHCollectionReusableView.h"
#import "LHCellModel.h"
#import "LHCellView.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"

#define IMAGECOUNT 4

#define SCRC [UIScreen mainScreen]

@interface LHCollectionReusableView() <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageView;

@property (nonatomic, strong) NSTimer* time;

@property (nonatomic, strong) NSMutableArray* arrDict;

@property (nonatomic, strong) NSMutableArray* imageArr;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger cellNum;

@end

@implementation LHCollectionReusableView

- (NSMutableArray *)arrDict{

    if (_arrDict == nil) {
        _arrDict = [NSMutableArray array];
    }
    return _arrDict;
}

- (NSMutableArray *)imageArr{

    if (_imageArr == nil) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}

- (NSTimer *)time{
    
    if (_time == nil) {
        
        NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        _time = time;
    }
    return _time;
}


//大家都在看 - 顶部番剧
- (void)showSubView{

    if (self.arrDict.count != self.cellNum) {
        
        for (NSInteger i = 0; i< 4; i++) {
            
            LHCellView *tv = [LHCellView viewWithNib];
            
            UIView *org = [self viewWithTag:i + 1];
            
            tv.frame = org.bounds;
            
            org.backgroundColor = [UIColor clearColor];
            
            tv.tag = i+200;
            
            [org addSubview:tv];
            
            self.cellNum = self.arrDict.count;
        }
    }
    
    [self setCellData];
}

- (void)setCellData{

    for (NSInteger i = 0; i < 4; i++) {
        
        LHCellView *tv = (LHCellView *)[self viewWithTag:i + 200];
        
        tv.cellM = self.arrDict[i];
    }
}

- (void)makeADScroll{

    if (self.imageArr.count != self.count) {
        
        CGFloat imageW = SCRC.bounds.size.width;
        CGFloat imageH = self.scrollView.bounds.size.height;
        CGFloat imageX = 0;
        CGFloat imageY = 0;
        
        for (UIView *view in self.scrollView.subviews) {
            
            [view removeFromSuperview];
        }
        
        for (NSInteger i = 0; i < self.imageArr.count; i++) {
            
            UIImageView *image = [[UIImageView alloc] init];
            
            image.tag = i + 100;
            imageX = imageW *(i+1);
            image.frame = CGRectMake(imageX, imageY, imageW, imageH);
            
            [self.scrollView addSubview:image];
        }
        
        UIImageView *imageF = [[UIImageView alloc] init];
        
        imageF.tag = self.imageArr.count + 100;
        imageF.frame = CGRectMake(0, imageY, imageW, imageH);
        
        [self.scrollView addSubview:imageF];
        
        UIImageView* imageL = [[UIImageView alloc] init];
        
        imageL.tag = self.imageArr.count + 101;
        
        imageL.frame = CGRectMake(imageW * (self.imageArr.count + 1), imageY, imageW, imageH);
        
        [self.scrollView addSubview:imageL];
        
        self.scrollView.contentSize = CGSizeMake((self.imageArr.count + 2) * imageW, 0);
        
        self.scrollView.contentOffset = CGPointMake(imageW, 0);
        
        self.pageView.numberOfPages = self.imageArr.count;
        
        [self time];
        
        self.count = self.imageArr.count;
    }
    [self reCellData];
}

//得到广告轮播图图片
- (void)getADataWithURL{

    [self.imageArr removeAllObjects];
    
    //    NSURL* URLAD = [NSURL URLWithString:@"http://app.bilibili.com/api/region2/13.json?_device=android&_hwid=130a7709aeac1793&appkey=c1b107428d337928&build=402003&platform=android&ts=1449758668000&sign=9f36da5e90b8345e376a71466a078696"];
    
    AFHTTPSessionManager* managerAD = [AFHTTPSessionManager manager];
    
    [managerAD GET:@"http://app.bilibili.com/api/region2/13.json?_device=android&_hwid=130a7709aeac1793&appkey=c1b107428d337928&build=402003&platform=android&ts=1449758668000&sign=9f36da5e90b8345e376a71466a078696" parameters:nil progress:nil
     
      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
          NSDictionary *dict = [responseObject valueForKeyPath:@"result"];
          
          NSArray *dictM = [dict valueForKey:@"banners"];
          
          NSInteger num = 0;
          
          for (NSDictionary *dic in dictM) {
              
              if (num == 4) {
                  break;
              }
              NSString *icon = [dic valueForKey:@"img"];
              
              [self.imageArr addObject:icon];
              
              num++;
          }
          
          [self makeADScroll];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

- (void)reCellData{

    for (NSInteger i = 100; i < self.imageArr.count + 102; i++) {
        
        UIImageView *image = (UIImageView *)[self.scrollView viewWithTag:i];
    
        if (i == self.imageArr.count + 100) {
            [image sd_setImageWithURL:[NSURL URLWithString:[self.imageArr lastObject]]];
        }
        else if (i == self.imageArr.count + 101) {
            [image sd_setImageWithURL:[NSURL URLWithString:[self.imageArr firstObject]]];
        }
        else {
            [image sd_setImageWithURL:[NSURL URLWithString:self.imageArr[i - 100]]];
        }

    }
}

//得到顶部四个Cell数据
- (void)getCellDataWithURL{
    
    [self.arrDict removeAllObjects];
    
    //    NSURL* URL = [NSURL URLWithString:@"http://api.bilibili.com/online_list?_device=android&_hwid=130a7709aeac1793&appkey=c1b107428d337928&platform=android&typeid=13&sign=cb5cf6d54ed92fc25c4a8b4292a46692"];
    
    //    http://www.bilibili.com/api_proxy?app=bangumi&indexType=0&action=site_season_index&pagesize=100&page=1&
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://api.bilibili.com/online_list?_device=android&_hwid=130a7709aeac1793&appkey=c1b107428d337928&platform=android&typeid=13&sign=cb5cf6d54ed92fc25c4a8b4292a46692"parameters:nil progress:nil
     
      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
          NSDictionary *dictM = [responseObject valueForKeyPath:@"list"];
          
          for (NSInteger i = 0; i < 4; i++) {
              
              LHCellModel *post = [LHCellModel cellMWithDict:dictM[[NSString stringWithFormat:@"%zd",i]]];
              
              [self.arrDict addObject:post];
          }
          
          [self showSubView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];


}

- (void)awakeFromNib{

    self.scrollView.pagingEnabled = YES;
    
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    self.scrollView.delegate = self;
    
    self.pageView.currentPage = 0;
}

- (void)nextPage{

    NSInteger page = self.pageView.currentPage;
    
    if (page == self.imageArr.count - 1) {
        page = 0;
    }else{
        page++;
    }
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width * (page + 1), 0) animated:YES];
    
    self.pageView.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [_time invalidate];
    
    _time = nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSInteger page = (self.scrollView.bounds.size.width * 0.5 + self.scrollView.contentOffset.x) / (self.scrollView.bounds.size.width);
    
    if (page >= 1 && page <= self.imageArr.count) {
        
        self.pageView.currentPage = page - 1;
    }
    else if (page == 0) {
        
        self.pageView.currentPage = self.imageArr.count - 1;
    }
    else if (page == self.imageArr.count + 1) {
        
        self.pageView.currentPage = 0;
    }

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    [self time];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSInteger page = self.pageView.currentPage;
    
    if (page == self.imageArr.count - 1) {
        
        self.scrollView.contentOffset = CGPointMake(self.scrollView.bounds.size.width * (page + 1), 0);
    }
    else if (page == 0) {
        
        self.scrollView.contentOffset = CGPointMake(self.scrollView.bounds.size.width * (page + 1), 0);
    }
}

+ (instancetype)collectionHeadWith{

    return [[[NSBundle mainBundle] loadNibNamed:@"LHCollectionReusableView" owner:nil options:nil] lastObject];
}

@end
