//
//  VipserverModel.m
//  PodTest
//
//  Created by 李超 on 16/1/14.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "VipserverModel.h"

@implementation VipserverModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"infoId":@"_id",@"msgId":@"id",
             @"color":@"color",@"name":@"name"};
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
