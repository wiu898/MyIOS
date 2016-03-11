//
//  DrivingModel.h
//  PodTest
//
//  Created by 李超 on 16/1/13.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <MTLJSONAdapter.h>
#import "Logoimg.h"

@interface DrivingModel : MTLModel<MTLJSONSerializing>

@property (copy,readonly ,nonatomic) NSString *address;
@property (copy,readonly , nonatomic) NSNumber *distance;
@property (copy,readonly , nonatomic) NSNumber *latitude;
@property (strong,readonly , nonatomic) Logoimg *logoimg;
@property (copy,readonly , nonatomic) NSNumber *longitude;
@property (copy,readonly , nonatomic) NSNumber *maxprice;
@property (copy,readonly , nonatomic) NSNumber *minprice;
@property (copy,readonly , nonatomic) NSString *name;
@property (strong,readonly, nonatomic) NSNumber *passingrate;
@property (copy,readonly , nonatomic) NSString *schoolid;

@end
