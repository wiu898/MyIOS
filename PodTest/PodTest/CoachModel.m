//
//  CoachModel.m
//  PodTest
//
//  Created by 李超 on 15/12/31.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "CoachModel.h"

@implementation CoachModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
   return @{@"Seniority":@"Seniority",@"coachid":@"coachid",@"distance":@"distance",@"name":@"name",@"driveschoolinfo":@"driveschoolinfo",@"headportrait":@"headportrait",@"is_shuttle":@"is_shuttle",@"latitude":@"latitude",@"longitude":@"longitude",@"passrate":@"passrate",@"starlevel":@"starlevel"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue
    error:(NSError *__autoreleasing *)error{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) {
        return nil;
    }
    return self;
}

@end
