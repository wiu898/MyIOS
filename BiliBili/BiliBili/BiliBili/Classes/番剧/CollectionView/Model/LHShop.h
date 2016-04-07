//
//  LHShop.h
//  BiliBili
//
//  Created by 李超 on 16/3/28.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHShop : NSObject

@property (nonatomic,copy) NSString *cover;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,assign) NSInteger play_count;

@property (nonatomic,assign) NSInteger danmaku_count;

@property (nonatomic,assign) NSInteger season_id;

@property (nonatomic,assign) NSInteger weekday;

@property (nonatomic,copy) NSString *bgmcount;

@property (nonatomic,assign) NSInteger is_finish;

@property (nonatomic,assign) Boolean isNew;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)shopWithDict:(NSDictionary *)dict;

@end
