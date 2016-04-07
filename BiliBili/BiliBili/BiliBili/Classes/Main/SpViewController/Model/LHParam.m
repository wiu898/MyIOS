//
//  LHParam.m
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHParam.h"

@implementation LHParam

+ (instancetype)paramWithDict:(NSDictionary *)dict{

    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict{
  
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        self.param = [dict valueForKey:@"av_id"];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString*)key
{
    
}

@end
