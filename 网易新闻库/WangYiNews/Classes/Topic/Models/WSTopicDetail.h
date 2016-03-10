//
//  WSTopicDetail.h
//  WangYiNews
//
//  Created by 李超 on 16/2/29.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHCoderObject.h"
#import "WSGetDataTool.h"

@class WSAnswer,WSQuesiton;

@interface WSTopicDetail : YHCoderObject

@property (strong, nonatomic) WSQuesiton *question;
@property (strong, nonatomic) WSAnswer *answer;

+ (void)topDetailWithIndex:(NSInteger)index isCache:(BOOL)cache expertID:(NSString *)ID getDataSuccess:(GetDataSuccessBlock)success getDataFailure:(GetDataFailureBlock)failure;

+ (NSArray *)cacheWithExpertID:(NSString *)ID;

@end
