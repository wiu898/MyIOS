//
//  PageControl.m
//  UIPageControlText
//
//  Created by 李超 on 15/11/20.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "PageControl.h"

@implementation PageControl

- (void) setBackGroundImage: (UIImageView * ) imageView and:(NSString *)imageNames{

    imageView = [[UIImageView alloc] initWithFrame:self.frame];
    
    [imageView setImage:[UIImage imageNamed:imageNames]];
    
}

@end
