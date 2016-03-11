//
//  ConfirmSubjectTwoCell.h
//  PodTest
//
//  Created by 李超 on 16/1/20.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ConfirmSubjectTwoCellDelegate <NSObject>

- (void)senderCancelMessage:(NSString *)message;

@end

@interface ConfirmSubjectTwoCell : UITableViewCell

@property (weak, nonatomic) id<ConfirmSubjectTwoCellDelegate>delegate;

@end
