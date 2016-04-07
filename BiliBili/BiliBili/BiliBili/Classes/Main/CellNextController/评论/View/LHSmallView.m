//
//  LHSmallView.m
//  BiliBili
//
//  Created by 李超 on 16/3/30.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHSmallView.h"
#import "UIImageView+WebCache.h"
#import "LHCommM.h"

@interface LHSmallView()

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation LHSmallView

+ (instancetype)smallView{

    return [[[NSBundle mainBundle] loadNibNamed:@"LHSmallView" owner:nil options:nil] lastObject];
}

- (void)setDict:(NSDictionary *)dict{

    _dict = dict;
    
    [self.icon sd_setImageWithURL:[dict valueForKey:@"face"] placeholderImage:[UIImage imageNamed:@"bili_default_avatar"]];
    
    self.name.text = [NSString stringWithFormat:@"%@: %@", [dict valueForKey:@"nick"], [dict valueForKey:@"msg"]];
}

@end
