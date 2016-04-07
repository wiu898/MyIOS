//
//  LHSortCell.h
//  BiliBili
//
//  Created by 李超 on 16/3/30.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHSortCell : UITableViewCell

@property (nonatomic,strong) NSArray *arrDict;

@property (nonatomic,strong) id cellM;

+ (instancetype)cellWithTableV:(UITableView*)table;

@end
