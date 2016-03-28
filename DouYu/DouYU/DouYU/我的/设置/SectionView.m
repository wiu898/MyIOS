//
//  SectionView.m
//  DouYU
//
//  Created by 李超 on 16/3/24.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "SectionView.h"

@implementation SectionView

- (id)init{

    self = [[[NSBundle mainBundle]
       loadNibNamed:@"SectionView" owner:nil options:nil] firstObject];
    
    return self;
}

@end
