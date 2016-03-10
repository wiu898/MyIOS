//
//  WSImageView.m
//  WangYiNews
//
//  Created by 李超 on 16/2/25.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "WSImageView.h"

@implementation WSImageView

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (self.image.size.width < self.bounds.size.width && self.image.size.height < self.bounds.size.height) {
        
        self.contentMode = UIViewContentModeCenter;
    }else if(self.image.size.width >= self.bounds.size.width || self.image.size.height >= self.bounds.size.height){
        
        self.contentMode = UIViewContentModeScaleToFill;
    }
}

@end
