//
//  AppointmentDrivingCell.h
//  PodTest
//
//  Created by 李超 on 15/12/29.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AppointmentDrivingCellDelegate<NSObject>

- (void)calendarClick:(NSString *)dateString;

@end

@interface AppointmentDrivingCell : UITableViewCell

@property (weak, nonatomic) id <AppointmentDrivingCellDelegate>delegate;
@property (strong, nonatomic) NSMutableArray *upDateArray;

- (void)receiveCoachTimeData:(NSArray *)coachTimeData;

@end
