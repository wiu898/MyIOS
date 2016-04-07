//
//  LHShopCell.m
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHShopCell.h"
#import "LHShop.h"
#import "UIImageView+WebCache.h"

@interface LHShopCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nameView;

@end

@implementation LHShopCell

-(void)setShop:(LHShop *)shop{
    
    _shop = shop;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:shop.cover]];
    
    self.nameView.text = shop.title;
    
    
}

@end
