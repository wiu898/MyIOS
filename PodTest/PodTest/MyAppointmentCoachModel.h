//
//  MyAppointmentCoachModel.h
//  PodTest
//
//  Created by 李超 on 16/1/20.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "DriveSchoolinfo.h"
#import "Logoimg.h"
#import <MTLJSONAdapter.h>

@interface MyAppointmentCoachModel : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *infoId;
@property (strong, nonatomic, readonly) DriveSchoolinfo *driveschoolinfo;
@property (strong, nonatomic, readonly) Logoimg *headportrait;
@property (copy, nonatomic, readonly) NSString *name;

@end
