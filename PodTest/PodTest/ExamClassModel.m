//
//  ExamClassModel.m
//  PodTest
//
//  Created by 李超 on 16/1/14.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "ExamClassModel.h"
#import <MTLValueTransformer.h>

@implementation ExamClassModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"applycount":@"applycount",@"begindate":@"begindate",@"classid":@"calssid",@"carmodel":@"carmodel",@"cartype":@"cartype",@"classchedule":@"classchedule",@"classdesc":@"classdesc",@"classname":@"classname",@"enddate":@"enddate",@"is_vip":@"is_vip",@"price":@"price",@"schoolinfo":@"schoolinfo",@"vipserverlist":@"vipserverlist"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue
     error:(NSError *__autoreleasing *)error{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) {
        return nil;
    }
    return self;
}

+ (NSValueTransformer *)vipserverlistJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:
            ^id(NSArray *value, BOOL *success, NSError *__autoreleasing *error) {
                
                NSMutableArray *mubArray = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in value) {
                    NSError *error = nil;
                    VipserverModel *model = [MTLJSONAdapter modelOfClass: VipserverModel.class fromJSONDictionary:dic error:&error];
                    [mubArray addObject:model];
                }
                return mubArray;
    }];
}

@end
