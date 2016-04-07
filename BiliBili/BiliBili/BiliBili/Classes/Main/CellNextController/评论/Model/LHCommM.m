//
//  LHCommM.m
//  BiliBili
//
//  Created by 李超 on 16/3/30.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHCommM.h"

@implementation LHCommM

+ (instancetype)cellWithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc]init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
