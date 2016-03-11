//
//  SignUpInfoManager.h
//  PodTest
//
//  Created by 李超 on 16/1/2.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kRealName = @"name";
static NSString *const kRealIdentityCar = @"idcardnumber";
static NSString *const kRealTelephone = @"telephone";
static NSString *const kRealAddress = @"address";
static NSString *const kRealSchoolid = @"schoolid";
static NSString *const kRealCoachid = @"coachid";
static NSString *const kRealClasstypeid = @"classtypeid";
static NSString *const kRealCarmodel = @"carmodel";

static NSString *const kSchoolParam = @"applyschoolinfo";
static NSString *const kClasstypeParam = @"applyclasstypeinfo";
static NSString *const kCoachParam = @"applycoachinfo";

static NSString *const kStudentNumber = @"studentid";
static NSString *const kPassNumber = @"ticketnumber";

@interface SignUpInfoManager : NSObject

@property (copy, readonly, nonatomic) NSString *realName;
@property (copy, readonly, nonatomic) NSString *realIdentityCar;
@property (copy, readonly, nonatomic) NSString *realTelephone;
@property (copy, readonly, nonatomic) NSString *realAddress;
@property (copy, readonly, nonatomic) NSString *realSchoolid;
@property (copy, readonly, nonatomic) NSString *realCoachid;
@property (copy, readonly, nonatomic) NSString *realClasstypeid;
@property (strong, readonly, nonatomic) NSDictionary *realCarmodel;

+ (void)signUpInfoSaveRealName:(NSString *)realName;
+ (void)signUpInfoSaveRealIdentityCar:(NSString *)realIdentityCar;
+ (void)signUpInfoSaveRealTelephone:(NSString *)realTelephone;
+ (void)signUpInfoSaveRealAddress:(NSString *)realAddress;

//缓存准考证信息
+ (void)signUpInfoSaveStudentNumber:(NSString *)studentNumber;
+ (void)signUpInfoSavePassNumber:(NSString *)passNumber;

//缓存报考驾校
+ (void)signUpInfoSaveRealSchool:(NSDictionary *)schoolParam;

//缓存报考教练
+ (void)signUpInfoSaveRealCoach:(NSDictionary *)CoachParam;

//缓存报考班型
+ (void)signUpInfoSaveRealClasstype:(NSDictionary *)ClasstypeParam;

//缓存报考车型
+ (void)signUpInfoSaveRealCarmodel:(NSDictionary *)realCarmodel;

+ (NSDictionary *)getSignUpInforamtion;
+ (NSDictionary *)getSignUpPassInformation;

+ (NSString *)getSignUpSchoolid;
+ (NSString *)getSignUpCoachid;
+ (NSString *)getSignUpRealName;
+ (NSString *)getSignUpRealIdentityCar;
+ (NSString *)getSignUpRealTelephone;
+ (NSString *)getSignUpRealAddress;
+ (NSString *)getSignUprealClasstypeid;
+ (NSDictionary *)getSignUpCarmodel;

+ (NSString *)getSignUpCoachName;
+ (NSString *)getSignUpClasstypeName;
+ (NSString *)getSignUpSchoolName;
+ (NSString *)getSignUpCarmodelName;

+ (NSString *)getStudentNumber;
+ (NSString *)getPassNumber ;

+ (void)removeSignData;

@end
