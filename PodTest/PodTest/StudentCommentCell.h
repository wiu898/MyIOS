//
//  StudentCommentCell.h
//  PodTest
//
//  Created by 李超 on 16/1/2.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StudentCommentModel;

@interface StudentCommentCell : UITableViewCell

- (void)receiveCommentMessage:(StudentCommentModel *)messageModel;

@end
