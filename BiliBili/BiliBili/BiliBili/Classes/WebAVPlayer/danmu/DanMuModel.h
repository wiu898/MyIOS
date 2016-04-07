//
//  DanMuModel.h
//  BiliBili
//
//  Created by 李超 on 16/3/30.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "YHCoderObject.h"
#import <Foundation/Foundation.h>

@interface DanMuModel : YHCoderObject

@property (nonatomic, strong) NSNumber* sendTime;

@property (nonatomic, strong) NSNumber* style;

@property (nonatomic, strong) NSNumber* fontSize;

@property (nonatomic, strong) NSNumber* textColor;

@property (nonatomic, strong) NSString* text;

+ (instancetype)modelWithParameter:(NSString*)parameter
    text:(NSString*)text;

@end
