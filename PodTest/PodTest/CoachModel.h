//
//  CoachModel.h
//  PodTest
//
//  Created by 李超 on 15/12/31.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "Logoimg.h"
#import "DriveSchoolinfo.h"
#import <MTLJSONAdapter.h>
//#import "CoachDetail.h"

@interface CoachModel : MTLModel<MTLJSONSerializing>

@property (copy, readonly, nonatomic) NSString *Seniority;
@property (copy, readonly, nonatomic) NSString *coachid;
@property (strong, readonly, nonatomic) NSNumber *distance;
@property (copy, readonly, nonatomic) NSString *name;
@property (strong, readonly, nonatomic) DriveSchoolinfo *driveschoolinfo;
@property (strong, readonly, nonatomic) Logoimg *headportrait;
//是否接送
@property (assign, readonly, nonatomic) BOOL is_shuttle;
@property (strong, readonly, nonatomic) NSNumber *latitude;
@property (strong, readonly, nonatomic) NSNumber *longitude;
@property (strong, readonly, nonatomic) NSNumber *passrate;
@property (strong, readonly, nonatomic) NSNumber *starlevel;

@end
