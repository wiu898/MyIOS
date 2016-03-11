//
//  BLInformationManager.h
//  PodTest
//
//  Created by 李超 on 15/12/28.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppointmentCoachModel.h"

@interface BLInformationManager : NSObject

@property (copy, nonatomic) NSMutableArray *appointmentData;
@property (strong, nonatomic) AppointmentCoachModel *appointmentCoachModel;

+ (BLInformationManager *)sharedInstance;

@end
