//
//  WSTabBar.h
//  WangYiNews
//
//  Created by 李超 on 16/2/18.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class WSTabBarItem;

#pragma mark -
#pragma mark WSTabBarItem
#pragma mark -

@interface WSTabBarItem :UIView

@property (assign, nonatomic, getter=isSelected) BOOL selected;

@property (copy, nonatomic) void
      (^_Nullable itemClick)(WSTabBarItem *_Nonnull item);

+ (nonnull instancetype)tabBarItemWithTitle:(nonnull NSString *)title itemImage:(nonnull UIImage *)image selectedImage:(nullable UIImage *)selImage;

@end



#pragma mark -
#pragma mark  WSTabBar
#pragma mark -

typedef void(^barItemClickBlock) (NSInteger);

@interface WSTabBar : UIView

@property (assign, nonatomic, readonly) NSInteger selectedIndex;

@property (strong, nonatomic, nullable,) NSArray<WSTabBarItem *> *items;

+ (nonnull instancetype)tabBarWithItems:(nullable NSArray<WSTabBarItem *> *)items itemClick:(nonnull barItemClickBlock) myblock;;

@end
