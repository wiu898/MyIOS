//
//  WSCommentCell.h
//  WangYiNews
//
//  Created by 李超 on 16/2/25.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSComment;

@interface WSCommentCell : UITableViewCell

@property (strong, nonatomic) WSComment *comment;

+ (instancetype)commentCellWithTableView:(UITableView *)tableView;

@end
