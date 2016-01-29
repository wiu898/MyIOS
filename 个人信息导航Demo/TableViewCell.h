//
//  TableViewCell.h
//  personCenter
//
//  Created by 北京时代华擎 on 15/9/24.
//  Copyright (c) 2015年 iOS _Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *rankLable;
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end
