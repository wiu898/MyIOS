//
//  NSString+Times.m
//  DouYU
//
//  Created by 李超 on 16/3/22.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "NSString+Times.h"

@implementation NSString (Times)

+ (NSString *)GetNowTimes{
  
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a = [date timeIntervalSince1970];
    
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    
    return timeString;
}

@end
