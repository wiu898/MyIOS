//
//  ConfirmSubjectOneCell.h
//  PodTest
//
//  Created by 李超 on 16/1/20.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ConfirmSubjectOneCellDelegate <NSObject>

- (void)senderCancelMessage:(NSString *)message;

@end

@interface ConfirmSubjectOneCell : UITableViewCell

@property (weak, nonatomic) id<ConfirmSubjectOneCellDelegate>delegate;

@end
