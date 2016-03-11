//
//  Logoimg.m
//  PodTest
//
//  Created by 李超 on 15/12/7.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "Logoimg.h"

@implementation Logoimg

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"height":@"height",@"originalpic":@"originalpic",
             @"thumbnailpic":@"thumbnailpic",@"width":@"width"};
}

- (instancetype) initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self ==nil) {
        return nil;
    }
    return self;
}

@end
