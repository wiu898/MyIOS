//
//  NSUserStoreTool.h
//  PodTest
//
//  Created by 李超 on 15/12/7.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserStoreTool : NSObject

+ (BOOL)isStoreWithKey:(NSString *)key;

//存储对象
+ (void)storeWithId:(id)storeContent WithKey:(NSString *)key;

//取出对象
+ (id)getObjectWithKey:(NSString *)key;

//移除对象
+ (void)removeObjectWithKey:(NSString *)key;

@end
