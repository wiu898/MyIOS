//
//  LHAtScrollView.h
//  BiliBili
//
//  Created by 李超 on 16/4/6.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHDescModel;

@interface LHAtScrollView : UIView

@property (nonatomic,strong) LHDescModel *cellM;

+ (instancetype)atScrollViewWith;

@end
