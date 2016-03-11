//
//  CourseTimeModel.m
//  PodTest
//
//  Created by 李超 on 15/12/28.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "CourseTimeModel.h"
#import <MTLValueTransformer.h>

@implementation CourseTimeModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"begintime":@"begintime",@"endtime":@"endtime",
            @"timeid":@"timeid",@"timespace":@"timespace"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:
    (NSError *__autoreleasing *)error{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) {
        return nil;
    }
    return self;
}

- (NSInteger)numMark{
    NSUInteger length = self.begintime.length;
    NSUInteger lastLength = length - 3;
    NSString *resultString = [self.begintime
        substringWithRange:NSMakeRange(0, lastLength)];
    return resultString.integerValue;
}

@end
