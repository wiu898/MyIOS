//
//  PrefixHeader.h
//  WangYiNews
//
//  Created by 李超 on 16/2/18.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

//**************调试和发布版本之间的设置*****************

#ifdef DEBUG //调试模式--模拟器

#define HMLog(...) NSLog(__VA_ARGS__)  //公司自定义打印

#else //发布模式 RELEASE--真机

#define HMLog(...)  //发布版本下取消自定义打印，自定义打印不起作用

#endif

//**************所有objective-c文件共享的头文件*****************

#ifdef __OBJC__  //所有objective-c文件共享的头文件

#import "UIView+Frame.h"
#import <UIKit/UIKit.h>

#define kScreenSize [UIScreen mainScreen].bounds
#define kScreenWidth kScreenSize.size.width
#define kScreenHeight kScreenSize.size.height

#define kTabBarHeight 64
#define kTitleFont [UIFont systemFontOfSize:15]
#define kDetailFont [UIFont systemFontOfSize:13]

#endif

//*************************公用的头文件************************
