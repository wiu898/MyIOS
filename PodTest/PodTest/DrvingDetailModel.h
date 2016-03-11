//
//  DrvingDetailModel.h
//  PodTest
//
//  Created by 李超 on 16/1/5.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <MTLJSONAdapter.h>
#import "Logoimg.h"

@interface DrvingDetailModel : MTLModel<MTLJSONSerializing>

@property (copy,readonly,nonatomic) NSString *address;
@property (copy,readonly,nonatomic) NSString *hours;
@property (copy,readonly,nonatomic) NSString *introduction;
@property (copy,readonly,nonatomic) NSNumber *latitude;
@property (strong,readonly,nonatomic) Logoimg *logoimg;
@property (copy,readonly,nonatomic) NSNumber *longitude;
@property (copy,readonly,nonatomic) NSString *name;
@property (strong,readonly,nonatomic) NSNumber *passingrate;
@property (copy,readonly,nonatomic) NSString *phone;
@property (strong,readonly,nonatomic) NSArray *pictures;
@property (copy,readonly,nonatomic) NSString *registertime;
@property (copy,readonly,nonatomic) NSString *responsible;
@property (copy,readonly,nonatomic) NSString *schoolid;
@property (copy,readonly,nonatomic) NSString *websit;

@end
