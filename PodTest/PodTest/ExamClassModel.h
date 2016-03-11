//
//  ExamClassModel.h
//  PodTest
//
//  Created by 李超 on 16/1/14.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <MTLJSONAdapter.h>
#import "MTLModel.h"
#import "SchoolInfo.h"
#import "VipserverModel.h"
#import "CarModel.h"

@interface ExamClassModel : MTLModel<MTLJSONSerializing>

@property (strong,readonly,nonatomic) NSNumber *applycount;
@property (copy, readonly, nonatomic) NSString *begindate;
@property (copy, readonly, nonatomic) NSString *classid;
@property (strong, readonly, nonatomic) CarModel *carmodel;
@property (copy, readonly, nonatomic) NSString *cartype;
@property (copy, readonly, nonatomic) NSString *classchedule;
@property (copy, readonly, nonatomic) NSString *classdesc;
@property (copy, readonly, nonatomic) NSString *classname;
@property (copy, readonly, nonatomic) NSString *enddate;
@property (strong, readonly, nonatomic) NSNumber *is_vip;
@property (strong, readonly, nonatomic) NSNumber *price;
@property (strong, readonly, nonatomic) SchoolInfo *schoolinfo;
@property (strong, readonly, nonatomic) NSArray *vipserverlist;

@end
