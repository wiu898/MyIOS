//
//  SliderCell.h
//  DouYU
//
//  Created by 李超 on 16/3/24.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *Small;

@property (strong, nonatomic) IBOutlet UIImageView *Big;

@property (strong, nonatomic) IBOutlet UISlider *Silder;

+(instancetype)GetCellWithTableView:(UITableView *)tableView;

@end
