//
//  CoachHeadCell.h
//  PodTest
//
//  Created by 李超 on 15/12/28.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppointmentCoachModel;

@interface CoachHeadCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *coachHeadImageView;
@property (strong, nonatomic) UILabel *coachNameLabel;
@property (strong, nonatomic) UILabel *coachAddress;
@property (strong, nonatomic) UIButton *coachStateSend;
@property (strong, nonatomic) UIButton *coachStateAll;

- (void)recevieCoachData:(AppointmentCoachModel *)coachModel;

@end
