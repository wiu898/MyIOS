//
//  LHParam.h
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHParam : NSObject

@property (nonatomic,copy) NSString *param;

@property (nonatomic,copy) NSString *cover;

@property (nonatomic,copy) NSString *danmaku;

@property (nonatomic,copy) NSString *update_time;

@property (nonatomic,copy) NSString *index;

+ (instancetype)paramWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
