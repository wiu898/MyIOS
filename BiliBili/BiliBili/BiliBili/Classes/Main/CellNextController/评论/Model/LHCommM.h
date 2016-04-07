//
//  LHCommM.h
//  BiliBili
//
//  Created by 李超 on 16/3/30.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHCommM : NSObject

@property (nonatomic,copy) NSString *face;

@property (nonatomic,copy) NSString *create_at;

@property (nonatomic,assign) NSInteger good;

@property (nonatomic,copy) NSString *msg;

@property (nonatomic,copy) NSString *nick;

@property (nonatomic,strong) NSArray *reply;

@property (nonatomic,assign) NSInteger lv;

@property (nonatomic,assign) NSInteger isgood;

+(instancetype)cellWithDict:(NSDictionary *)dict;

@end
