//
//  ColumnViewCell.m
//  DouYU
//
//  Created by 李超 on 16/3/24.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "ColumnViewCell.h"
#import "UIImageView+WebCache.h"

@interface ColumnViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *image;

@property (strong, nonatomic) IBOutlet UILabel *title;

@end

@implementation ColumnViewCell

- (void)reciveDataWith:(ColumnModel *)columnModel{

    [self.image sd_setImageWithURL:[NSURL URLWithString:[columnModel.game_icon stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"Image_no_data.png"]];
    
    self.title.text=columnModel.game_name;
}

@end
