//
//  UIDevice+JEsystemVersion.m
//  PodTest
//
//  Created by 李超 on 15/12/22.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "UIDevice+JEsystemVersion.h"

@implementation UIDevice (JEsystemVersion)

+ (float)jeSystemVersion {
    return [self currentDevice].systemVersion.floatValue;
}

@end
