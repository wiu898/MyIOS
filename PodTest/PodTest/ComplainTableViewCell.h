//
//  ComplainTableViewCell.h
//  PodTest
//
//  Created by 李超 on 16/1/25.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ComplainTableViewCellDelegate <NSObject>

- (void)senderCancelMessage:(NSString *)message;

@end

@interface ComplainTableViewCell : UITableViewCell

@property (weak, nonatomic) id<ComplainTableViewCellDelegate>delegate;

@end
