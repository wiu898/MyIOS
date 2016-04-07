//
//  CFDanmaku.h
//  BiliBili
//
//  Created by 李超 on 16/3/31.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "YHCoderObject.h"
#import <UIKit/UIKit.h>

//弹幕位置
typedef enum :NSInteger{

    CFDanmakuPositionNone = 0,
    CFDanmakuPositionCenterTop,
    CFDanmakuPositionCenterBottom

}CFDanmakuPosition;

@interface CFDanmaku : YHCoderObject

// 对应视频的时间戳
@property(nonatomic, assign) NSTimeInterval timePoint;

// 弹幕内容
@property(nonatomic, copy) NSAttributedString* contentStr;

// 弹幕类型(如果不设置 默认情况下只是从右到左滚动)
@property(nonatomic, assign) CFDanmakuPosition position;

@end
