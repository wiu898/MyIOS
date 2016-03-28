//
//  RecommendTableCell.h
//  DouYU
//
//  Created by 李超 on 16/3/23.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChanelData;

@protocol RecommendTableCellDelegate <NSObject>

-(void)TapRecommendTableCellDelegate:(ChanelData *)chaneldata;

@end

@interface RecommendTableCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *modelArray;

@property (nonatomic, assign) int  tags; //所在section

@property (nonatomic, assign) id delegate;

@end
