//
//  CommentCell.h
//  PodTest
//
//  Created by 李超 on 16/1/20.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingBar.h"

@protocol CommentCellDelegate <NSObject>

- (void)senderStarProgress:(CGFloat)newProgress withIndex:(NSIndexPath *)indexPath;

@end

@interface CommentCell : UITableViewCell<RatingBarDelegate>

@property (strong, nonatomic) RatingBar *starBar;
@property (strong, nonatomic) UILabel *topLabel;
@property (weak, nonatomic) id<CommentCellDelegate>delegate;

- (void)receiveIndex:(NSIndexPath *)indexPath;

@end
