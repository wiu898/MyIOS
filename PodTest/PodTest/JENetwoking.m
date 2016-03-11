//
//  JENetwoking.m
//  PodTest
//
//  Created by 李超 on 15/12/9.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "JENetwoking.h"
#import "ToolHeader.h"
#import <SVProgressHUD.h>
#import <UIKit/UIKit.h>
#import "AccountManager.h"

@interface JENetwoking()

@property (copy, nonatomic) NSString *urlString;
@property (assign, nonatomic) JENetworkingRequestMethod method;
@property (weak, nonatomic) id<JENetwokingDelegate>delegate;

@end

@implementation JENetwoking

//大量数据下载
+ (instancetype)initWithUrl:(NSString *)urlString
       WithMethod:(JENetworkingRequestMethod)method
       WithDelegate:(id<JENetwokingDelegate>)delegate{
    DYNSLog(@"data ");
    
    JENetwoking *networking = [[self alloc] init];
    networking.urlString = urlString;
    networking.method = method;
    networking.delegate = delegate;
    [networking startDownLoad];
    return networking;
}

- (void)startDownLoad{
    
    if (self.method == JENetworkingRequestMethodGet) {
        
        AFHTTPRequestOperationManager *manager =
            [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = 30;
        manager.requestSerializer.cachePolicy =
            NSURLRequestUseProtocolCachePolicy;
        
        //GET请求
        [manager GET:self.urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull
                    operation, id  _Nonnull responseObject) {
            
            if (responseObject == nil) {
                [SVProgressHUD showErrorWithStatus:@"网络错误"];
                return ;
            }
            
            if ([_delegate respondsToSelector:@selector
                  (jeNetworkingCallBackData:)]) {
                [_delegate jeNetworkingCallBackData:responseObject];
            }
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            [SVProgressHUD showWithStatus:@"网络错误"];
            
        }];
    }
}

//简单获取回调用于按钮点击上传图片，点击发送消息
+ (void)startDownLoadWithUrl:(NSString *)urlString
                   postParam:(id)param
                  WithMethod:(JENetworkingRequestMethod)method
              withCompletion:(Completion)completion {

    Completion _completion = [completion copy];
    
    AFHTTPRequestOperationManager *manager =
        [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.cachePolicy =
        NSURLRequestUseProtocolCachePolicy;
    manager.requestSerializer.timeoutInterval = 30.0f;
    
    if (method == JENetworkingRequestMethodGet) {
        DYNSLog(@"token = %@",[AccountManager manager].userToken);
        if ([AccountManager manager].userToken) {
            [manager.requestSerializer setValue:[AccountManager manager].userToken
                        forHTTPHeaderField:@"authorization"];
        }
        [manager GET:urlString parameters:nil success:
            ^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
         
            if (responseObject == nil) {
                [SVProgressHUD showErrorWithStatus:@"网络错误"];
                return;
            }
            
            if (_completion) {
                _completion(responseObject);
            }
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            
            DYNSLog(@"error = %@",error);
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
        }];
    }else if (method == JENetworkingRequestMethodPost){
     //   NSAssert(param !=nil, @"param 不能为空");
        if ([AccountManager manager].userToken) {
            [manager.requestSerializer setValue:[AccountManager manager].userToken
                             forHTTPHeaderField:@"authorization"];
        }
        //请求消息头
        DYNSLog(@"token = %@", manager.requestSerializer.HTTPRequestHeaders);
        
        [manager POST:urlString parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            if (responseObject == nil) {
                [SVProgressHUD showErrorWithStatus:@"网络错误"];
                return;
            }
            
            if (_completion) {
                _completion(responseObject);
            }
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            DYNSLog(@"error = %@",error);
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
        }];
    }else if (method == JENetworkingRequestMethodDelete){
    
        if ([AccountManager manager].userToken) {
            [manager.requestSerializer setValue:[AccountManager manager].userToken
                             forHTTPHeaderField:@"authorization"];
        }
        DYNSLog(@"token = %@",manager.requestSerializer.HTTPRequestHeaders);
        
        [manager DELETE:urlString parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            if (responseObject == nil) {
                [SVProgressHUD showErrorWithStatus:@"网络错误"];
                return;
            }
            
            if (_completion) {
                _completion(responseObject);
            }
            
        }failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            DYNSLog(@"error = %@",error);
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
        }];
    }
    
}

+ (void)startDownLoadWithUrl:(NSString *)urlString postParam:(id)param WithMethod:(JENetworkingRequestMethod)method withCompletion:(Completion)completion withFailure:(Failure)failure{
    
    Completion _completion = [completion copy];
    
    Failure _failure = [failure copy];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    manager.requestSerializer.timeoutInterval = 30.0f;
    if (method == JENetworkingRequestMethodGet) {
        DYNSLog(@"token = %@",[AccountManager manager].userToken);
        if ([AccountManager manager].userToken) {
            [manager.requestSerializer setValue:[AccountManager manager].userToken
                             forHTTPHeaderField:@"authorization"];
        }
        
        [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
            if (responseObject == nil) {
                [SVProgressHUD showErrorWithStatus:@"网络错误"];
                return;
            }
            
            if (_completion) {
                _completion(responseObject);
            }
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            DYNSLog(@"error = %@",error);
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
            _failure(error);
        }];
    }else if (method == JENetworkingRequestMethodPost){
        NSAssert(param !=nil, @"param 不能为空");
        if ([AccountManager manager].userToken) {
            [manager.requestSerializer setValue:[AccountManager manager].userToken
                             forHTTPHeaderField:@"authorization"];
        }
        DYNSLog(@"token = %@",manager.requestSerializer.HTTPRequestHeaders);
        
        [manager POST:urlString parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            if (responseObject == nil) {
                [SVProgressHUD showErrorWithStatus:@"网络错误"];
                return;
            }
            
            if (_completion) {
                _completion(responseObject);
            }
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            DYNSLog(@"error = %@",error);
            _failure(error);
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
        }];
    }else if (method == JENetworkingRequestMethodPut){
        if ([AccountManager manager].userToken) {
            [manager.requestSerializer setValue:[AccountManager manager].userToken
                             forHTTPHeaderField:@"authorization"];
        }
        DYNSLog(@"token = %@",manager.requestSerializer.HTTPRequestHeaders);
        
        [manager PUT:urlString parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            DYNSLog(@"responseObject == %@",responseObject);
            if (responseObject == nil) {
                [SVProgressHUD showErrorWithStatus:@"网络错误"];
                return;
            }
            
            if (_completion) {
                _completion(responseObject);
            }
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            DYNSLog(@"error = %@",error);
            _failure(error);
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
        }];
    }else if (method == JENetworkingRequestMethodDelete){
        if ([AccountManager manager].userToken) {
            [manager.requestSerializer setValue:[AccountManager manager].userToken
                             forHTTPHeaderField:@"authorization"];
        }
        DYNSLog(@"token = %@",manager.requestSerializer.HTTPRequestHeaders);
        
        [manager DELETE:urlString parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            DYNSLog(@"responseObject = %@",responseObject);
            if (responseObject == nil) {
                [SVProgressHUD showErrorWithStatus:@"网络错误"];
                return;
            }
            
            if (_completion) {
                _completion(responseObject);
            }
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            DYNSLog(@"error = %@",error);
            _failure(error);
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
        }];
    }
}

@end
