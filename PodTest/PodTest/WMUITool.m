//
//  WMUITool.m
//  PodTest
//
//  Created by 李超 on 15/12/17.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "WMUITool.h"


@implementation WMUITool

+ (UILabel *)initWithTextColor:(UIColor *)textColor withFont:(UIFont *)textFont{
    UILabel *wmLabel = [[UILabel alloc] init];
    wmLabel.text = @"";
    wmLabel.font = textFont;
    wmLabel.textColor = textColor;
    return wmLabel;
}

+ (UIButton *)initWithTitle:(NSString *)title withTitleColor:(UIColor *)titleColor withTitleFont:(UIFont *)titleFont{
    UIButton *wmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    wmButton.titleLabel.font = titleFont;
    [wmButton setTitleColor:titleColor forState:UIControlStateNormal];
    [wmButton setTitle:title forState:UIControlStateNormal];
    return wmButton;
}

+ (UIImageView *)initWithImage:(UIImage *)image{
    UIImageView *wmImageView = [[UIImageView alloc] init];
    if (!image) {
        wmImageView.image = image;
    }
    return wmImageView;
}

@end
