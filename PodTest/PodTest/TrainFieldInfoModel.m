//
//  TrainFieldInfoModel.m
//  PodTest
//
//  Created by 李超 on 16/1/2.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "TrainFieldInfoModel.h"

@implementation TrainFieldInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"TrainFieldInfoModelId":@"_id",@"name":@"name"};
}

- (instancetype) initWithDictionary:(NSDictionary *)dictionaryValue
    error:(NSError *__autoreleasing *)error{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}


@end