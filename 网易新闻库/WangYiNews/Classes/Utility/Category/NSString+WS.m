//
//  NSString+WS.m
//  WangYiNews
//
//  Created by 李超 on 16/2/24.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "NSString+WS.h"

@implementation NSString (WS)

/*NSString对象方法，用于计算字符串显示成文本的尺寸.
size:用于计算文本绘制时占据的矩形块,size其实就是显示成文本的尺寸。size.w可以是屏幕宽度，size.y可以使无限大MAXFLOAT以显示所有文字内容
optio:绘制文本的附加选项
attributes:将文本UIFONT存入字典传到这里
context:上下文.包括一些信息，例如调整文字间距，缩放等
 */
- (CGSize)sizeOfFont:(UIFont *)font textMaxSize:(CGSize)maxSize{
    
    return [self boundingRectWithSize:maxSize
        options:NSStringDrawingUsesLineFragmentOrigin
        attributes:@{NSFontAttributeName : font} context:nil].size;
}

@end
