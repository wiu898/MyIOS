//
//  WSAudioController.m
//  WangYiNews
//
//  Created by 李超 on 16/3/1.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "WSAudioController.h"

@implementation WSAudioController

#pragma mark - init

+ (instancetype)audioController{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Media" bundle:nil];
    
    return [sb instantiateViewControllerWithIdentifier:@"audioController"];
}

@end
