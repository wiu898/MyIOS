//
//  OnlineViewController.m
//  DouYU
//
//  Created by 李超 on 16/3/22.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "OnlineViewController.h"
#import "ZWCollectionViewFlowLayout.h"
#import "FourCollectionCell.h"
#import "NetworkSingleton.h"
#import "OnlineModel.h"
#import "MJExtension.h"
#import "MJRefresh.h"

#define URL @"http://www.douyutv.com/api/v1/live?aid=ios&auth=b317487532542c2f8200f374f3153da2&client_sys=ios&limit=20"

#define URL_a @"0"
#define URL_b @"time=1446684180"

static NSString *cellIdentifier = @"OnlineViewCell";

@interface OnlineViewController()<UICollectionViewDataSource,
   UICollectionViewDelegate,ZWwaterFlowDelegate>
{

    UICollectionView *_collectionView;
    
    NSMutableArray *_dataArray;
    
    ZWCollectionViewFlowLayout *_flowLayout;   //自定义layout
    
    int times;  //记录上拉次数
   
}

@end

@implementation OnlineViewController

- (void)viewDidLoad{

    [super viewDidLoad];
    
    times = 0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
    
    [self initCollectionView];
    
    [self loadMoreData];
    
}

- (void)loadData{
    
    NSString *url = [NSString stringWithFormat:@"%@&offset=%@&time=%@",URL,URL_a,URL_b];


    [[NetworkSingleton sharedManager] getResultWithParameter:nil url:url
      successBlock:^(id responseBody) {
        
        
          _dataArray = [OnlineModel objectArrayWithKeyValuesArray:
             [responseBody objectForKey:@"data"]];
          
          [_collectionView reloadData];
          
    } failureBlock:^(NSString *error) {
      
        
    }];
}

- (void)loadMoreData{
    
    //顶部刷新
    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSString *url = [NSString stringWithFormat:@"%@&offset=%@&time=%@",URL,URL_a,URL_b];
        
        [[NetworkSingleton sharedManager] getResultWithParameter:nil url:url
          successBlock:^(id responseBody) {
              
              _dataArray = [OnlineModel objectArrayWithKeyValuesArray:[responseBody objectForKey:@"data"]];
              
              [_collectionView reloadData];
              
              [_collectionView.header endRefreshing];
            
        } failureBlock:^(NSString *error) {
            
            [_collectionView.header endRefreshing];
            
        }];
        
    }];
    
    [_collectionView.header beginRefreshing];
    
    _collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
        times+=20;
        
        NSString *time=[NSString stringWithFormat:@"%d",times];
        
        NSString *url = [NSString stringWithFormat:@"%@&offset=%@&time=%@",URL,time,URL_b];
        
        [[NetworkSingleton sharedManager] getResultWithParameter:nil url:url
           successBlock:^(id responseBody) {
               
               NSArray *array = [OnlineModel objectArrayWithKeyValuesArray:[responseBody objectForKey:@"data"]];
               
               for(OnlineModel *moreData in array){
               
                   [_dataArray addObject:moreData];
               }
               
               [_collectionView reloadData];
               
               [_collectionView.footer endRefreshing];
               
           } failureBlock:^(NSString *error) {
               
               [_collectionView.footer endRefreshing];
               
           }];
        
    }];
    
    _collectionView.footer.hidden = YES;
    
}

- (void)initCollectionView{

    //初始化layout
    _flowLayout = [[ZWCollectionViewFlowLayout alloc] init];
    _flowLayout.colMargin = 5;
    _flowLayout.rowMargin = 5;
    _flowLayout.colCount = 2;
    _flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    _flowLayout.delegate = self;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame
        collectionViewLayout:_flowLayout];
    
    //注册cell
    UINib *cellNib = [UINib nibWithNibName:@"FourCollectionCell" bundle:nil];
    
    [_collectionView registerNib:cellNib forCellWithReuseIdentifier:cellIdentifier];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = RGBA(200, 200, 200, 0.25);
    
    [self.view addSubview:_collectionView];
}

#pragma mark - CollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

     //重用cell
    FourCollectionCell *cell = [collectionView
        dequeueReusableCellWithReuseIdentifier:cellIdentifier
        forIndexPath:indexPath];
    
    OnlineModel *data = _dataArray[indexPath.item];
    
    [cell reciveOnlineDataWith:data];
    
    return cell;
}

#pragma mark - CollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"你点击了 %ld--%ld",(long)indexPath.section,indexPath.item);
}

#pragma mark - ZWwaterFlowDelegate

- (CGFloat)ZWwaterFlow:(ZWCollectionViewFlowLayout *)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{

    return 150 * KWidth_Scale;
}

- (void)didReceiveMemoryWarning{

    [super didReceiveMemoryWarning];
}

@end
