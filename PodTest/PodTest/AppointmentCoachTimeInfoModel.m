//
//  AppointmentCoachTimeInfoModel.m
//  PodTest
//
//  Created by 李超 on 15/12/28.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "AppointmentCoachTimeInfoModel.h"

@implementation AppointmentCoachTimeInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"infoId":@"_id",@"coachid":@"coachid",@"coursedate":@"coursedate",@"coursestudentcount":@"coursestudentcount",@"coursetime":@"coursetime",@"courseuser":@"courseuser",@"createtime":@"createtime",@"selectedstudentcount":@"selectedstudentcount"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:
    (NSError *__autoreleasing *)error{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) {
        return nil;
    }
    return self;
}

- (NSInteger)indexPath{
    NSArray *indexArray = [self.coursetime.begintime
        componentsSeparatedByString:@":"];
    NSString *indexString = indexArray.firstObject;
    return indexString.integerValue;
}

@end
