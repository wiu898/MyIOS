//
//  LHFaheadModel.h
//  BiliBili
//
//  Created by 李超 on 16/4/6.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHFaheadModel : NSObject

@property (nonatomic,copy) NSString *cover;

@property (nonatomic,copy) NSString *keyword;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (NSURLSessionDataTask *)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block;

@end
