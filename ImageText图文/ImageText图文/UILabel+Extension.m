//
//  UILabel+Extension.m
//  ImageText图文
//
//  Created by 李超 on 16/2/2.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+ (UILabel *)addLabelWithFrame:(CGRect)frame AndText:(NSString *)text AndFont:(CGFloat)font AndAplha:(CGFloat)alpha AndColor:(UIColor *)color{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.alpha = alpha;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = color;
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}

@end
