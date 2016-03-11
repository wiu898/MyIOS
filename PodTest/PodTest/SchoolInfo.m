//
//  SchoolInfo.m
//  PodTest
//
//  Created by 李超 on 16/1/14.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "SchoolInfo.h"

@implementation SchoolInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
 return @{@"address":@"address",@"latitude":@"latitude",@"longitude":@"longitude",@"name":@"name",@"schoolid":@"schoolid"};
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
