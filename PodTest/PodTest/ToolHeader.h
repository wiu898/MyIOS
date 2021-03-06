//
//  ToolHeader.h
//  PodTest
//
//  Created by 李超 on 15/11/30.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//


#import <Masonry.h>
#import "WMUITool.h"
#import "JENetwoking.h"
#import "AccountManager.h"
#import "NetMonitor.h"
#import "JsonTransformManager.h"
#import <UIImageView+WebCache.h>
#import "NSString+CurrentTimeDay.h"
#import <IQKeyboardManager.h>
#import <EaseMob.h>

typedef NS_ENUM(NSUInteger,SubjectState){
    SubjectStateTime,
    SubjectStateWaitConfirm,
    SubjectStateWaitEvaluation,
    SubjectStateCompletion
};

typedef NS_ENUM(NSUInteger,AppointmentState){
    AppointmentStateWait,
    AppointmentStateSelfCancel,
    AppointmentStateCoachConfirm,
    AppointmentStateCoachCancel,
    AppointmentStateConfirmEnd,
    AppointmentStateWaitComment,
    AppointmentStateFinish,
    AppointmentStateSystemCancel
};


static NSString *const kQiniuUpdateUrl = @"info/qiniuuptoken";

static NSString *const kQiniuImageUrl = @"http://7xnjg0.com1.z0.glb.clouddn.com/%@";

#define kShowSuccess(msg) [SVProgressHUD showSuccessWithStatus:msg];

#define kShowDismiss     [SVProgressHUD dismiss];

#define kShowFail(msg)    [SVProgressHUD showErrorWithStatus:msg];


#define RGBColor(R,G,B)  [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1]
//RGBColor(255, 102, 51)
#define MAINCOLOR  [UIColor colorWithRed:255/255.0f green:102/255.0f blue:51/255.0f alpha:1]
//247, 249, 251
#define TEXTGRAYCOLOR [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1]

#define BACKGROUNDCOLOR [UIColor colorWithRed:247/255.0f green:249/255.0f blue:251/255.0f alpha:1]

#define BASEURL @"http://101.200.204.240:8181/api/v1/%@"
//http://123.57.63.15:8181/api/v1/ 正式
//http://101.200.204.240:8181/api/v1/ 测试
#define kSystemWide [UIScreen mainScreen].bounds.size.width

#define kSystemHeight [UIScreen mainScreen].bounds.size.height

#ifdef DEBUG
#define DYNSLog(...) NSLog(__VA_ARGS__)
#else
#define DYNSLog(...)
#endif