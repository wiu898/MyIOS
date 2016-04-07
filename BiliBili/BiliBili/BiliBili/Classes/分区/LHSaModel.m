//
//  LHSaModel.m
//  BiliBili
//
//  Created by 李超 on 16/4/6.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHSaModel.h"

@implementation LHSaModel

+ (instancetype)saCellWithDict:(NSDictionary *)dict{

    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

@end
