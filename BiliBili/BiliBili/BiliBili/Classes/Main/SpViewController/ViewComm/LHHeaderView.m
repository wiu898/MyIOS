//
//  LHHeaderView.m
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHHeaderView.h"

@implementation LHHeaderView

- (IBAction)seleVidoe:(UIButton *)sender {
    
    if (self.btnClcike) {
        self.btnClcike();
    }
    
}

+ (instancetype)headerView{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"LHHeaderView" owner:nil options:nil] lastObject];
}

@end
