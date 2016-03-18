//
//  JLCollectionViewCell.h
//  JLWaterfallFlow
//
//  Created by 李超 on 16/3/16.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataModel;

@interface JLCollectionViewCell : UICollectionViewCell

//@property (strong, nonatomic) UIImageView *cellImg;
//
//@property (strong, nonatomic) UILabel *priceLa;
//
//@property (weak, nonatomic) NSLayoutConstraint *bottomHeight;

@property (weak, nonatomic) IBOutlet UIImageView *cellImg;
@property (weak, nonatomic) IBOutlet UILabel *priceLa;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;

- (void)setCellData:(DataModel *)dataModel;

@end
