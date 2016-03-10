//
//  WSQuesiton.h
//  WangYiNews
//
//  Created by 李超 on 16/2/29.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHCoderObject.h"

@interface WSQuesiton : YHCoderObject

@property (copy, nonatomic) NSString *questionId;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *relatedExpertId;
@property (copy, nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *userHeadPicUrl;
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *cTime;

+ (instancetype)quesitonWithDict:(NSDictionary *)dict;

@end
