//
//  WSRollCell.m
//  WangYiNews
//
//  Created by 李超 on 16/2/26.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "WSRollCell.h"
#import "UIImageView+WebCache.h"
#import "WSAds.h"
#import "WSImageView.h"

@interface WSRollCell ()

@property (weak, nonatomic) IBOutlet WSImageView *imageView;

@end

@implementation WSRollCell


- (void)setAd:(WSAds *)ad{
    
    _ad = ad;
    
    self.imageView.contentMode = UIViewContentModeCenter;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:ad.imgsrc] placeholderImage:[UIImage imageNamed:@"cell_image_background"]];
    
}

@end
