//
//  LHbottomView.m
//  BiliBili
//
//  Created by 李超 on 16/4/6.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHbottomView.h"
#import "LHAtScrollView.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "LHDescModel.h"
#import "LHDescView.h"
#import "LHScrollViewM.h"

@implementation LHbottomView

- (void)awakeFromNib{

    for (NSInteger i = 0; i < 4; i++) {
        
        LHDescView *tv = [LHDescView viewWithNib];
        
        UIView *org = [self viewWithTag:i + 1];
        
        tv.frame = org.bounds;
        
        tv.tag = i + 400;
        
        [org addSubview:tv];
    }
}

- (void)setArrDict:(NSArray *)arrDict{

    _arrDict = arrDict;
    
    [self setCellData];
}

- (void)setCellData{

    for (NSInteger i = 0; i < 4; i++) {
        
        LHDescView *tv = (LHDescView *)[self viewWithTag:i + 400];
        
        tv.testM = self.arrDict[i];
    }
}

+ (instancetype)bottomViewWith{

    return [[[NSBundle mainBundle] loadNibNamed:@"LHbottomView" owner:nil options:nil] lastObject];
}

@end
