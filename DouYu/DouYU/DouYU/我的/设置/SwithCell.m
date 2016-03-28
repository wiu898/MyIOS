//
//  SwithCell.m
//  DouYU
//
//  Created by 李超 on 16/3/24.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "SwithCell.h"

@implementation SwithCell

+ (instancetype)GetCellWithTableView:(UITableView *)tableView{

    static NSString *swithCell=@"SwithCell";
    
    SwithCell *cell = [tableView dequeueReusableCellWithIdentifier:swithCell];
    
    if (!cell) {
        
        [[[NSBundle mainBundle]
            loadNibNamed:@"SwithCell" owner:nil options:nil] firstObject];
    }
    
    return cell;
}

@end
