//
//  BannerModel.m
//  SYStickHeaderWaterFall
//
//  Created by 李超 on 16/3/16.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "BannerModel.h"
#import "MJExtension.h"

@implementation BannerModel

+ (instancetype)initBannerWithDict:(NSDictionary *)dict{
   
    BannerModel *model = [[BannerModel alloc] init];
    
    [model mj_setKeyValues:dict];
   
    return model;

}

@end
