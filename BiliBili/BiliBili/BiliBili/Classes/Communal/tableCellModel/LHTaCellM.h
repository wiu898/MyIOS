//
//  LHTaCellM.h
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHCoderObject.h"

@interface LHTaCellM : YHCoderObject

@property (nonatomic, copy) NSString* pic;

@property (nonatomic,strong) NSNumber *av;

@property (nonatomic, copy) NSString* title;

@property (nonatomic,strong) NSNumber *click;

@property (nonatomic,strong) NSNumber *dm_count;

@property (nonatomic, copy) NSString* des;

@property (nonatomic, copy) NSString* author_name;

@property (nonatomic,copy) NSString *collTime;

@property (nonatomic,copy) NSString *hisTime;

@property (nonatomic,copy) NSString *cover;

@property (nonatomic,copy) NSString *danmaku;

@property (nonatomic,copy) NSString *desc1;

@property (nonatomic,copy) NSString *desc2;

@property (nonatomic,copy) NSString *play;

@property (nonatomic,copy) NSString *param;

@property (nonatomic,copy) NSString *up_face;

@property (nonatomic,copy) NSString *up;

@property (nonatomic,copy) NSString *online;

@property (nonatomic,copy) NSString *small_cover;

@property (nonatomic,assign) NSInteger rand;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)cellWithDict:(NSDictionary *)dict;


@end
