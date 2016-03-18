//
//  SYStickHeaderWaterFallLayout.h
//  SYStickHeaderWaterFall
//
//  Created by 李超 on 16/3/16.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDeviceWidth [UIScreen mainScreen].bounds.size.width

#define kDeviceHeight [UIScreen mainScreen].bounds.size.height

#define kFixTop (44)   //在此修正sectionheader停留的位置

@class SYStickHeaderWaterFallLayout;

@protocol SYStickHeaderWaterFallDelegate <NSObject>

- (CGFloat)collectionView:(UICollectionView *)collectionView
     layout:(SYStickHeaderWaterFallLayout*) collectionViewLayout
     heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(SYStickHeaderWaterFallLayout *)collectionViewLayout heightForHeaderAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SYStickHeaderWaterFallLayout : UICollectionViewFlowLayout

@property (nonatomic ,assign) id<SYStickHeaderWaterFallDelegate> delegate;
//itemWidth必须设定.如果topInset和BottomInset未设定则设为(kDeviceWidth -itemWidth) /3（两行时）

@property (nonatomic, assign) CGFloat itemWidth;

@property (nonatomic, assign) CGFloat topInset;

@property (nonatomic, assign) CGFloat bottomInset;

@property (nonatomic, assign) BOOL stickyHeader;

@end
