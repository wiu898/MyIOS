//
//  CoachTableViewCell.h
//  PodTest
//
//  Created by 李超 on 15/12/31.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CoachModel;

@interface CoachTableViewCell : UITableViewCell

- (void)receivedCellModelWith:(CoachModel *)coachModel;

@end
