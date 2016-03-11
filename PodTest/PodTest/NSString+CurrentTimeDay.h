//
//  NSString+CurrentTimeDay.h
//  PodTest
//
//  Created by 李超 on 15/12/17.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CurrentTimeDay)

+ (NSString *)currentTimeDay;
+ (NSString *)currentDay;
+ (NSString *)getDayWithAddCountWithDisplay:(NSUInteger)count;
+ (NSString *)getDayWithAddCountWithData:(NSUInteger)count;
+ (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate;
+ (NSString *)getYearLocalDateFormateUTCDate:(NSString *)utcDate;
+ (NSString *)getHourLocalDateFormateUTCDate:(NSString *)utcDate;
+ (NSString *)getLittleLocalDateFormateUTCDate:(NSString *)utcDate;

@end
