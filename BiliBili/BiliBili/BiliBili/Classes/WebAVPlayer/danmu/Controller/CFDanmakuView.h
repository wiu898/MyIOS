//
//  CFDanmakuView.h
//  BiliBili
//
//  Created by 李超 on 16/3/31.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFDanmaku.h"

@class CFDanmakuView;

@protocol CFDanmakuDelegate <NSObject>

@required

//获取视频播放时间
- (NSTimeInterval)danmakuViewGetPlayTime:(CFDanmakuView *)danmakuView;

//加载视频中
- (BOOL)danmakuViewIsBuffering:(CFDanmakuView *)danmakuView;

@end

@interface CFDanmakuView : UIView

@property (weak, nonatomic) id<CFDanmakuDelegate> delegate;

@property (assign, readonly, nonatomic) BOOL isPrepared;

@property (assign, readonly, nonatomic) BOOL isPlaying;

@property (assign, readonly, nonatomic) BOOL isPauseing;

- (void)prepareDanmakus:(NSArray *)danmakus;


//以下属于必须配置的-----
//弹幕动画时间

@property (assign, nonatomic) CGFloat duration;

// 中间上边/下边弹幕动画时间
@property (nonatomic, assign) CGFloat centerDuration;

// 弹幕弹道高度
@property (nonatomic, assign) CGFloat lineHeight;

// 弹幕弹道之间的间距
@property (nonatomic, assign) CGFloat lineMargin;

// 弹幕弹道最大行数
@property (nonatomic, assign) NSInteger maxShowLineCount;

// 弹幕弹道中间上边/下边最大行数
@property (nonatomic, assign) NSInteger maxCenterLineCount;

// start 与 stop 对应  pause 与 resume 对应
- (void)start;
- (void)pause;
- (void)resume;
- (void)stop;
- (void)clear;

// 发送一个弹幕
- (void)sendDanmakuSource:(CFDanmaku*)danmaku;

@end
