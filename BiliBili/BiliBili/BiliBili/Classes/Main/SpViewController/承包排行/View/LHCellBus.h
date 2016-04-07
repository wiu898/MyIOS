//
//  LHCellBus.h
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHCellBus : UITableViewCell

@property (nonatomic,strong) NSDictionary *dict;

+ (instancetype)cellWithTableV:(UITableView *)table;

@end
