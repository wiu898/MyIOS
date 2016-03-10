//
//  WSChannel.h
//  WangYiNews
//
//  Created by 李超 on 16/2/23.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSChannel : NSObject

//频道标识
@property (copy, nonatomic) NSString *tid;

//频道名称
@property (copy, nonatomic) NSString *tname;

//频道对应URL
@property (copy, nonatomic) NSString *channelURL;

+ (instancetype)channelWithDict:(NSDictionary *)dict;

@end
