//
//  RecommendTableCell.m
//  DouYU
//
//  Created by 李超 on 16/3/23.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "RecommendTableCell.h"
#import "FourCollectionCell.h"
#import "ZWCollectionViewFlowLayout.h"
#import "ChanelData.h"
#import "PlayerController.h"
#import "Public.h"

static NSString *cellIdentifier = @"cellIdentifier";

@interface RecommendTableCell()<ZWwaterFlowDelegate>
{

    UICollectionView *_collectionView;
    
    ZWCollectionViewFlowLayout *_flowLayout;   //自定义layout
    
    int a;

}

@end

@implementation RecommendTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initContentView];
    }
    
    return self;
}

- (void)initContentView{

    //初始化自定义layout
    _flowLayout = [[ZWCollectionViewFlowLayout alloc] init];
    _flowLayout.colMargin = 5;
    _flowLayout.rowMargin = 5;
    _flowLayout.colCount = 2;
    _flowLayout.delegate = self;
    _flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    _collectionView = [[UICollectionView alloc]
        initWithFrame:CGRectMake(0, 0, screen_width, 280*KWidth_Scale) collectionViewLayout:_flowLayout];
    
    //注册显示cell的类型
    UINib *cellNib = [UINib nibWithNibName:@"FourCollectionCell"
        bundle:nil];
    NSLog(@"nib = %@",cellNib);
    [_collectionView registerNib:cellNib forCellWithReuseIdentifier:cellIdentifier];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.bounces = NO;
    _collectionView.scrollEnabled = NO;
    _collectionView.showsVerticalScrollIndicator = NO;   //指示条
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_collectionView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 280*KWidth_Scale-1, screen_width, 1)];
    lineView.backgroundColor = RGBA(220, 220, 220, 1.0);
    
    [self addSubview:lineView];
}

#pragma mark - dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

   //重用cell
    FourCollectionCell *cell = [collectionView
        dequeueReusableCellWithReuseIdentifier:cellIdentifier
        forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[FourCollectionCell alloc] init];
        cell.chanelData = self.modelArray[indexPath.item];
    }
    
    ChanelData *data = self.modelArray[indexPath.item];

    [cell reciveChanelData:data];
    
   // cell.chanelData = data;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    ChanelData *channel = self.modelArray[indexPath.item];
    
    [self.delegate TapRecommendTableCellDelegate:channel];
    
     NSLog(@"cc:%ld--%ld--%@",(long)indexPath.section,indexPath.item,channel.room_id);
}

#pragma mark - ZWwaterFlowDelegate

- (CGFloat)ZWwaterFlow:(ZWCollectionViewFlowLayout *)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{

    return (280 * KWidth_Scale -3 * 5) / 2;
}

@end
