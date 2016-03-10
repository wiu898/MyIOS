//
//  WSAds.h
//  WangYiNews
//
//  Created by 李超 on 16/2/23.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSAds : NSObject

@property (copy, nonatomic) NSString *imgsrc;
@property (copy, nonatomic) NSString *subtitle;
@property (copy, nonatomic) NSString *tag;
@property (copy, nonatomic) NSString *docid;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *url;

+ (instancetype)adsWithDic:(NSDictionary *)dict;

@end
