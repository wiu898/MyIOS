//
//  LHCellScroll.m
//  BiliBili
//
//  Created by 李超 on 16/3/30.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHCellScroll.h"
#import "LHDeTable.h"        //视频详情
#import "LHReTableView.h"    //相关视频
#import "LHComTable.h"       //评论
#import "LHDescModel.h"
#import "LHTaCellM.h"

//点击顶部番剧跳转的页面的ScrollView

@implementation LHCellScroll

- (void)setCellM:(id)cellM{

    _cellM = cellM;
    
    self.showsHorizontalScrollIndicator = NO;
    
    self.showsVerticalScrollIndicator = NO;
    
    self.backgroundColor = [UIColor clearColor];
    
    self.bounces = NO;
    
    CGFloat vW = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    for (NSInteger i = 0; i < 3; i++) {
        
        if (i == 0) {    //视频详情
            
            LHDeTable *view = [[LHDeTable alloc] initWithFrame:CGRectMake(vW * i, 0, vW, height)];
            
            view.sortAVs = [self.sortAVs firstObject];
            
            view.desc = [self.sortAVs lastObject];
            
            view.cellM = cellM;
            
            view.backgroundColor = [UIColor clearColor];
            
            [self addSubview:view];
            
        }else if (i == 1) {    //相关视频
        
            LHReTableView *view = [[LHReTableView alloc] initWithFrame:CGRectMake(vW * i, 0, vW, height)];
            
            view.cellM = cellM;
            
            view.backgroundColor = [UIColor clearColor];
            
            self.tableRe = view;
            
            [self addSubview:view];
        
        }else{    //评论
        
            LHComTable *view = [[LHComTable alloc] initWithFrame:CGRectMake(vW * i, 0, vW, height)];
            
            view.cellM = cellM;
            
            view.backgroundColor = [UIColor clearColor];
            
            [self addSubview:view];
        }
    }
    
    self.contentSize = CGSizeMake(3 *vW, 0);
    
    self.pagingEnabled = YES;
}

- (instancetype)initWithCoder:(NSCoder *)coder{

    if (self = [super initWithCoder:coder]) {
        
    }
    return self;
}

- (void)awakeFromNib{

}

@end
