//
//  TanLableCell.m
//  DouYU
//
//  Created by 李超 on 16/3/24.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "TanLableCell.h"

@implementation TanLableCell

+ (instancetype)GetCellWithTableView:(UITableView *)tableView{

    static NSString *TCell=@"TanLableCell";
    
    TanLableCell *cell = [tableView dequeueReusableCellWithIdentifier:TCell];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]
          loadNibNamed:@"TanLableCell" owner:nil options:nil] firstObject];
    }
    
    return cell;
}

@end
