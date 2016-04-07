//
//  LHTableCellM.h
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHTaCellM;

@interface LHTableCellM : UITableViewCell

@property (nonatomic,strong) LHTaCellM *cellM;

+ (instancetype)cellWithTableV:(UITableView *)table;

@end
