//
//  HomeModel.m
//  SYStickHeaderWaterFall
//
//  Created by 李超 on 16/3/16.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "HomeModel.h"
#import "MJExtension.h"

@implementation HomeModel

+ (instancetype)initHomeModelWithDict:(NSDictionary *)dict{

    HomeModel *model = [[HomeModel alloc] init];
    
    [model mj_setKeyValues:dict];
    
    return model;
}

@end
