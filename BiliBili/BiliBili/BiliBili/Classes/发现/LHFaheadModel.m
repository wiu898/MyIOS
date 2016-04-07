//
//  LHFaheadModel.m
//  BiliBili
//
//  Created by 李超 on 16/4/6.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHFaheadModel.h"
#import "AFAppDotNetAPIClient.h"

@implementation LHFaheadModel

- (instancetype)initWithDict:(NSDictionary *)dict{

    self = [super init];
    
    if (self) {
        
        self.keyword = [dict valueForKey:@"keyword"];
        
        self.cover = [dict valueForKey:@"cover"];
    }
    
    return self;
}

+ (NSURLSessionDataTask *)globalTimelinePostsWithBlock:(void (^)(NSArray *, NSError *))block{

    return [[AFAppDotNetAPIClient sharedClient] GET:@"api/search/5391/search.android.xxhdpi.android.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *arrD = [responseObject valueForKeyPath:@"result"];
        
        NSArray *postsFromResponse = [arrD valueForKeyPath:@"recommend"];
        
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        
        for (NSDictionary *attributes in postsFromResponse) {
            
            LHFaheadModel *post = [[LHFaheadModel alloc] initWithDict:attributes];
            
            [mutablePosts addObject:post];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutablePosts],nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (block) {
            
            block([NSArray array], error);
        }
        
    }];
}

@end
