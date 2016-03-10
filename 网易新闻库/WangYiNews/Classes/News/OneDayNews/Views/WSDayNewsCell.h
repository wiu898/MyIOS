//
//  WSDayNewsCell.h
//  WangYiNews
//
//  Created by 李超 on 16/2/29.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSNews;

@interface WSDayNewsCell : UITableViewCell

@property (strong, nonatomic) WSNews *news;

+ (instancetype)dayNewsCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

+ (CGFloat)rowHeightWithIndexPath:(NSIndexPath *)indexPath;

@end
