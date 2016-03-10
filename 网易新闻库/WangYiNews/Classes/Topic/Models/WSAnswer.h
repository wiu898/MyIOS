//
//  WSAnswer.h
//  WangYiNews
//
//  Created by 李超 on 16/2/29.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "YHCoderObject.h"
#import "YHCoderObject.h"

@interface WSAnswer : YHCoderObject

@property (copy, nonatomic) NSString *answerId;
@property (copy, nonatomic) NSString *board;
@property (copy, nonatomic) NSString *commentId;
@property (copy, nonatomic) NSString *relatedQuestionId;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *specialistName;
@property (copy, nonatomic) NSString *specialistHeadPicUrl;
@property (copy, nonatomic) NSString *supportCount;
@property (copy, nonatomic) NSString *replyCount;
@property (copy, nonatomic) NSString *cTime;

+ (instancetype)answerWithDict:(NSDictionary *)dict;

@end
