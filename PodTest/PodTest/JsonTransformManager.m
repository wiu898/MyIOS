//
//  JsonTransformManager.m
//  PodTest
//
//  Created by 李超 on 15/12/17.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "JsonTransformManager.h"

@implementation JsonTransformManager

//dictionary数据转换为JSON
+ (NSString *)dictionaryTransformJsonWith:(NSDictionary *)dictionary{
    if (dictionary == nil) {
        return nil;
    }

    NSError *error = nil;
    
    //数据转换  通常是JSON数据和NSDictionary,NSArray之间的转换
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
        options:NSJSONWritingPrettyPrinted error:&error];
    
    if (error) {
        NSAssert(error,@"DictionqryTransformError");
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
        encoding:NSUTF8StringEncoding];
    return jsonString;
}

//NSArray转换为JSON

+ (NSString *)arrayTransformJsonWith:(NSArray *)array{
    if (array == nil) {
        return nil;
    }
    
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array
        options:NSJSONWritingPrettyPrinted error:&error];
  
    if (error) {
        NSAssert(error, @"ArrayTransformError");
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
        encoding:NSUTF8StringEncoding];
   
    return jsonString;
}

@end
