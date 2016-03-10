//
//  WSTopicCell.h
//  WangYiNews
//
//  Created by 李超 on 16/2/29.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WSTopic;

@interface WSTopicCell : UITableViewCell

@property (strong, nonatomic) WSTopic *topic;

+ (CGFloat)rowHeight;

+ (instancetype)topicCellWithTableView:(UITableView *)tableView;

@end
