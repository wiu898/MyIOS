//
//  TanLableCell.h
//  DouYU
//
//  Created by 李超 on 16/3/24.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TanLableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *Example;

+(instancetype)GetCellWithTableView:(UITableView *)tableView;

@end
