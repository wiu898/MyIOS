//
//  LHCommCell.h
//  BiliBili
//
//  Created by 李超 on 16/3/30.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHCommMH;

@interface LHCommCell : UITableViewCell

@property (nonatomic, strong) LHCommMH* cellM;

@property (nonatomic, assign) CGFloat cellH;

+ (instancetype)cellWithTableV:(UITableView*)table;

@end
