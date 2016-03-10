//
//  WSAnswer.m
//  WangYiNews
//
//  Created by 李超 on 16/2/29.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "WSAnswer.h"

@implementation WSAnswer

+ (instancetype)answerWithDict:(NSDictionary *)dict{

    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

@end
