//
//  WSContainerController.h
//  WangYiNews
//
//  Created by 李超 on 16/2/24.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSContainerController : UIViewController

@property (strong, nonatomic) UIViewController *parentController;

@property (strong, nonatomic) UIColor *navigationBarBackgroundColor;

+ (instancetype)containerControllerWithSubControlers:
    (NSArray<UIViewController *> *)viewControllers
    parentController:(UIViewController *)vc;

@end
