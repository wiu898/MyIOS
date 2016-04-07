//
//  LHSaModel.h
//  BiliBili
//
//  Created by 李超 on 16/4/6.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHSaModel : NSObject

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *icon;

+(instancetype)saCellWithDict:(NSDictionary *)dict;

@end
