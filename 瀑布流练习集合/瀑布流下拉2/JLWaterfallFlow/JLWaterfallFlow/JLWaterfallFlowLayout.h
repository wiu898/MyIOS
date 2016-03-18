//
//  JLWaterfallFlowLayout.h
//  JLWaterfallFlow
//
//  Created by 李超 on 16/3/16.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JLWaterfallFlowLayoutDelegate;

@interface JLWaterfallFlowLayout : UICollectionViewFlowLayout

@property (assign, nonatomic) UIEdgeInsets sectionInset;

@property (assign, nonatomic) CGFloat lineSpacing;

@property (assign, nonatomic) CGFloat itemSpacing;

@property (assign, nonatomic) CGFloat colCount;

@property (weak, nonatomic) id<JLWaterfallFlowLayoutDelegate> delegate;

@end

@protocol JLWaterfallFlowLayoutDelegate <NSObject>

@required

//item heigh
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(JLWaterfallFlowLayout *)collectionViewLayout heightForWidth:(CGFloat)
     width atIndexPath:(NSIndexPath *)indexPath;

//section header
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(JLWaterfallFlowLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;

//section footer
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(JLWaterfallFlowLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;

@end
