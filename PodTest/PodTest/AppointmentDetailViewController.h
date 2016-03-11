//
//  AppointmentDetailViewController.h
//  PodTest
//
//  Created by 李超 on 16/1/21.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "BLBaseViewController.h"
#import <UIKit/UIKit.h>

@class MyAppointmentModel;

@interface AppointmentDetailViewController : BLBaseViewController

@property (strong, nonatomic) MyAppointmentModel *model;
@property (assign, nonatomic) AppointmentState state;
@property (copy, nonatomic) NSString *infoId;
@property (assign, nonatomic) BOOL isPushInformation;

@end
