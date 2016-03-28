//
//  FirstCell.h
//  DouYU
//
//  Created by 李超 on 16/3/24.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *HeadView;

+(instancetype)GetCellWithTableView:(UITableView *)tableView;

@end
