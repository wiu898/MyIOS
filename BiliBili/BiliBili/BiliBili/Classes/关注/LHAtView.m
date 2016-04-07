//
//  LHAtView.m
//  BiliBili
//
//  Created by 李超 on 16/3/28.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHAtView.h"
#import "LHAtHeaderView.h"
#import "LHAtViewCell.h"

@interface LHAtView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic ,weak) UICollectionView *collectionViewAt;

@end

@implementation LHAtView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIImageView *bgi = [[UIImageView alloc] init];
        
        bgi.image = [UIImage imageNamed:@"login_forbidden"];
        
        bgi.frame = CGRectMake(0, 0, frame.size.width, frame.size.height -120);
        
        [self addSubview:bgi];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.itemSize = CGSizeMake(frame.size.width - 40, 140);
        
        flowLayout.minimumLineSpacing = 20;
        
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 20, 20);
        
        flowLayout.headerReferenceSize = CGSizeMake(frame.size.width, 348);
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
        
        self.collectionViewAt = collectionView;
        
        collectionView.delegate = self;
        
        collectionView.dataSource = self;
        
        collectionView.backgroundColor = [UIColor clearColor];
        
        UINib *nib = [UINib nibWithNibName:@"LHAtViewCell" bundle:nil];
        
        UINib *nibHeader = [UINib nibWithNibName:@"LHAtHeaderView" bundle:nil];
        
        [collectionView registerNib:nib forCellWithReuseIdentifier:@"atcell"];
        
        [collectionView registerNib:nibHeader forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"athead"];
        
   //     [self addSubview:collectionView];
    }
    
    return self;
}

#pragma mark - dataSource

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    LHAtHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"athead" forIndexPath:indexPath];
    
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    LHAtViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"atcell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:(float)arc4random_uniform(256)/255.0 green:(float)arc4random_uniform(256)/255.0 blue:(float)arc4random_uniform(256)/255.0 alpha:1];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.y >= 0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"moveTopBar" object:@(scrollView.contentOffset.y)];
    }
}

@end
