//
//  MyReservationCell.h
//  PodTest
//
//  Created by 李超 on 16/1/22.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolHeader.h"

@class MyAppointmentModel;

@interface MyReservationCell : UITableViewCell

- (void)receiveDataModel:(MyAppointmentModel *)myModel;

@end
