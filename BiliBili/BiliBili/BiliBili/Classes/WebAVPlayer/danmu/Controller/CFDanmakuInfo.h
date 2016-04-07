//
//  CFDanmakuInfo.h
//  BiliBili
//
//  Created by 李超 on 16/3/31.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHCoderObject.h"

@class CFDanmaku;

@interface CFDanmakuInfo : YHCoderObject

// 弹幕内容label
@property(nonatomic, weak) UILabel  *playLabel;

@property(nonatomic, assign) NSTimeInterval leftTime;

@property(nonatomic, strong) CFDanmaku* danmaku;

@property(nonatomic, assign) NSInteger lineCount;

@end
