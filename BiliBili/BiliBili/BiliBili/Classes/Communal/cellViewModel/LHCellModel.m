//
//  LHCellModel.m
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHCellModel.h"

@implementation LHCellModel

+ (instancetype)cellMWithDict:(NSDictionary *)dict{

    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        
        self.title = [dict valueForKey:@"title"];
        
        self.small_cover = [ dict valueForKey:@"pic"];
        
        self.param = [dict valueForKey:@"aid"];
        
        self.desc2 = [NSString stringWithFormat:@"UP主:%@",[dict valueForKey:@"author"]];
        
        self.danmaku = [dict valueForKey:@"video_review"];
        
        self.play = [dict valueForKey:@"play"];
        
        self.desc1 = [dict valueForKey:@"description"];

    }
    return self;
}

@end
