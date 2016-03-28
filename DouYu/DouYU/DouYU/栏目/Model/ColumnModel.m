//
//  ColumnModel.m
//  DouYU
//
//  Created by 李超 on 16/3/24.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "ColumnModel.h"

@implementation ColumnModel

- (id)initWithDictionary:(NSDictionary *)dictionary{

    if (self = [super init]) {
    
        self.cate_id = dictionary[@"cate_id"];
        self.game_name=dictionary[@"game_name"];
        self.short_name=dictionary[@"short_name"];
        self.game_url=dictionary[@"game_url"];
        self.game_src=dictionary[@"game_src"];
        self.game_icon=dictionary[@"game_icon"];
        self.online_room=dictionary[@"online_room"];
        self.online_room_ios=dictionary[@"online_room_ios"];
    }
    return self;
}

@end
