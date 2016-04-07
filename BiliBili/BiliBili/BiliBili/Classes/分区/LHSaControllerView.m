//
//  LHSaControllerView.m
//  BiliBili
//
//  Created by 李超 on 16/3/28.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHSaControllerView.h"
#import "LHSaCollectionViewCell.h"
#import "LHSaModel.h"

@interface LHSaControllerView() <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionViewSa;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSArray *arrDict;

@end

@implementation LHSaControllerView

- (NSArray *)arrDict{

    if (_arrDict == nil) {
        
        NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SaCell.plist" ofType:nil]];
        
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        
        for (NSDictionary *dict in arr) {
            
            [arrM addObject:[LHSaModel saCellWithDict:dict]];
        }
        
        _arrDict = arrM;
    }
    return _arrDict;
}

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
    
        UIScreen *scr = [UIScreen mainScreen];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        self.flowLayout = flowLayout;
        
        flowLayout.sectionInset = UIEdgeInsetsMake(30, 30, 0, 40);
        
        CGFloat margin = (scr.bounds.size.width - 82 * 3 - 30 * 2)* 0.5;
        
        flowLayout.minimumInteritemSpacing = margin;
        
        flowLayout.minimumLineSpacing = margin;
        
        flowLayout.itemSize = CGSizeMake(62, 70);
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
        
        self.collectionViewSa = collectionView;
        
        self.collectionViewSa.dataSource = self;
        
        self.collectionViewSa.delegate = self;
        
        UINib *nib = [UINib nibWithNibName:@"LHSaCollectionViewCell" bundle:nil];
        
        [self.collectionViewSa registerNib:nib forCellWithReuseIdentifier:@"sacell"];
        
        self.collectionViewSa.backgroundColor = [UIColor clearColor];
        
        [self addSubview:collectionView];
    }
    
    return self;
}

#pragma mark - dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.arrDict.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    LHSaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sacell" forIndexPath:indexPath];
    
    LHSaModel *model = self.arrDict[indexPath.item];
    
    NSLog(@"0000000000000000000000---%@",model);
    
    cell.saCellM = model;
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

@end
