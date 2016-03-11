//
//  ExamDetailCell.h
//  PodTest
//
//  Created by 李超 on 16/1/14.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamDetailCell : UITableViewCell

@property (strong, nonatomic) UILabel *schoolLabel;
@property (strong, nonatomic) UILabel *schoolClassLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *studyLabel;
@property (strong, nonatomic) UILabel *featuredTutorials;
@property (strong, nonatomic) UILabel *carType;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *personCount;

- (void)receiveVipList:(NSArray *)list;

@end
