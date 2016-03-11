//
//  DriveSchoolinfo.h
//  PodTest
//
//  Created by 李超 on 15/12/28.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>

@interface DriveSchoolinfo : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *driveSchoolId;
@property (copy, nonatomic, readonly) NSString *name;

@end
