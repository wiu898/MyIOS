//
//  NSUserStoreTool.m
//  PodTest
//
//  Created by 李超 on 15/12/7.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "NSUserStoreTool.h"

@implementation NSUserStoreTool

+ (BOOL)isStoreWithKey:(NSString *)key{
   
    //根据Key取出自定义类内容
    //NSUserDefaults是一个单例,存储简单数据,存储的数据是不可变的
    id content = [[NSUserDefaults standardUserDefaults] objectForKey:key];

    if (content != nil) {
        return YES;
    }
    return NO;
}

//存储对象
+ (void)storeWithId:(id)storeContent WithKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setObject:storeContent forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

//取出对象
+ (id)getObjectWithKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

//删除对象中的数据
+ (void)removeObjectWithKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

@end
