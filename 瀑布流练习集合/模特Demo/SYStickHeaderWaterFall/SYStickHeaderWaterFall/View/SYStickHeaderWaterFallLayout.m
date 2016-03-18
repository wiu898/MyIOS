//
//  SYStickHeaderWaterFallLayout.m
//  SYStickHeaderWaterFall
//
//  Created by 李超 on 16/3/16.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "SYStickHeaderWaterFallLayout.h"

NSString *const SYStickHeaderWaterCellKind = @"WaterfallCell";

NSString *const SYStickHeaderWaterDecorationKind = @"Decoration";

@interface SYStickHeaderWaterFallLayout()

@property (nonatomic) NSInteger columnsCount;

@property (nonatomic) CGFloat itemInnerMargin;

@property (nonatomic) NSDictionary *layoutInfo;

@property (nonatomic) NSArray *sectionsHeights;

@property (nonatomic) NSArray *itemsInSectionsHeights;

@end

@implementation SYStickHeaderWaterFallLayout

#pragma mark - LifeCycle

- (id)init{

    self = [super init];
    
    if (self) {
        [self setUp];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{

    self = [super init];
    
    if (self) {
        [self setUp];
    }
    return self;
}

- (void) setItemWidth:(CGFloat)itemWidth{
   
    if (_itemWidth == itemWidth) {
        return;
    }
    _itemWidth = itemWidth;
    [self invalidateLayout];
}

- (void)setUp{

    self.itemWidth = (kDeviceWidth - 15) / 12;
    self.topInset = 0.0f;
    self.bottomInset = 0.0f;
    self.stickyHeader = YES;
}

- (void)prepareLayout{

    if (self.collectionView.isDecelerating || self.collectionView.isDragging) {
        
    }else{
        
        [self calculateMaxColumnsCount];
        [self calculateItemsInnerMargin];
        [self calculateItemsHeights];
        [self calculateSectionsHeights];
        [self calculateItemsAttributes];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{

    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIndentifer, NSDictionary *elementsInfo, BOOL *stop) {
        
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attributes, BOOL *innerStop) {
            
            if (CGRectIntersectsRect(rect, attributes.frame) || [elementIndentifer isEqualToString:UICollectionElementKindSectionHeader]) {
                
                [allAttributes addObject:attributes];
            }
        }];
    }];
    
    if (!self.stickyHeader) {
        return allAttributes;
    }
    
    for (UICollectionViewLayoutAttributes *layoutAttributes in allAttributes) {
        
        if ([layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            
            NSInteger section = layoutAttributes.indexPath.section;
            
            NSIndexPath *firstCellIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
            
            UICollectionViewLayoutAttributes *firstCellAttrs = [self layoutAttributesForItemAtIndexPath:firstCellIndexPath];
            
            CGFloat headerHeight  =CGRectGetHeight(layoutAttributes.frame) + self.itemInnerMargin;
            
            CGFloat currentHeaderHeight = [self headerHeightForIndexPath:firstCellIndexPath];
            
            CGPoint origin = layoutAttributes.frame.origin;
            
            origin.y = MIN(
                           MAX(self.collectionView.contentOffset.y + kFixTop, (CGRectGetMinY(firstCellAttrs.frame) - headerHeight) - self.topInset),
                           CGRectGetMinY(firstCellAttrs.frame) - headerHeight + [[self.sectionsHeights objectAtIndex:section] floatValue] - currentHeaderHeight - self.topInset
                           ) + self.topInset ;//
            
            CGFloat width = layoutAttributes.frame.size.width;
            
            if (self.collectionView.contentOffset.y > origin.y - (kFixTop + 20)) {
                
                width = self.collectionView.bounds.size.width;
                origin.x = 0;
               NSLog(@"self.collectionView.contentOffset.y%@",@(self.collectionView.contentOffset.y));
            }else{
            
                width = kDeviceWidth;
                origin.x = 0;
            }
            
            layoutAttributes.zIndex = 1024;
            layoutAttributes.frame = (CGRect){
                .origin = origin,
                .size = CGSizeMake(width, layoutAttributes.frame.size.height)
            };


        }
    }
    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    return self.layoutInfo[SYStickHeaderWaterCellKind][indexPath];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
   
    return self.layoutInfo[UICollectionElementKindSectionHeader][indexPath];
}

- (CGSize)collectionViewContentSize{

    CGFloat height = self.topInset;
    for (NSNumber *h in self.sectionsHeights) {
        height += [h integerValue];
    }
    height += self.bottomInset;
    return CGSizeMake(self.collectionView.bounds.size.width, height);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
   
    return self.stickyHeader;
}

#pragma mark - Prepare layout calculation

- (void)calculateMaxColumnsCount{

    self.columnsCount = self.collectionView.bounds.size.width / self.itemWidth;
}

- (void)calculateItemsInnerMargin{
   
    if (self.columnsCount > 1) {
        self.itemInnerMargin = (self.collectionView.bounds.size.width - self.columnsCount * self.itemWidth) / (self.columnsCount + 1);
    }
}

- (void)calculateItemsHeights{

    NSMutableArray *itemsInSectionsHeight = [NSMutableArray arrayWithCapacity:self.collectionView.numberOfSections];
    
    NSIndexPath *itemIndex;
    
    for (NSInteger section = 0; section < self
         .collectionView.numberOfSections; section++) {
        
        NSMutableArray *itemsHeights = [NSMutableArray arrayWithCapacity:[self.collectionView numberOfItemsInSection:section]];
        
        for (NSInteger item = 0; item < [self.collectionView numberOfItemsInSection:section]; item++) {
            
            itemIndex = [NSIndexPath indexPathForItem:item inSection:section];
            
            CGFloat itemHeight = [self.delegate collectionView:self.collectionView layout:self heightForItemAtIndexPath:itemIndex];
            
            [itemsHeights addObject:[NSNumber numberWithFloat:itemHeight]];
        }
        [itemsInSectionsHeight addObject:itemsHeights];
    }
    self.itemsInSectionsHeights = itemsInSectionsHeight;
}

- (void)calculateSectionsHeights{
   
    NSMutableArray *newSectionsHeight = [NSMutableArray array];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        
        [newSectionsHeight addObject:[self calculateHeightForSection:section]];
    }
    self.sectionsHeights = [NSArray arrayWithArray:newSectionsHeight];
}

- (NSNumber *)calculateHeightForSection:(NSInteger)section{

    if (section == 1) {
        NSInteger sectionColumns[self.columnsCount];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
        
        for (NSInteger column = 0; column < self.columnsCount; column++) {
            
            sectionColumns[column] = [self headerHeightForIndexPath:indexPath] + self.itemInnerMargin;
        }
        
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        for (NSInteger item = 0; item < itemCount; item++) {
            
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            NSInteger currentColumn = 0;
            
            for (NSInteger column = 0; column < self.columnsCount; column++) {
                if(sectionColumns[currentColumn] > sectionColumns[column]) {
                    currentColumn = column;
                }
            }
            
            sectionColumns[currentColumn] += [[[self.itemsInSectionsHeights objectAtIndex:section]
                                               objectAtIndex:indexPath.item] floatValue];
            sectionColumns[currentColumn] += self.itemInnerMargin;
        
        }
        
        NSInteger biggestColumn = 0;
        for (NSInteger column = 0; column < self.columnsCount; column ++) {
            if (sectionColumns[biggestColumn] < sectionColumns[column]) {
                biggestColumn = column;
            }
        }
        
        return [NSNumber numberWithFloat:sectionColumns[biggestColumn]];
    }else{
       //修正section == 0时多出10单位的bug
        
        NSInteger sectionColumns[self.columnsCount];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
        
        for (NSInteger column = 0; column < self.columnsCount; column++) {
            sectionColumns[column] = [self headerHeightForIndexPath:indexPath];
        }
        
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        for (NSInteger item = 0; item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            NSInteger currentColumn = 0;
            for (NSInteger column = 0; column < self.columnsCount; column++) {
                if (sectionColumns[currentColumn] > sectionColumns[column]) {
                    currentColumn = column;
                }
            }
            sectionColumns[currentColumn] += [[[self.itemsInSectionsHeights objectAtIndex:section] objectAtIndex:indexPath.item] floatValue];
        }
        
        NSInteger biggestColumn = 0;
        for (NSInteger column = 0; column < self.columnsCount; column ++) {
            if (sectionColumns[biggestColumn] < sectionColumns[column]) {
                biggestColumn = column;
            }
        }
        return [NSNumber numberWithFloat:sectionColumns[biggestColumn]];
    }
}

- (void)calculateItemsAttributes{
   
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *titleLayoutInfo = [NSMutableDictionary dictionary];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    UICollectionViewLayoutAttributes *emblemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:SYStickHeaderWaterDecorationKind withIndexPath:indexPath];
    
    for (NSInteger section = 0; section < [self.collectionView numberOfSections]; section++) {
        
        for (NSInteger item = 0; item < [self.collectionView numberOfItemsInSection:section]; item++) {
            
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
            itemAttributes.frame = [self frameForWaterfallCellIndexPath:indexPath];
            cellLayoutInfo[indexPath] = itemAttributes;
            
            if (indexPath.item == 0) {
                UICollectionViewLayoutAttributes *titleAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath];
                
                titleAttributes.frame = [self frameForWaterfallHeaderAtIndexPath:indexPath];
                titleLayoutInfo[indexPath] = titleAttributes;
            }
        }
    }
    
    newLayoutInfo[SYStickHeaderWaterCellKind] = cellLayoutInfo;
    newLayoutInfo[UICollectionElementKindSectionHeader] = titleLayoutInfo;
    
    self.layoutInfo = newLayoutInfo;
}

#pragma mark - Items frames

- (CGRect)frameForWaterfallCellIndexPath:(NSIndexPath *)indexPath{
   
    CGFloat width = self.itemWidth;
    
    CGFloat height = [[[self.itemsInSectionsHeights objectAtIndex:indexPath.section] objectAtIndex:indexPath.item] floatValue];
    
    CGFloat topInset = self.topInset;
    
    for (NSInteger section = 0; section < indexPath.section; section++) {
        topInset += [[self.sectionsHeights objectAtIndex:section] integerValue];
    }
    
    NSInteger columnsHeights[self.columnsCount];
    for (NSInteger column = 0; column < self.columnsCount; column++) {
        columnsHeights[column] = [self headerHeightForIndexPath:indexPath] +self.itemInnerMargin;
    }
    
    for (NSInteger item = 0; item < indexPath.item; item++) {
        NSIndexPath *ip = [NSIndexPath indexPathForItem:item inSection:indexPath.section];
        NSInteger currentColumn = 0;
        
        for (NSInteger column = 0; column < self.columnsCount; column ++) {
            if (columnsHeights[currentColumn] > columnsHeights[column]) {
                currentColumn = column;
            }
        }
        
        columnsHeights[currentColumn] += [[[self.itemsInSectionsHeights objectAtIndex:ip.section] objectAtIndex:ip.item] floatValue];
        
        columnsHeights[currentColumn] += self.itemInnerMargin;
    }
    
    NSInteger columnForCurrentItem = 0;
    for (NSInteger column = 0; column < self.columnsCount; column++) {
        if (columnsHeights[columnForCurrentItem] > columnsHeights[column]) {
            columnForCurrentItem = column;
        }
    }
    
    CGFloat originX = self.itemInnerMargin +
    columnForCurrentItem *self.itemWidth +
    columnForCurrentItem * self.itemInnerMargin;
    
    CGFloat originY = columnsHeights[columnForCurrentItem] + topInset;
    
    return CGRectMake(originX, originY, width, height);
}

- (CGRect)frameForWaterfallHeaderAtIndexPath:(NSIndexPath *)indexPath{
  
    CGFloat width = self.collectionView.bounds.size.width - self.itemInnerMargin * 2;
    
    CGFloat height = [self headerHeightForIndexPath:indexPath];
    
    CGFloat originY = 0;
    for (NSInteger i = 0; i < indexPath.section; i++) {
        originY += [[self.sectionsHeights objectAtIndex:i] floatValue];
    }
    
    CGFloat originX = self.itemInnerMargin;
    return CGRectMake(originX, originY, width, height);
}

- (CGFloat)headerHeightForIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:heightForHeaderAtIndexPath:)]) {
        
        return [self.delegate collectionView:self.collectionView layout:self heightForHeaderAtIndexPath:indexPath];
    }
    return 0;
}

@end
