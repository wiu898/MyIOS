//
//  WMUITool.h
//  PodTest
//
//  Created by 李超 on 15/12/17.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WMUITool : NSObject

+ (UILabel *)initWithTextColor:(UIColor *)textColor withFont:(UIFont *) textFont;

+ (UIButton *)initWithTitle:(NSString *)title
             withTitleColor:(UIColor *)titleColor
              withTitleFont:(UIFont *)titleFont;

+ (UIImageView *)initWithImage:(UIImage *)image;

@end
