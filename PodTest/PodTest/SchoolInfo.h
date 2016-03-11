//
//  SchoolInfo.h
//  PodTest
//
//  Created by 李超 on 16/1/14.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "MTLModel.h"
#import <MTLJSONAdapter.h>

@interface SchoolInfo : MTLModel<MTLJSONSerializing>

@property (copy,readonly,nonatomic) NSString *address;
@property (strong,readonly,nonatomic) NSNumber *latitude;
@property (strong,readonly,nonatomic) NSNumber *longitude;
@property (copy,readonly,nonatomic) NSString *name;
@property (copy,readonly,nonatomic) NSString *schoolid;

@end
