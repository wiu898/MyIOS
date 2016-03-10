//
//  WSGetDataTool.h
//  WangYiNews
//
//  Created by 李超 on 16/2/23.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "AFNetworking.h"
#include <Foundation/Foundation.h>

typedef enum{
    
      WSGETDataTypeBaseURL,  //通过baseurl获取数据
      WSGETDataTypeCommentURL   //通过评论的url获取数据
    
}WSGETDataType;

typedef void(^progressBlock)(NSProgress *downloadProgress);
typedef void(^successBlock)(NSURLSessionDataTask *task,id responseObject);
typedef void(^failureBlock)(NSURLSessionDataTask *task,NSError *error);
typedef void(^GetDataSuccessBlock)(NSArray *dataArr);
typedef void(^GetDataFailureBlock)(NSError *error);

@interface WSGetDataTool : AFHTTPSessionManager

+ (NSURLSessionDataTask *)GETJSON:(NSString *)urlStr GetDataType:(WSGETDataType)type progress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure;

@end
