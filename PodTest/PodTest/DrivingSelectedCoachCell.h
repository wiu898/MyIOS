//
//  DrivingSelectedCoachCell.h
//  PodTest
//
//  Created by 李超 on 16/1/11.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CoachModel;

@protocol DrivingSelectedCoachCellDelegate<NSObject>

- (void)senderCoachModel:(CoachModel *)model;

@end

@interface DrivingSelectedCoachCell : UITableViewCell

- (void)receiveGetCoachMessage:(NSArray *)coachArray;

@property (weak,nonatomic) id<DrivingSelectedCoachCellDelegate>delegate;

@end
