//
//  SliderCell.m
//  DouYU
//
//  Created by 李超 on 16/3/24.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "SliderCell.h"

@implementation SliderCell

+ (instancetype)GetCellWithTableView:(UITableView *)tableView{

    static NSString *sliderCell=@"SliderCell";
    
    SliderCell *cell = [tableView dequeueReusableCellWithIdentifier:sliderCell];
    
    if (!cell) {
       
        [[[NSBundle mainBundle]
           loadNibNamed:@"SliderCell" owner:nil options:nil] firstObject];
    }
    
    return cell;
}

@end
