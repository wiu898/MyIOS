//
//  BannerModel.m
//  PodTest
//
//  Created by 李超 on 15/12/7.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "BannerModel.h"


@implementation BannerModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return  @{@"infoId":@"_id",@"createtime":@"createtime",@"headportrait":@"headportrait",
              @"is_using":@"is_using",@"linkurl":@"linkurl",@"newsname":@"newsname",
              @"newtype":@"newtype"};
}

- (instancetype) initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) {
        return nil;
    }
    return self;
}

@end
