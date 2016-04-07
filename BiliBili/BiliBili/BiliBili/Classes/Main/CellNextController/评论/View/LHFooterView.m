//
//  LHFooterView.m
//  BiliBili
//
//  Created by 李超 on 16/3/30.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHFooterView.h"

@implementation LHFooterView

+ (instancetype)footerView{

    return [[[NSBundle mainBundle] loadNibNamed:@"LHFooterView" owner:nil options:nil] lastObject];
}

@end
