//
//  WSNavigationView.h
//  WangYiNews
//
//  Created by 李超 on 16/2/24.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^itemClick)(NSInteger selectedIndex);

@interface WSNavigationView : UIScrollView

@property (assign, nonatomic) NSInteger selectedItemIndex;

@property (assign, nonatomic) NSArray<NSString *> *items;

+ (instancetype)navigationViewWithItems:(NSArray<NSString *> *)items
    itemClick:(itemClick)itemClick;

@end
