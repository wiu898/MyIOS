//
//  LHScrollViewM.m
//  BiliBili
//
//  Created by 李超 on 16/4/6.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHScrollViewM.h"
#import "LHDescModel.h"
#import "LHAtScrollView.h"

@interface LHScrollViewM()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (assign ,nonatomic) NSInteger count;

@end

@implementation LHScrollViewM

- (void)setArrDict:(NSArray *)arrDict{

    _arrDict = arrDict;
    
    if (self.count != arrDict.count) {
        
        self.scrollView.backgroundColor = [UIColor clearColor];
        
        CGFloat margin = 20;
        
        //每个cell的宽度
        CGFloat viewW = ([UIScreen mainScreen].bounds.size.width - 4 * margin) / 3;
        
        CGFloat viewH = [UIScreen mainScreen].bounds.size.height;
        
        for (NSInteger i = 0; i < arrDict.count; i++) {
            
            LHAtScrollView *view  = [LHAtScrollView atScrollViewWith];
            
            view.frame = CGRectMake((viewW + margin) * i + margin, 0, viewW, viewH);
            
            view.tag = i + 202;
            
            view.backgroundColor = [UIColor whiteColor];
            
            [self.scrollView addSubview:view];
        }
        
        self.scrollView.contentSize = CGSizeMake((viewW + margin) * (self.arrDict.count) + margin, 0);
        
        self.scrollView.showsVerticalScrollIndicator = NO;
        
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
        self.scrollView.bounces = NO;
        
        self.count = arrDict.count;
    }
    [self setCellData];
}

- (void)setCellData{

    for (NSInteger i = 0; i < self.arrDict.count; i++) {
        
        LHAtScrollView *view = (LHAtScrollView *)[self viewWithTag:i + 202];
        
        view.cellM = self.arrDict[i];
    }
}

+ (instancetype)scrollViewM{

    return [[[NSBundle mainBundle] loadNibNamed:@"LHScrollViewM" owner:nil options:nil] lastObject];
}

@end
