//
//  LHNetworkQueue.m
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHNetworkQueue.h"

@implementation LHNetworkQueue

+ (instancetype)shared{

    static id _instance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
    
        _instance = [[ASINetworkQueue alloc] init];
        
        [_instance reset];
        
        [_instance setShowAccurateProgress:YES];
        
        [_instance go];
    });
    
    return _instance;
}

@end
