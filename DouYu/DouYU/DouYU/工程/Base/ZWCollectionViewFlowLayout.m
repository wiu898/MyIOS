//
//  ZWCollectionViewFlowLayout.m
//  DouYU
//
//  Created by 李超 on 16/3/22.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "ZWCollectionViewFlowLayout.h"

@interface ZWCollectionViewFlowLayout()

@property (retain, nonatomic) NSMutableDictionary *maxYdic;

@end

@implementation ZWCollectionViewFlowLayout

- (NSMutableDictionary *)maxYdic{

    if (_maxYdic == nil) {
        
        _maxYdic = [[NSMutableDictionary alloc] init];
    }
    return _maxYdic;
}

- (instancetype)init{

    if (self = [super init]) {
        
        self.colMargin = 0;
        self.rowMargin = 0;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.colCount = 2;
    }
    return self;
}

- (void)prepareLayout{

    [super prepareLayout];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return YES;
}

- (CGSize)collectionViewContentSize{

    __block NSString *maxCol = @"0";
    
    //找出最大的列
    [self.maxYdic enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        
        if ([maxY floatValue] > [self.maxYdic[maxCol] floatValue]) {
            
            maxCol = column;
        }
    }];
    
    return CGSizeMake(0, [self.maxYdic[maxCol] floatValue]);

}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
 
   __block NSString *minCol = @"0";
    
    //找出最短的列
    [self.maxYdic enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        
        if ([maxY floatValue] < [self.maxYdic[minCol] floatValue]) {
            minCol = column;
        }
    }];
    
    //计算宽度
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInset.left-self.sectionInset.right - (self.colCount-1) * self.colMargin)/self.colCount;
    
    //计算高度
    CGFloat height = [self.delegate ZWwaterFlow:self heightForWidth:width atIndexPath:indexPath];
    
    CGFloat x = self.sectionInset.left + (width + self.colMargin) * [minCol intValue];
    
    CGFloat y = [self.maxYdic[minCol] floatValue] + self.rowMargin;
    
    self.maxYdic[minCol] = @(y+height);
    
    //计算位置
    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attri.frame = CGRectMake(x, y, width, height);
    
    return attri;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{

    for (int i =0; i<self.colCount; i++) {
        
        NSString *col = [NSString stringWithFormat:@"%d",i];
        self.maxYdic[col] = @0;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < count; i++) {
        
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        [array addObject:attrs];
    }
    return array;
}

@end
