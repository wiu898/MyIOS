//
//  BaseContainViewController.h
//  PodTest
//
//  Created by 李超 on 15/12/4.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBaseViewController.h"

@protocol BaseContainViewControllerDelegate <NSObject>

- (void) horizontalScrollPageIndex:(NSUInteger) index;

@end
@interface BaseContainViewController :BLBaseViewController

@property (weak, nonatomic) id<BaseContainViewControllerDelegate>delegate;
- (id)initWIthChildViewControllerItems:(NSArray *)itemsVc;
- (void)replaceVcWithIndex:(NSUInteger)index;
@end
