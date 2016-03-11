//
//  AccountManager.h
//  PodTest
//
//  Created by 李超 on 15/12/4.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApplyclasstypeinfoModel.h"
#import "ApplycoachinfoModel.h"
#import "ApplyschoolinfoModel.h"
#import "ExamCarModel.h"
#import "Logoimg.h"
#import "SubjectModel.h"
#import "SubjectTwoModel.h"
#import "SubjectThreeModel.h"
#import "BannerModel.h"

@interface AccountManager : NSObject

@property (readonly,copy,nonatomic) NSString *userAddress;
@property (readonly,strong,nonatomic) ApplyclasstypeinfoModel *applyclasstype;
@property (readonly,strong,nonatomic) ApplycoachinfoModel *applycoach;
@property (readonly,strong,nonatomic) ApplyschoolinfoModel *applyschool;
@property (readonly,strong,nonatomic) ExamCarModel *userCarmodels;
@property (readonly,copy,nonatomic) NSString *userIdcardnumber;
@property (readonly,copy,nonatomic) NSString *userMobile;
@property (readonly,copy,nonatomic) NSString *userName;
@property (readonly,copy,nonatomic) NSString *userNickName;
@property (readonly,copy,nonatomic) NSString *userCreateTime;
@property (readonly,copy,nonatomic) NSString *userEmail;
@property (readonly,copy,nonatomic) NSString *userToken;
@property (readonly,copy,nonatomic) NSString *userLogintime;
@property (readonly,copy,nonatomic) NSString *userInvitationcode;
@property (readonly,copy,nonatomic) NSString *userApplystate;
@property (readonly,copy,nonatomic) NSString *userDisplayuserid;
@property (readonly,copy,nonatomic) NSString *userIs_lock;
@property (readonly,copy,nonatomic) NSString *userid;
@property (readonly,copy,nonatomic) NSString *userDisplaymobile;
@property (readonly,copy,nonatomic) NSString *userGender;
@property (readonly,copy,nonatomic) NSString *userSignature;
@property (readonly,copy,nonatomic) NSString *userHeadImageUrl;
@property (readonly,strong,nonatomic) SubjectModel *userSubject;
@property (readonly,strong,nonatomic) SubjectTwoModel *subjecttwo;
@property (readonly,strong,nonatomic) SubjectThreeModel *subjectthree;

+ (AccountManager *)manager;

+ (AccountManager *)configUserInformationWith:(NSDictionary *)userinformation;
+ (void)saveUserName:(NSString *)userName andPassword:(NSString *)password;
+ (NSDictionary *)getUserNameAndPassword;
+ (BOOL)isLogin;
+ (void)saveUserHeadImageUrl:(NSString *)headImageUrl;
+ (void)saveUserGender:(NSString *)gender;
+ (void)saveUserPhoneNum:(NSString *)phoneNum;
+ (void)saveUserSignature:(NSString *)sigature;
+ (void)saveUserName:(NSString *)userName;
+ (void)saveUserNickName:(NSString *)nickName;
+ (void)saveUserAddress:(NSString *)address;

+ (void)removeAllData;

+ (void)saveUserApplyState:(NSString *)state;
+ (void)saveUserBanner:(NSArray *)dataArray;
+ (NSArray *)getBannerUrlArray;

@end
