//
//  AVPlayModel.m
//  PodTest
//
//  Created by 李超 on 15/12/24.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "AVPlayModel.h"

@implementation AVPlayModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
      return
         @{@"infoId":@"_id",@"name":@"name",@"pictures":@"pictures",
           @"seqindex":@"seqindex",@"subject":@"subject",@"videourl":@"videourl"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
