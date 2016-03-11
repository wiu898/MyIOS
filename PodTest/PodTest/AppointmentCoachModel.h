//
//  AppointmentCoachModel.h
//  PodTest
//
//  Created by 李超 on 15/12/28.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "MTLModel.h"
#import "DriveSchoolinfo.h"
#import "Logoimg.h"
#import <MTLJSONAdapter.h>

@interface AppointmentCoachModel : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic) NSString *seniority;
@property (copy, nonatomic) NSString *coachid;
@property (strong, nonatomic) DriveSchoolinfo *driveschoolinfo;
@property (strong, nonatomic) Logoimg *headportrait;
@property (assign, nonatomic) BOOL is_shuttle;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *passrate;
@property (strong, nonatomic) NSNumber *starlevel;

@end
