//
//  DriveSchoolinfo.m
//  PodTest
//
//  Created by 李超 on 15/12/28.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "DriveSchoolinfo.h"

@implementation DriveSchoolinfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"driveSchoolId":@"id",@"name":@"name"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:
    (NSError *__autoreleasing *)error{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) {
        return nil;
    }
    return self;
}

@end
