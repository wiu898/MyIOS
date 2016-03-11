//
//  DrivingSelectedCoachCollectionCell.h
//  PodTest
//
//  Created by 李超 on 16/1/11.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CoachModel;

@interface DrivingSelectedCoachCollectionCell : UICollectionViewCell

- (void)receiveCoachMessage:(CoachModel *)coachModel;

@end
