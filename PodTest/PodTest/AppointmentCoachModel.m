//
//  AppointmentCoachModel.m
//  PodTest
//
//  Created by 李超 on 15/12/28.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "AppointmentCoachModel.h"

@implementation AppointmentCoachModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"seniority":@"Seniority",@"coachid":@"coachid",@"driveschoolinfo":@"driveschoolinfo",@"headportrait":@"headportrait",@"is_shuttle":@"is_shuttle",@"latitude":@"latitude",@"longitude":@"longitude",@"name":@"name",@"passrate":@"passrate",@"starlevel":@"starlevel"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}


@end
