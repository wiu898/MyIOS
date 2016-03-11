//
//  CancelAppointmentCell.h
//  PodTest
//
//  Created by 李超 on 16/1/21.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CancelAppointmentCellDelegate <NSObject>

- (void)senderCancelMessage:(NSString *)message;

@end

@interface CancelAppointmentCell : UITableViewCell

@property (weak, nonatomic) id<CancelAppointmentCellDelegate>delegate;

@end
