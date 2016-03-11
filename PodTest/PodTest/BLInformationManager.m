//
//  BLInformationManager.m
//  PodTest
//
//  Created by 李超 on 15/12/28.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "BLInformationManager.h"

@interface BLInformationManager()

@end

@implementation BLInformationManager

+ (BLInformationManager *)sharedInstance{

    static BLInformationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

@end
