//
//  LHSortAV.h
//  BiliBili
//
//  Created by 李超 on 16/3/30.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHSortAV : NSObject

@property (nonatomic,strong) NSNumber *AV;

@property (nonatomic,strong) NSNumber *P;

@property (nonatomic,strong) NSNumber *CID;

@property (nonatomic,copy) NSString *Title;

@property (nonatomic,copy) NSString *Mp4Url;

+ (instancetype)sortAVWithDict:(NSDictionary *)dict;

@end
