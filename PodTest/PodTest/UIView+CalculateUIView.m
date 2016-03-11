//
//  UIView+CalculateUIView.m
//  PodTest
//
//  Created by 李超 on 15/12/4.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "UIView+CalculateUIView.h"

@implementation UIView (CalculateUIView)

- (CGFloat) calculateFrameWithX{
    return self.frame.origin.x;
}

- (CGFloat) calculateFrameWithY{
    return self.frame.origin.y;
}

- (CGFloat) calculateFrameWithWide{
    return self.frame.size.width;
}

- (CGFloat) calculateFrameWithHeight{
    return self.frame.size.height;
}

@end
