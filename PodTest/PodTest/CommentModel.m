//
//  CommentModel.m
//  PodTest
//
//  Created by 李超 on 16/1/2.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"commentcontent":@"commentcontent",@"starlevel":@"starlevel"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}

@end
