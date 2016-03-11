//
//  SubjectTwoModel.m
//  PodTest
//
//  Created by 李超 on 15/12/7.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "SubjectTwoModel.h"

@implementation SubjectTwoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"finishcourse":@"finishcourse",@"progress":@"progress",
             @"reservation":@"reservation",@"totalcourse":@"totalcourse"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) {
        return nil;
    }
    return self;
}

@end
