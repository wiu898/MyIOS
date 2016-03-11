//
//  AppointmentCoachTimeInfoModel.h
//  PodTest
//
//  Created by 李超 on 15/12/28.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "CourseTimeModel.h"
#import <MTLJSONAdapter.h>

@interface AppointmentCoachTimeInfoModel : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *infoId;
@property (copy, nonatomic, readonly) NSString *coachid;
@property (copy, nonatomic, readonly) NSString *coursedate;
@property (strong, nonatomic, readonly) NSNumber *coursestudentcount;
@property (strong, nonatomic, readonly) CourseTimeModel *coursetime;
@property (strong, nonatomic, readonly) NSArray *courseuser;
@property (copy, nonatomic, readonly) NSString *createtime;
@property (strong, nonatomic, readonly) NSNumber *selectedstudentcount;
@property (assign, nonatomic, readwrite) NSInteger indexPath;
@property (assign, nonatomic, readwrite) BOOL is_selected;

@end
