//
//  LHDescScroller.m
//  BiliBili
//
//  Created by 李超 on 16/3/31.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHDescScroller.h"
#import "LHOneCell.h"
#import "LHTwoCell.h"
#import "LHThreeCell.h"
#import "LHParam.h"
#import "LHSpModel.h"

@interface LHDescScroller() <UIScrollViewDelegate>

@property (weak, nonatomic) UIScrollView *scrollerView;

@end

@implementation LHDescScroller

- (void)setCellM:(LHSpModel *)cellM{

    _cellM= cellM;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    
    self.scrollerView = scrollView;
    
    scrollView.delegate = self;
    
    scrollView.bounces = NO;
    
    [self addSubview:scrollView];
    
    LHOneCell *oneCell = [LHOneCell cellWithTableV];
    
    oneCell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 68 + 30 + (([UIScreen mainScreen].bounds.size.width - 3 * 10 - 2 * 20) / 10 + 10) * ((self.arrDict.count - 1) / 4) + 8 + ([UIScreen mainScreen].bounds.size.width - 3 * 10 - 2 * 20) / 10);
    
    oneCell.arrDict = self.arrDict;
    
    oneCell.backgroundColor = [UIColor clearColor];
    
    [self.scrollerView addSubview:oneCell];
    
    //oneCell底部分割线
    UIView *bgLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(oneCell.frame), [UIScreen mainScreen].bounds.size.width, 1)];
    
    bgLine.backgroundColor = [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1];
    
    [self.scrollerView addSubview:bgLine];
    
    LHTwoCell *twoCell = [LHTwoCell cellWithTableV];
    
    twoCell.frame = CGRectMake(0, 1 + CGRectGetMaxY(oneCell.frame), [UIScreen mainScreen].bounds.size.width, 16 + 17 + 16 + [self.cellM.evaluate boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20 - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:12.0] } context:nil].size.height + (self.cellM.tags.count / 4 + 1) * 44 + 21 + 16);

    twoCell.cellM = self.cellM;
    
    twoCell.backgroundColor = [UIColor clearColor];
    
    [self.scrollerView addSubview:twoCell];
    
    //twoCell底部分割线
     UIView* bgLineTwo = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(twoCell.frame), [UIScreen mainScreen].bounds.size.width, 1)];
    
    bgLineTwo.backgroundColor = [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1];
    
    [self.scrollerView addSubview:bgLineTwo];
    
    if ((self.cellM.seasons.count-1) > 0) {  //第三部分存在
        
        LHThreeCell* threeCell = [LHThreeCell cellWithTableV];
        
        threeCell.frame = CGRectMake(0, 1 + CGRectGetMaxY(twoCell.frame), [UIScreen mainScreen].bounds.size.width, (self.cellM.seasons.count - 1) > 0 ? ((33 + 12 + ([UIScreen mainScreen].bounds.size.width - 3 * 10 - 2 * 20) / 4 * 1.5 + 21 + 20) * (self.cellM.seasons.count / 4 + 1)) : 0);
        
        threeCell.cellM = self.cellM;
        
        threeCell.backgroundColor = [UIColor clearColor];
        
        [self.scrollerView addSubview:threeCell];
        
        self.scrollerView.contentSize = CGSizeMake(0, CGRectGetMaxY(threeCell.frame) + 250);
    }else{
        
        //第三部分无数据
        
        self.scrollerView.contentSize = CGSizeMake(0, CGRectGetMaxY(twoCell.frame) + 250);
    }
    
    self.scrollerView.showsVerticalScrollIndicator = NO;
}

- (void)layoutSubviews{
  
    [super layoutSubviews];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.y >= 0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"moveSpTopBar" object:@(scrollView.contentOffset.y)];
    }
}

@end
