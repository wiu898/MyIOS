//
//  AppDelegate.h
//  DouYU
//
//  Created by 李超 on 16/3/22.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BOOL _isFull; // 是否全屏
}

@property (nonatomic) BOOL isFull;

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) NSMutableArray *Array;

@end

