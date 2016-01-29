//
//  UIViewLine.m
//  Demo--登陆界面1-Test
//
//  Created by 李超 on 15/11/9.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "UIViewLine.h"

@implementation UIViewLine

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 0.2);
    
    CGContextBeginPath(context);
    
    [[UIColor grayColor] setStroke];
    
    CGContextMoveToPoint(context, 5, 50);
    
    CGContextAddLineToPoint(context, self.frame.size.width-5, 50);
    
    CGContextAddLineToPoint(context, 150,50);
    
    CGContextStrokePath(context);
    
    CGContextClosePath(context);
    
}
@end
