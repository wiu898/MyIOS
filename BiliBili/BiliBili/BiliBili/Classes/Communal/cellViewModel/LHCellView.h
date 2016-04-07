//
//  LHCellView.h
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHCellModel;

@interface LHCellView : UIView

@property (nonatomic,strong) LHCellModel *cellM;

+ (instancetype)viewWithNib;

@end
