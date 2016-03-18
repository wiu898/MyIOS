//
//  DemoCell.h
//  WaterFlowDemo
//
//  Created by 李超 on 16/3/15.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WaterflowerViewCell.h"

@class WaterflowerView,DemoModel;

@interface DemoCell : WaterflowerViewCell

+ (instancetype) cellWithWaterflower:(WaterflowerView *)waterflowView;

@property (nonatomic, strong) DemoModel *model;

@end
