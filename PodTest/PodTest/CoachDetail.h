//
//  CoachDetail.h
//  PodTest
//
//  Created by 李超 on 16/1/2.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "CarModel.h"
#import "SubjectModel.h"
#import "DriveSchoolinfo.h"
#import "Logoimg.h"
#import "TrainFieldInfoModel.h"
#import <MTLJSONAdapter.h>

@interface CoachDetail : MTLModel

//资质
@property (copy, readonly, nonatomic) NSString *seniority;
@property (copy, readonly, nonatomic) NSString *address;
@property (strong, readonly, nonatomic) CarModel *carmodel;
@property (copy, readonly, nonatomic) NSString *coachid;
@property (strong, readonly, nonatomic) NSNumber *commentcount;
@property (copy, readonly, nonatomic) NSString *createtime;
@property (copy, readonly, nonatomic) NSString *displaycoachid;
@property (strong ,readonly, nonatomic) DriveSchoolinfo *driveschoolinfo;
@property (copy, readonly, nonatomic) NSString *email;
@property (strong, readonly, nonatomic) Logoimg *headportrait;
@property (copy, readonly, nonatomic) NSString *introduction;
@property (strong, readonly, nonatomic) NSString *invitationcode;
@property (assign, readonly, nonatomic) BOOL is_lock;
//是否接送
@property (assign, readonly, nonatomic) BOOL is_shuttle;
@property (assign, readonly, nonatomic) BOOL is_validation;
@property (copy, readonly, nonatomic) NSString *logintime;
@property (copy, readonly, nonatomic) NSString *mobile;
@property (copy, readonly, nonatomic) NSString *name;
//通过率
@property (strong, readonly, nonatomic) NSNumber *passrate;
//车牌号
@property (copy, readonly, nonatomic) NSString *platenumber;
//接送信息
@property (copy, readonly, nonatomic) NSString *shuttlemsg;
@property (strong, readonly, nonatomic) NSNumber *starlevel;
@property (strong, readonly, nonatomic) NSNumber *studentcoount;
@property (strong, readonly, nonatomic) NSArray *subject;
@property (strong, readonly, nonatomic) TrainFieldInfoModel *trainFieldInfo;
@property (strong, readonly, nonatomic) NSNumber *validationstate;
@property (copy, readonly, nonatomic) NSString *worktimedesc;

@end
