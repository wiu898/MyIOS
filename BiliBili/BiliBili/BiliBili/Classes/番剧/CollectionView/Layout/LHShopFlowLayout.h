//
//  LHShopFlowLayout.h
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHShopFlowLayout;

@protocol LHShopFlowLayoutDelegate <NSObject>

@optional

- (CGFloat)shopFlowLayoutWithHight:(LHShopFlowLayout *)flowLayout layoutWitdh:(CGFloat)cellW forIndex:(NSIndexPath *)indexP;

@end

@interface LHShopFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,weak) id<LHShopFlowLayoutDelegate> delegate;

@property (nonatomic,assign) NSInteger colNum;

@end
