//
//  DrivingCell.h
//  PodTest
//
//  Created by 李超 on 16/1/13.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DrivingModel;

@interface DrivingCell : UITableViewCell

@property (strong, nonatomic) UILabel *distanceLabel;

- (void)updateAllContentWith:(DrivingModel *)model;

@end
