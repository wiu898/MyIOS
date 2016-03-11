//
//  DrivingModel.m
//  PodTest
//
//  Created by 李超 on 16/1/13.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "DrivingModel.h"

@implementation DrivingModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"address":@"address",@"distance":@"distance",@"logoimg":@"logoimg",@"latitude":@"latitude",@"longitude":@"longitude",@"maxprice":@"maxprice",@"minprice":@"minprice",@"name":@"name",@"passingrate":@"passingrate",@"schoolid":@"schoolid"};
}

+ (NSValueTransformer *)logoimgJSONTransformer{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:Logoimg.class];
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
