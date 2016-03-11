//
//  AccountManager.m
//  PodTest
//
//  Created by 李超 on 15/12/4.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "AccountManager.h"
#import "NSUserStoreTool.h"
#import "ToolHeader.h"
#import <SSKeychain.h>

/*
 SSKeyChainas对苹果安全框架API进行了简单封装,支持对存储在钥匙串中密码、
    账户进行访问,包括读取、删除和设置
 */

static NSString *kMobile = @"mobile";
static NSString *kuserMobile = @"telephone";
static NSString *kuserName = @"name";
static NSString *kuserNickName = @"nickname";
static NSString *kuserCreateTime = @"userCreateTime";
static NSString *kuserEmail = @"email";
static NSString *kuserToken = @"token";
static NSString *kuserCarmodels = @"carmodel";
static NSString *kuserLogintime = @"logintime";
static NSString *kuserInvitationcode = @"invitationcode";
static NSString *kuserApplystate = @"applystate";
static NSString *kuserDisplayuserid = @"displayuserid";
static NSString *kuserIs_lock = @"is_lock";
static NSString *kuserid = @"userid";
static NSString *kuserDisplaymobile = @"displaymobile";
static NSString *kAccount = @"acount";
static NSString *kPassword = @"password";
static NSString *kUserHeadImage = @"userHeadImage";
static NSString *kGender = @"gender";
static NSString *kSignature = @"signature";
static NSString *kApplyclasstypeinfo = @"applyclasstypeinfo";
static NSString *kApplycoachinfo = @"applycoachindo";
static NSString *kApplyschoolinfo = @"applyschoolinfo";
static NSString *kheadportrait = @"headportrait";
static NSString *kaddress = @"address";
static NSString *kidcardnumber = @"idcardnumber";
static NSString *ksubject = @"subject";
static NSString *ksubjectTwo = @"subjecttwo";
static NSString *ksubjectThree = @"subjectthree";
static NSString *kBannerUrl = @"bannerUrl";

@interface AccountManager ()

@property (readwrite,copy,nonatomic) NSString *userMobile;
@property (readwrite,copy,nonatomic) NSString *userName;
@property (readwrite,copy,nonatomic) NSString *userNickName;
@property (readwrite,copy,nonatomic) NSString *userCreateTime;
@property (readwrite,copy,nonatomic) NSString *userEmail;
@property (readwrite,copy,nonatomic) NSString *userToken;
@property (readwrite,strong,nonatomic) ExamCarModel *userCarmodels;
@property (readwrite,copy,nonatomic) NSString *userLogintime;
@property (readwrite,copy,nonatomic) NSString *userInvitationcode;
@property (readwrite,copy,nonatomic) NSString *userApplystate;
@property (readwrite,copy,nonatomic) NSString *userDisplayuserid;
@property (readwrite,copy,nonatomic) NSString *userIs_lock;
@property (readwrite,copy,nonatomic) NSString *userid;
@property (readwrite,copy,nonatomic) NSString *userDisplaymobile;
@property (readwrite,copy,nonatomic) NSString *userGender;
@property (readwrite,copy,nonatomic) NSString *userSignature;
@property (readwrite,copy,nonatomic) Logoimg *headportrait;
@property (readwrite,copy,nonatomic) NSString *headImageUrl;

@end

@implementation AccountManager

+ (AccountManager *)manager{
    AccountManager *manager = [[self alloc] init];
    return manager;
}

+ (AccountManager *) configUserInformationWith:(NSDictionary *)userinformation{
    
    AccountManager *userInformationManager = [[self alloc] init];
    
    //存储手机号
    if ([userinformation objectForKey:kuserMobile]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kuserMobile] WithKey:kuserMobile];
    }
    
    //存储用户名称
    if ([userinformation objectForKey:kuserName]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kuserName] WithKey:kuserName];
    }
    
    //存储用户昵称
    if ([userinformation objectForKey:kuserNickName]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kuserNickName] WithKey:kuserNickName];
    }
    
    //存储用户创建时间
    if ([userinformation objectForKey:kuserCreateTime]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kuserCreateTime] WithKey:kuserCreateTime];
    }
    
    if ([userinformation objectForKey:kuserEmail]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kuserEmail] WithKey:kuserEmail];
    }
    
    if ([userinformation objectForKey:kuserToken]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kuserToken] WithKey:kuserToken];
    }
    
    if ([userinformation objectForKey:kuserCarmodels]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kuserCarmodels] WithKey:kuserCarmodels];
    }
    
    if ([userinformation objectForKey:kuserLogintime]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kuserLogintime] WithKey:kuserLogintime];
    }
    
    if ([userinformation objectForKey:kuserInvitationcode]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kuserInvitationcode] WithKey:kuserInvitationcode];
    }
    
    if ([userinformation objectForKey:kuserApplystate]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kuserApplystate] WithKey:kuserApplystate];
    }
    
    if ([userinformation objectForKey:kuserDisplayuserid]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kuserDisplayuserid] WithKey:kuserDisplayuserid];
    }
    
    if ([userinformation objectForKey:kuserIs_lock]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kuserIs_lock] WithKey:kuserIs_lock];
    }
    
    if ([userinformation objectForKey:kuserid]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kuserid] WithKey:kuserid];
    }
    
    if ([userinformation objectForKey:kuserDisplaymobile]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kuserDisplaymobile] WithKey:kuserDisplaymobile];
    }
    
    if ([userinformation objectForKey:kApplyclasstypeinfo]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kApplyclasstypeinfo] WithKey:kApplyclasstypeinfo];
    }
    
    if ([userinformation objectForKey:kheadportrait]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kheadportrait] WithKey:kheadportrait];
    }
    
    if ([userinformation objectForKey:kaddress]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kaddress] WithKey:kaddress];
    }
    
    if ([userinformation objectForKey:kidcardnumber]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kidcardnumber] WithKey:kidcardnumber];
    }
    
    //签名
    if ([userinformation objectForKey:kSignature]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kSignature] WithKey:kSignature];
    }
    
    if ([userinformation objectForKey:kGender]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kGender] WithKey:kGender];
    }
    
    if ([userinformation objectForKey:kApplyschoolinfo]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kApplyschoolinfo] WithKey:kApplyschoolinfo];
    }
    
    if ([userinformation objectForKey:kApplycoachinfo]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kApplycoachinfo] WithKey:kApplycoachinfo];
    }
    
    if ([userinformation objectForKey:kMobile]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:kMobile] WithKey:kMobile];
    }
    
    if ([userinformation objectForKey:ksubject]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:ksubject] WithKey:ksubject];
    }
    
    if ([userinformation objectForKey:ksubjectTwo]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:ksubjectTwo] WithKey:ksubjectTwo];
    }
    
    if ([userinformation objectForKey:ksubjectThree]) {
        [NSUserStoreTool storeWithId:[userinformation objectForKey:ksubjectThree] WithKey:ksubjectThree];
    }
    
    return userInformationManager;

}

+ (void)saveUserApplyState:(NSString *)state{
    if (state) {
        [NSUserStoreTool storeWithId:state WithKey:kuserApplystate];
    }
}

+ (void)saveUserName:(NSString *)userName{
    if (userName) {
        [NSUserStoreTool storeWithId:userName WithKey:kuserName];
    }
}

+ (void)saveUserNickName:(NSString *)nickName{
    if (kuserNickName) {
        [NSUserStoreTool storeWithId:nickName WithKey:kuserNickName];
    }
}

+ (void)saveUserAddress:(NSString *)address{
    if (address) {
        [NSUserStoreTool storeWithId:address WithKey:kaddress];
    }
}

+ (void)saveUserSignature:(NSString *)sigature{
    if (sigature) {
        [NSUserStoreTool storeWithId:sigature WithKey:kSignature];
    }
}

+ (void) saveUserGender:(NSString *)gender{
    if (gender) {
        [NSUserStoreTool storeWithId:gender WithKey:kGender];
    }
}

//存储账号和密码
+ (void)saveUserName:(NSString *)userName andPassword:(NSString *)password{
    
    [NSUserStoreTool storeWithId:userName WithKey:kAccount];
    
    //SSkeychain 为pods中的一个轻量级框架，主要用于存储密码等安全，可以支持读取、删除、设置
    [SSKeychain setPassword:password forService:kAccount account:userName];
}

+ (void)saveUserPhoneNum:(NSString *)phoneNum{
    if (phoneNum) {
        [NSUserStoreTool storeWithId:phoneNum WithKey:kuserMobile];
    }
}

//登陆状态默认为NO
+ (BOOL)isLogin{
    NSString *userName = [NSUserStoreTool getObjectWithKey:kAccount];
    if (userName !=nil && userName.length>0) {
        return YES;
    }
    return NO;
}

+ (void)saveUserHeadImageUrl:(NSString *)headImageUrl{
    if (headImageUrl) {
        [NSUserStoreTool storeWithId:headImageUrl WithKey:kUserHeadImage];
    }
}

- (NSString *)userAddress{
    NSString *kuserAddress = [NSUserStoreTool getObjectWithKey:kaddress];
    if (kuserAddress == nil || [kuserAddress isEqual:[NSNull null]]) {
        return kuserAddress = @"";
    }
    return kuserAddress;
}

- (ApplyclasstypeinfoModel *)applyclasstype{
    NSDictionary *param = [NSUserStoreTool getObjectWithKey:kApplyclasstypeinfo];
    NSError *error = nil;
    
    /*
     * Mantle是一个pods下用于简化model层的第三方库，主要由以下一个内容
     1.MTLModel类：通常作为Model的基类,该类提供了一些默认行为来处理对象的初始化和归档操作，同时可以获取到对象所有属性的集合。
     2.MTLJSONAdapter类：用于在MTLModel对象和JSON字典之间相互转换，相当于适配器
     3.MTLJSONSerializing协议：需要与JSON字典进行相互转化的MTLModel的子类都要实现该协议
     */
    
    //得到Model Object
    ApplyclasstypeinfoModel *model = [MTLJSONAdapter modelOfClass:ApplyclasstypeinfoModel.class
                fromJSONDictionary:param error:&error];
    DYNSLog(@"error=%@",error);
    return model;
}

- (ApplycoachinfoModel *)applycoach{
    NSDictionary *param = [NSUserStoreTool getObjectWithKey:kApplycoachinfo];
    NSError *error = nil;
    ApplycoachinfoModel *model = [MTLJSONAdapter modelOfClass:[ApplycoachinfoModel class]
                fromJSONDictionary:param error:&error];
    DYNSLog(@"model=%@",param);
    return model;
}

- (ApplyschoolinfoModel *)applyschool{
    NSDictionary *param = [NSUserStoreTool getObjectWithKey:kApplyschoolinfo];
    NSError *error = nil;
    ApplyschoolinfoModel *model = [MTLJSONAdapter modelOfClass:kApplyschoolinfo.class
                fromJSONDictionary:param error:&error];
    DYNSLog(@"model=%@",param);
    return model;
}

- (SubjectModel *)userSubject {
    NSDictionary *userSubject = [NSUserStoreTool getObjectWithKey:ksubject];
    NSError *error = nil;
    SubjectModel *model = [MTLJSONAdapter modelOfClass:SubjectModel.class fromJSONDictionary:userSubject error:&error];
    DYNSLog(@"error = %@",error);
    return model;
}

- (SubjectTwoModel *)subjecttwo{
    NSDictionary *param = [NSUserStoreTool getObjectWithKey:ksubjectTwo];
    NSError *error = nil;
    SubjectTwoModel *model = [MTLJSONAdapter modelOfClass:SubjectTwoModel.class
                fromJSONDictionary:param error:&error];
    DYNSLog(@"model=%@",model);
    return model;
}

- (SubjectThreeModel *)subjectthree{
    NSDictionary *param = [NSUserStoreTool getObjectWithKey:ksubjectThree];
    NSError *error = nil;
    SubjectThreeModel *model = [MTLJSONAdapter modelOfClass:[SubjectThreeModel class]
                fromJSONDictionary:param error:&error];
    DYNSLog(@"model=%@",model);
    return model;
}

- (NSString *)userHeadImageUrl{
    NSString *string = [NSUserStoreTool getObjectWithKey:kUserHeadImage];
    DYNSLog(@"Stroeurl=%@",string);
    if (string) {
        return string;
    }
    
    NSDictionary *param = [NSUserStoreTool getObjectWithKey:kheadportrait];
    NSError *error = nil;
    Logoimg *model = [MTLJSONAdapter modelOfClass:Logoimg.class
               fromJSONDictionary:param error:&error];
     DYNSLog(@"error = %@",model.originalpic);
    if (model.originalpic) {
        string = model.originalpic;
        return string;
    }
    string = @"";
    return string;
}

+ (NSDictionary *)getUserNameAndPassword{
    NSString *userName = [NSUserStoreTool getObjectWithKey:kAccount];
    NSString *password = [SSKeychain passwordForService:kAccount account:userName];
    
    NSDictionary *dic = @{kAccount:userName,kPassword:password};
    return dic;
}

- (NSString*)userMobile{
    NSString *userMobileString = [NSUserStoreTool getObjectWithKey:kuserMobile];
    if (userMobileString == nil) {
        return @"";
    }
    return userMobileString;
}

- (NSString *)userName{
    NSString *userNameString = [NSUserStoreTool getObjectWithKey:kuserName];
    if (userNameString == nil) {
        return @"";
    }
    return userNameString;
}

- (NSString *)userNickName{
    NSString *userNickNameString = [NSUserStoreTool getObjectWithKey:kuserNickName];
    if (userNickNameString == nil) {
        return @"";
    }
    return userNickNameString;
}

- (NSString *)userCreateTime{
    NSString *userCreateTimeString = [NSUserStoreTool getObjectWithKey:kuserCreateTime];
    if (userCreateTimeString == nil) {
        return @"";
    }
    return userCreateTimeString;
}

- (NSString *)userEmail{
    NSString *userEmailString = [NSUserStoreTool getObjectWithKey:kuserEmail];
    if (userEmailString == nil) {
        return @"";
    }
    return userEmailString;
}

- (NSString *)userToken{
    NSString *userTokenString = [NSUserStoreTool getObjectWithKey:kuserToken];
    if (userTokenString == nil) {
        return @"";
    }
    return userTokenString;
}

- (ExamCarModel *)userCarmodels{
    NSDictionary *param = [NSUserStoreTool getObjectWithKey:kuserCarmodels];
    NSError *error = nil;
    ExamCarModel *model = [MTLJSONAdapter modelOfClass:[ExamCarModel class]
                    fromJSONDictionary:param error:&error];
    DYNSLog(@"error=%@",error);
    return model;
}

- (NSString *)userLogintime{
    NSString *userLogintimeString = [NSUserStoreTool getObjectWithKey:kuserLogintime];
    if (userLogintimeString == nil) {
        return @"";
    }
    return userLogintimeString;
}

- (NSString *)userInvitationcode{
    NSString *userInvitationcodeString = [NSUserStoreTool getObjectWithKey:kuserInvitationcode];
    if (userInvitationcodeString == nil) {
        return @"";
    }
    return userInvitationcodeString;
}

- (NSString *)userApplystate{
    NSString *userApplystateString = [NSUserStoreTool getObjectWithKey:kuserApplystate];
    if (userApplystateString == nil) {
        return @"";
    }
    return userApplystateString;
}

- (NSString *)userDisplayuserid{
    NSString *userDisplayuseridString = [NSUserStoreTool getObjectWithKey:kuserDisplayuserid];
    if (userDisplayuseridString == nil) {
        return @"";
    }
    return userDisplayuseridString;
}

- (NSString *)userIs_lock{
    NSString *userIs_lockString = [NSUserStoreTool getObjectWithKey:kuserIs_lock];
    if (userIs_lockString == nil) {
        return @"";
    }
    return userIs_lockString;
}

- (NSString *)userid{
    NSString *useridString = [NSUserStoreTool getObjectWithKey:kuserid];
    if (useridString == nil) {
        return @"";
    }
    return useridString;
}

- (NSString *)userDisplaymobile{
    NSString *userDisplaymobileString = [NSUserStoreTool getObjectWithKey:kuserDisplaymobile];
    if (userDisplaymobileString == nil) {
        return @"";
    }
    return userDisplaymobileString;
}

- (NSString *)userGender{
    NSString *userGenderString = [NSUserStoreTool getObjectWithKey:kGender];
    if (userGenderString == nil) {
        return @"";
    }
    return userGenderString;
}

- (NSString *)userSignature{
    NSString *userSignatureString = [NSUserStoreTool getObjectWithKey:kSignature];
    if (userSignatureString == nil) {
        return @"";
    }
    return userSignatureString;
}

- (NSString *)userIdcardnumber{
    NSString *userIdcardnumberString = [NSUserStoreTool getObjectWithKey:kidcardnumber];
    if (userIdcardnumberString == nil) {
        return @"";
    }
    return userIdcardnumberString;
}

+ (void)removeAllData{
    
    [NSUserStoreTool removeObjectWithKey:kuserMobile];
    [NSUserStoreTool removeObjectWithKey:kuserName];
    [NSUserStoreTool removeObjectWithKey:kuserNickName];
    [NSUserStoreTool removeObjectWithKey:kuserCreateTime];
    [NSUserStoreTool removeObjectWithKey:kuserEmail];
    [NSUserStoreTool removeObjectWithKey:kuserToken];
    [NSUserStoreTool removeObjectWithKey:kuserCarmodels];
    [NSUserStoreTool removeObjectWithKey:kuserLogintime];
    [NSUserStoreTool removeObjectWithKey:kuserInvitationcode];
    [NSUserStoreTool removeObjectWithKey:kuserApplystate];
    [NSUserStoreTool removeObjectWithKey:kuserDisplayuserid];
    [NSUserStoreTool removeObjectWithKey:kuserIs_lock];
    [NSUserStoreTool removeObjectWithKey:kuserid];
    [NSUserStoreTool removeObjectWithKey:kuserDisplaymobile];
    [NSUserStoreTool removeObjectWithKey:kAccount];
    [NSUserStoreTool removeObjectWithKey:kPassword];
    [NSUserStoreTool removeObjectWithKey:kUserHeadImage];
    [NSUserStoreTool removeObjectWithKey:kGender];
    [NSUserStoreTool removeObjectWithKey:kSignature];
    [NSUserStoreTool removeObjectWithKey:kApplyclasstypeinfo];
    [NSUserStoreTool removeObjectWithKey:kApplycoachinfo];
    [NSUserStoreTool removeObjectWithKey:kApplyschoolinfo];
    [NSUserStoreTool removeObjectWithKey:kheadportrait];
    [NSUserStoreTool removeObjectWithKey:kaddress];
    [NSUserStoreTool removeObjectWithKey:kidcardnumber];
    [NSUserStoreTool removeObjectWithKey:@"schoolid"];
    [NSUserStoreTool removeObjectWithKey:@"coachid"];
    [NSUserStoreTool removeObjectWithKey:ksubject];
    [NSUserStoreTool removeObjectWithKey:ksubjectThree];
    [NSUserStoreTool removeObjectWithKey:ksubjectTwo];
}

+ (void)saveUserBanner:(NSArray *)dataArray{
    [NSUserStoreTool storeWithId:dataArray WithKey:kBannerUrl];
}

+(NSArray *)getBannerUrlArray{
    NSArray *array = [NSUserStoreTool getObjectWithKey:kBannerUrl];
    NSArray *dataArray = [[NSArray alloc] init];
    if (array !=nil) {
        NSError *error = nil;
        dataArray = [MTLJSONAdapter modelsOfClass:BannerModel.class fromJSONArray:array error:&error];
    }
    return dataArray;
}

- (void)dealloc{
   //DYNSLog(@"对象销毁");
}

@end
