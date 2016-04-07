//
//  LHTaCellM.m
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHTaCellM.h"
#import "NSString+Tools.h"

@implementation LHTaCellM

+ (instancetype)cellWithDict:(NSDictionary *)dict{

    return [[self alloc] initWithDict:dict];
}

- (instancetype) initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        
        self.param = [[dict valueForKey:@"id"]isKindOfClass:[NSString class]]?[dict valueForKey:@"id"]:[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]];
        
        self.desc1 = [dict valueForKey:@"description"];
        
        self.play = [dict valueForKey:@"click"]?[NSString stringWithFormatNum:[[dict valueForKey:@"click"] integerValue]]:[NSString stringWithFormatNum:[[dict valueForKey:@"play"] integerValue]];
        
        self.danmaku = [dict valueForKey:@"dm_count"]?[NSString stringWithFormat:@"%@",[dict valueForKey:@"dm_count"]]:[NSString stringWithFormat:@"%@",[dict valueForKey:@"favorites"]];
        
        self.desc2 = [dict valueForKey:@"author_name"]?[NSString stringWithFormat:@"UP主:%@",[dict valueForKey:@"author_name"]]:[NSString stringWithFormat:@"UP主:%@",[dict valueForKey:@"author"]];
        
        self.small_cover = [dict valueForKey:@"pic"];
        
        self.title = [dict valueForKey:@"title"];

    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
