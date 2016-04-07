//
//  LHSpModel.h
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHSpModel : NSObject

@property (nonatomic,copy) NSString *evaluate;

@property (nonatomic,strong) NSArray *episodes;

@property (nonatomic,strong) NSArray *tags;

@property (nonatomic,strong) NSArray *seasons;

+(instancetype)spMWithDict:(NSDictionary *)dict;

@end
