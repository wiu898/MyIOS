//
//  FirstCell.m
//  DouYU
//
//  Created by 李超 on 16/3/24.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "FirstCell.h"

@implementation FirstCell

+ (instancetype)GetCellWithTableView:(UITableView *)tableView{

    static NSString *identfire=@"FirstCell";
    
    FirstCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
    
    if (!cell) {
        
        cell=[[[NSBundle mainBundle]
           loadNibNamed:@"FirstCell" owner:nil options:nil] firstObject];
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        cell.HeadView.layer.cornerRadius=65/2;
        
        cell.HeadView.layer.masksToBounds=YES;
    }
    
    return cell;
    
}

@end
