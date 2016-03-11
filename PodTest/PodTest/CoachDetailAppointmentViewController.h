//
//  CoachDetailAppointmentViewController.h
//  PodTest
//
//  Created by 李超 on 16/1/15.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "BLBaseViewController.h"
#import "CoachModel.h"

@interface CoachDetailAppointmentViewController : BLBaseViewController

@property (copy, nonatomic) NSString *coachUserId;
@property (strong, nonatomic) CoachModel *rememberModel;

@end
