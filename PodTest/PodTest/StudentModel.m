//
//  StudentModel.m
//  PodTest
//
//  Created by 李超 on 16/1/22.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "StudentModel.h"

@implementation StudentModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
     return @{@"infoId":@"_id",@"userid":@"userid"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}

@end
