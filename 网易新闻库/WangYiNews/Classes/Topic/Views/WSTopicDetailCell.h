//
//  WSTopicDetailCell.h
//  WangYiNews
//
//  Created by 李超 on 16/2/29.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WSTopicDetail;

@interface WSTopicDetailCell : UITableViewCell

@property (strong, nonatomic) WSTopicDetail *topicDetail;

+ (instancetype)topicDetalWithTableView:(UITableView *)tableView;

@end
