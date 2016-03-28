//
//  NewShow.m
//  DouYU
//
//  Created by 李超 on 16/3/22.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "NewShow.h"

@implementation NewShow

- (id)init{

    self = [[[NSBundle mainBundle] loadNibNamed:@"NewShow" owner:nil options:nil] firstObject];
    
    if (self) {
        
        self.HeadView.layer.cornerRadius=self.HeadView.frame.size.width/2;
        
        self.HeadView.layer.masksToBounds=YES;
    }
    
    return self;
}

@end
