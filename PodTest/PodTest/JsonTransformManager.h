//
//  JsonTransformManager.h
//  PodTest
//
//  Created by 李超 on 15/12/17.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonTransformManager : NSObject

+ (NSString *)dictionaryTransformJsonWith:(NSDictionary *)dictionary;

+ (NSString *)arrayTransformJsonWith:(NSArray *)array;

@end
