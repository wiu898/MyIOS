//
//  WSVideoCell.h
//  WangYiNews
//
//  Created by 李超 on 16/3/1.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WSVideo;

@interface WSVideoCell : UITableViewCell

@property (strong, nonatomic) WSVideo *video;

+ (instancetype)videoCellWithTableView:(UITableView *)tableView;

+ (CGFloat)rowHeight;

@end
