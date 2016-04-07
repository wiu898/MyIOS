//
//  LHDgView.m
//  BiliBili
//
//  Created by 李超 on 16/3/28.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHDgView.h"
#import "LHCollectionReusableView.h"
#import "LHShop.h"
#import "LHShopCell.h"
#import "LHShopFlowLayout.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "YiRefreshHeader.h"

@interface LHDgView() <UICollectionViewDelegate,
    UICollectionViewDataSource,LHShopFlowLayoutDelegate>
{

    YiRefreshHeader *refreshHeader;
    
}

@property (weak, nonatomic) LHShopFlowLayout *flowLayoutC;

@property (weak, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *arrDict;

@property (weak, nonatomic) LHCollectionReusableView *headerView;

@end

@implementation LHDgView

//获取底部cell资源
- (void)reload:(__unused id)sender{

    //    NSURL *URL = [NSURL URLWithString:@"http://app.bilibili.com/bangumi/timeline_v2"];
    
    //    http://www.bilibili.com/api_proxy?app=bangumi&indexType=0&action=site_season_index&pagesize=100&page=1&
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager  GET:@"http://app.bilibili.com/bangumi/timeline_v2"
       parameters:nil progress:nil
     
      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
          NSArray *postFromResponse = [NSArray arrayWithArray:[responseObject valueForKeyPath:@"list"]];
          
          NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postFromResponse count]];
          
          for (NSInteger i = 0; i < postFromResponse.count; i++) {
              
              NSDictionary *dict = postFromResponse[i];
              
              LHShop *shop = [LHShop shopWithDict:dict];
              
              [mutablePosts addObject:shop];
          }
          
          self.arrDict = mutablePosts;
          
          [self.collectionView reloadData];
          
          [refreshHeader endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        LHShopFlowLayout *flowLayout = [[LHShopFlowLayout alloc] init];
        
        self.flowLayoutC = flowLayout;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
        
        self.collectionView = collectionView;
        
        //注册底部cell
        UINib *cellNib = [UINib nibWithNibName:@"LHShopCell" bundle:nil];
        
        [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"dgcell"];
        
        //注册头部
        UINib *headNib = [UINib nibWithNibName:@"LHCollectionReusableView" bundle:nil];
        
        [self.collectionView registerNib:headNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"jufanhead"];
        
        self.flowLayoutC.colNum = 2;
        
        self.flowLayoutC.delegate = self;
        
        self.collectionView.backgroundColor = [UIColor clearColor];
        
        self.collectionView.delegate = self;
        
        self.collectionView.dataSource = self;
        
        [self addSubview:self.collectionView];
        
        __weak typeof(self) weakSelf = self;
        
        // YiRefreshHeader 头部刷新按钮的使用
        refreshHeader = [[YiRefreshHeader alloc] init];
        
        refreshHeader.scrollView = self.collectionView;
        
        [refreshHeader header];
        
        refreshHeader.beginRefreshingBlock = ^(){
        
            //后台执行
            [weakSelf.headerView getADataWithURL];     //得到轮播图资源
            [weakSelf.headerView getCellDataWithURL];  //得到顶部cell资源
            [weakSelf reload:nil];
        };
        
        //是否在进入页面的时候就开始进入刷新状态
        [refreshHeader beginRefreshing];
    }
    
    return self;
}

#pragma mark - deldegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    //底部推荐番剧
    LHShopCell *cell = (LHShopCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    //注册观察者
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushSpController" object:cell.shop];
}

//绘制header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    LHCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"jufanhead" forIndexPath:indexPath];
    
    self.headerView = header;
    
    return header;
}

#pragma mark - flowLayoutDelegate

- (CGFloat)shopFlowLayoutWithHight:(LHShopFlowLayout *)flowLayout layoutWitdh:(CGFloat)cellW forIndex:(NSIndexPath *)indexP{

    LHShop *shop = self.arrDict[indexP.item];
    
    return cellW * 1.5 + [shop.title boundingRectWithSize:CGSizeMake(cellW-16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:13.0] } context:nil].size.height;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.y >= 0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"moveTopBar" object:@(scrollView.contentOffset.y)];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  
    return self.arrDict.count;
}

//绘制cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    LHShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dgcell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.shop = self.arrDict[indexPath.item];
    
    return cell;
}

@end
