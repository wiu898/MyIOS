//
//  FromValidator.m
//  ImageText图文
//
//  Created by 李超 on 16/2/2.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "FromValidator.h"
#import "PrefixHeader.h"

@implementation FromValidator

+(CGRect)rectWidthAndHeightWithStr:(NSString *)str AndFont:(CGFloat)fontFloat
{
    CGRect fcRect = [str boundingRectWithSize:CGSizeMake(150*Width, 1000*Height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontFloat*Width]} context:nil];
    return fcRect;
}

+(CGRect)rectWidthAndHeightWithStr:(NSString *)str AndFont:(CGFloat)fontFloat
    WithStrWidth:(CGFloat)widh
{
    CGRect fcRect = [str boundingRectWithSize:CGSizeMake(widh*Width, 1000*Height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontFloat*Width]} context:nil];
    return fcRect;
}

+(UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


@end
