//
//  LHSlideView.h
//  BiliBili
//
//  Created by 李超 on 16/3/28.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHSlideView : UIView

@property (nonatomic,strong) UIView *shadeView;

@property (nonatomic,copy) void(^showSlide)();

@property (nonatomic,copy) void(^pushBlock)(UIViewController*);

+ (instancetype)slideViewWith;

@end
