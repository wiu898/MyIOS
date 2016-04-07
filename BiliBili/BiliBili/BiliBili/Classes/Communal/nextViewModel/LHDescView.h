//
//  LHDescView.h
//  BiliBili
//
//  Created by 李超 on 16/3/28.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHDescModel;

@interface LHDescView : UIView

@property (nonatomic, strong) LHDescModel* testM;

@property (nonatomic, copy) void (^btnClickWith)(LHDescModel*);

+ (instancetype)viewWithNib;

@end
