//
//  CoachDetailCell.h
//  PodTest
//
//  Created by 李超 on 16/1/2.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingBar.h"

@interface CoachDetailCell : UITableViewCell

@property (strong, nonatomic) UILabel *coachNameLabel;
@property (strong, nonatomic) RatingBar *starBar;
@property (strong, nonatomic) UILabel *locationLabel;
@property (strong, nonatomic) UIButton *coachStateSend;
@property (strong, nonatomic) UIButton *coachStateAll;

@end
