//
//  LHTwoCell.h
//  BiliBili
//
//  Created by 李超 on 16/3/31.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHSpModel;

@interface LHTwoCell : UIView

@property (nonatomic,strong) LHSpModel *cellM;

+ (instancetype)cellWithTableV;

@end
