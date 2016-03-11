//
//  MyAppointmentModel.h
//  PodTest
//
//  Created by 李超 on 16/1/20.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "MTLModel.h"
#import "SubjectModel.h"
#import <MTLJSONAdapter.h>
#import "MyAppointmentCoachModel.h"

@interface MyAppointmentModel : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *infoId;
@property (copy, nonatomic, readonly) NSString *classdatetimedesc;
@property (copy, nonatomic, readonly) NSString *begintime;
@property (strong, nonatomic, readonly) MyAppointmentCoachModel *coachid;
@property (strong, nonatomic, readonly) NSNumber *coursehour;
@property (copy, nonatomic, readonly) NSString *courseprocessdesc;
@property (copy, nonatomic, readonly) NSString *endtime;
@property (strong, nonatomic, readonly) NSNumber *is_coachcomment;
@property (strong, nonatomic, readonly) NSNumber *is_comment;
@property (strong, nonatomic, readonly) NSNumber *is_complaint;
@property (strong, nonatomic, readonly) NSNumber *is_shuttle;
@property (strong, nonatomic, readonly) NSArray *reservationcourse;
@property (copy, nonatomic, readonly) NSString *reservationcreatetime;
@property (strong, nonatomic, readonly) NSNumber *reservationstate;
@property (copy, nonatomic, readonly) NSString *shuttleaddress;
@property (strong, nonatomic, readonly) SubjectModel *subjectModel;
@property (copy, nonatomic, readonly) NSString *trainfieldid;
@property (copy, nonatomic, readonly) NSString *userid;

@end
