//
//  FourCollectionCell.h
//  DouYU
//
//  Created by 李超 on 16/3/22.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnlineModel.h"
#import "ChanelData.h"

@interface FourCollectionCell : UICollectionViewCell

@property (nonatomic,strong) OnlineModel *onlineData;

@property (nonatomic,strong) ChanelData *chanelData;

- (void)reciveChanelData:(ChanelData *)chanelData;

- (void)reciveOnlineDataWith:(OnlineModel *)onlineData;

@end
