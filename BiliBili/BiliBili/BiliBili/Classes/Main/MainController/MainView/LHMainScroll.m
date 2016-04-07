//
//  LHMainScroll.m
//  BiliBili
//
//  Created by 李超 on 16/3/28.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

//Main中加载五个分区中的主页面，在MainStoryBoard中都是用ScrollView

#import "LHMainScroll.h"
#import "LHDgView.h"
#import "LHSaControllerView.h"
#import "LHFaControllerView.h"
#import "LHAtView.h"
#import "LHCmView.h"

@interface LHMainScroll()

@end

@implementation LHMainScroll

- (instancetype)initWithCoder:(NSCoder *)coder{

    if (self = [super initWithCoder:coder]) {
        
    }
    return self;
}

- (void)awakeFromNib{
    
    //禁止纵向和横向滚动
    self.showsHorizontalScrollIndicator = NO;
    
    self.showsVerticalScrollIndicator = NO;
    
    self.backgroundColor = [UIColor clearColor];
    
    self.bounces = NO;
    
    //ScrollView区域宽度
    CGFloat vW = [UIScreen mainScreen].bounds.size.width;
    
    //遍历顶部五块分区 番剧、推荐、分区、关注、发现
    for (NSInteger i = 0; i < 5; i++) {
        
        //分区
        if (i == 2) {
            
            LHSaControllerView *view = [[LHSaControllerView alloc] initWithFrame:CGRectMake(vW * i, 0, vW,
                [UIScreen mainScreen].bounds.size.height)];
            
            view.backgroundColor = [UIColor clearColor];
            
            [self addSubview:view];
        
        //发现
        }else if( i == 4){
        
            LHFaControllerView *view = [[LHFaControllerView alloc] initWithFrame:CGRectMake(vW * i, 0, vW, [UIScreen mainScreen].bounds.size.height)];
            
            view.backgroundColor = [UIColor clearColor];
            
            [self addSubview:view];
        
        //关注
        }else if (i == 3){
        
            LHAtView *view = [[LHAtView alloc] initWithFrame:CGRectMake(vW * i, 0, vW, [UIScreen mainScreen].bounds.size.height)];
            
            view.backgroundColor = [UIColor clearColor];
            
            [self addSubview:view];
        
        //推荐
        }else if (i == 1){
        
            LHCmView *view = [[LHCmView alloc] initWithFrame:CGRectMake(vW * i, 0, vW, [UIScreen mainScreen].bounds.size.height)];
            
            view.backgroundColor = [UIColor clearColor];
            
            [self addSubview:view];
        
        //番剧
        }else{
        
            LHDgView *view = [[LHDgView alloc] initWithFrame:CGRectMake(vW * i, 0, vW, [UIScreen mainScreen].bounds.size.height)];
            
            view.backgroundColor = [UIColor clearColor];
            
            [self addSubview:view];
        }
    }
    
    self.contentSize = CGSizeMake(5 * vW, 0);
    
    self.pagingEnabled = YES;
}

@end
