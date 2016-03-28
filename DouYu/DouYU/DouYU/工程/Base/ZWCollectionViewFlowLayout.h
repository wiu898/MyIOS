//
//  ZWCollectionViewFlowLayout.h
//  DouYU
//
//  Created by 李超 on 16/3/22.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZWCollectionViewFlowLayout;

@protocol ZWwaterFlowDelegate <NSObject>

- (CGFloat)ZWwaterFlow:(ZWCollectionViewFlowLayout *)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end

@interface ZWCollectionViewFlowLayout : UICollectionViewLayout

@property (assign ,nonatomic) UIEdgeInsets sectionInset;

@property (assign, nonatomic) CGFloat rowMargin;

@property (assign, nonatomic) CGFloat colMargin;

@property (assign, nonatomic) CGFloat colCount;

@property (weak, nonatomic) id<ZWwaterFlowDelegate> delegate;

@end
