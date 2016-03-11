//
//  NetMonitor.m
//  PodTest
//
//  Created by 李超 on 15/12/17.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "NetMonitor.h"
#import <AFNetworkActivityIndicatorManager.h>

@interface NetMonitor()

@property (readwrite, nonatomic) NetMonitorState _netMonitorState;
@property (strong, nonatomic) AFNetworkReachabilityManager *AFManager;

@end

@implementation NetMonitor

+ (NetMonitor *)manager{
    NetMonitor *manager = [[self alloc] init];
    return manager;
}

- (id)init{
    if (self = [super init]) {
        _AFManager = [AFNetworkReachabilityManager sharedManager];
        [_AFManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            NSLog(@"status");
            
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    __netMonitorState = NetMonitorStateUnknown;
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    __netMonitorState = NetMonitorStateWiFi;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    __netMonitorState = NetMonitorStateWMAN;
                default:
                    break;
            }
        }];
        [_AFManager startMonitoring];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    }
    return self;
}




















@end
