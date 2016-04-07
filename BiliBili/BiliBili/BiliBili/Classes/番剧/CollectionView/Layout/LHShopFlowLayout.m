//
//  LHShopFlowLayout.m
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHShopFlowLayout.h"

@interface LHShopFlowLayout()

@property (nonatomic, strong) NSMutableArray *shopAttr;  //存放cell

@property (nonatomic, strong) NSMutableDictionary *shopDictM;  //存放SIZE

@end

@implementation LHShopFlowLayout

- (NSMutableArray*)shopAttr
{
    
    if (_shopAttr == nil) {
        
        _shopAttr = [NSMutableArray array];
    }
    
    return _shopAttr;
}

- (NSMutableDictionary*)shopDictM
{
    
    if (_shopDictM == nil) {
        
        _shopDictM = [NSMutableDictionary dictionaryWithCapacity:_colNum];
    }
    
    return _shopDictM;
}

- (instancetype) init{

    self  = [super init];
    
    if (self) {
      
        //默认列数
        self.colNum = 2;
        
        //给一个默认的cell间距及行间距
        self.minimumInteritemSpacing = 15;
        self.minimumLineSpacing = 15;
        
        //footerView或者headerView的默认尺寸
        self.footerReferenceSize = CGSizeMake(50, 50);
        self.headerReferenceSize = CGSizeMake(50, 50);
        self.sectionInset = UIEdgeInsetsMake(0, 20, 20, 20);
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
  
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        self.sectionInset = UIEdgeInsetsMake(0, 20, 20, 20);
        self.minimumLineSpacing = 15;
        self.minimumInteritemSpacing = 15;
        self.colNum = 2;
        self.footerReferenceSize = CGSizeMake(50, 50);
        self.headerReferenceSize = CGSizeMake(50, 50);
    }
    return self;
}

- (void)prepareLayout{

    [super prepareLayout];
    [self.shopAttr removeAllObjects];
    
    for (NSInteger i = 0; i < self.colNum; i++) {
        
        self.shopDictM[[NSString stringWithFormat:@"%zd",i]] = @(self.sectionInset.top + 592);
    }
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < count; i++) {
        
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:index];
        
        [self.shopAttr addObject:attr];
    }
    
    NSIndexPath *headIndex = [NSIndexPath indexPathForItem:0 inSection:0];
    
    UICollectionViewLayoutAttributes *attrHead = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:headIndex];
    
    attrHead.frame = CGRectMake(0, 0, self.collectionView.bounds.size.width, 592);
    
    [self.shopAttr addObject:attrHead];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{

    NSString *key = [self colMinNum];
    
    NSInteger col = [key integerValue];
    
    //cell尺寸
    CGFloat cellW = (self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing * (self.colNum - 1)) / self.colNum;
    
    CGFloat cellH = [self.delegate shopFlowLayoutWithHight:self layoutWitdh:cellW forIndex:indexPath];
    
    CGFloat cellX = self.sectionInset.left + (cellW + self.minimumInteritemSpacing) * (col % self.colNum);
    
    CGFloat cellY = [self.shopDictM[key] floatValue];
    
    self.shopDictM[key] = @(self.minimumLineSpacing + cellY + cellH);
    
    
    //创建cell
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attr.frame = CGRectMake(cellX, cellY, cellW, cellH);
    
    return attr;
}

//得出最短列
- (NSString *)colMinNum{

   __block NSString *min = @"0";
    
    [self.shopDictM enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([self.shopDictM[min] floatValue] > [obj floatValue]) {
            
            min = key;
        }
    }];
    return min;
}

//得出最大列
- (NSString *)colMaxNum{

   __block NSString *max = @"0";
    
    [self.shopDictM enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([self.shopDictM[max] floatValue] < [obj floatValue]) {
            
            max = key;
        }
    }];
    
    return max;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
  
    return self.shopAttr;
}

//返回collectionView大小
- (CGSize)collectionViewContentSize{

    return CGSizeMake(0, [self.shopDictM[[self colMaxNum]] floatValue]+120);
}

@end
