//
//  WSAds.m
//  WangYiNews
//
//  Created by 李超 on 16/2/23.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "WSAds.h"

@implementation WSAds

+ (instancetype)adsWithDic:(NSDictionary *)dict{
    id obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

@end
