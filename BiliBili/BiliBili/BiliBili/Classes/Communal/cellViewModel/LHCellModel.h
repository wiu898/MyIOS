//
//  LHCellModel.h
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHCoderObject.h"

@interface LHCellModel : YHCoderObject

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *pic;

@property (nonatomic,copy) NSString *cover;

@property (nonatomic,copy) NSString *danmaku;

@property (nonatomic,copy) NSString *desc1;

@property (nonatomic,copy) NSString *desc2;

@property (nonatomic,copy) NSString *play;

@property (nonatomic,copy) NSString *param;

@property (nonatomic,copy) NSString *up;

@property (nonatomic,copy) NSString *online;

@property (nonatomic,copy) NSString *small_cover;

@property (nonatomic,assign) NSInteger rand;

@property (nonatomic,copy) NSString *collTime;

@property (nonatomic,copy) NSString *hisTime;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)cellMWithDict:(NSDictionary *)dict;

@end
