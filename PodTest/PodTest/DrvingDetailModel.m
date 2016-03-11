
//
//  DrvingDetailModel.m
//  PodTest
//
//  Created by 李超 on 16/1/5.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "DrvingDetailModel.h"

@implementation DrvingDetailModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"address":@"address",@"hours":@"hours",@"introduction":@"introduction",@"latitude":@"latitude",@"logoimg":@"logoimg",@"longitude":@"longitude",@"name":@"name",@"passingrate":@"passingrate",@"phone":@"phone",@"pictures":@"pictures",@"registertime":@"registertime",@"responsible":@"responsible",@"schoolid":@"schoolid",@"websit":@"websit"};
}

+ (NSValueTransformer *)logoimgJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:Logoimg.class];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}

@end
