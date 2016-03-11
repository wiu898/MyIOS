//
//  AppointmentCollectionViewCell.h
//  PodTest
//
//  Created by 李超 on 15/12/29.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppointmentCoachTimeInfoModel;

@interface AppointmentCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *startTimeLabel;
@property (strong, nonatomic) UILabel *finalTimeLabel;
@property (strong, nonatomic) UILabel *remainingPersonLabel;

- (void)receiveCoachTimeInfoModel:(AppointmentCoachTimeInfoModel *)coachTimeInfo;

@end
