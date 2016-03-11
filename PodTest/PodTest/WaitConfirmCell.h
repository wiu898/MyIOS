//
//  WaitConfirmCell.h
//  PodTest
//
//  Created by 李超 on 16/1/20.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitConfirmCell : UITableViewCell

//地点
@property (strong, nonatomic) UILabel *courseLocation;

//时间
@property (strong, nonatomic) UILabel *courseLabel;
@property (strong, nonatomic) UILabel *courseProgressLabel;

//课程时间描述
@property (strong, nonatomic) UILabel *courseTime;
//课程进度描述
@property (strong, nonatomic) UILabel *courseProgress;
//接送地点描述
@property (strong, nonatomic) UILabel *courseAddress;

@end
