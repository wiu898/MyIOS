//
//  NetMonitor.h
//  PodTest
//
//  Created by 李超 on 15/12/17.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef NS_ENUM(NSUInteger, NetMonitorState){
    NetMonitorStateUnknown,
    NetMonitorStateWiFi,
    NetMonitorStateWMAN
};

@interface NetMonitor : NSObject

@property (readonly, nonatomic, assign) NetMonitorState _netMonitorState;

+ (NetMonitor *)manager;

@end
