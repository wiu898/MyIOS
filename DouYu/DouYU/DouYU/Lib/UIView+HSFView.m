//
//  UIView+HSFView.m
//  DouYU
//
//  Created by 李超 on 16/3/22.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "UIView+HSFView.h"

@implementation UIView (HSFView)

- (CGFloat)x{
  
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x{

    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y
{
    
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y
{
    
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)w
{
    
    return self.frame.size.width;
}

- (void)setW:(CGFloat)w
{
    
    CGRect frame = self.frame;
    frame.size.width = w;
    self.frame = frame;
}

- (CGFloat)h
{
    
    return self.frame.size.height;
}

- (void)setH:(CGFloat)h
{
    
    CGRect frame = self.frame;
    frame.size.height = h;
    self.frame = frame;
}






@end
