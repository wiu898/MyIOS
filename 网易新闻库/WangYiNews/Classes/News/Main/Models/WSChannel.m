//
//  WSChannel.m
//  WangYiNews
//
//  Created by 李超 on 16/2/23.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "WSChannel.h"

@implementation WSChannel

+ (instancetype)channelWithDict:(NSDictionary *)dict{
    id obj = [[super alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    if ([[obj tname] isEqualToString:@"头条"]) {
        [obj setChannelURL:[NSString stringWithFormat:@"/nc/article/headline/%@/0-20.html",[obj tid]]];
    }else{
        [obj setChannelURL:[NSString stringWithFormat:@"/nc/article/list/%@/0-20.html",[obj tid]]];
    }
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

@end
