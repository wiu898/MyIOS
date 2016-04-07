//
//  LHComSpTable.m
//  BiliBili
//
//  Created by 李超 on 16/3/31.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHComSpTable.h"
#import "LHHeaderView.h"
#import "LHShop.h"

@interface LHComSpTable()

@property (strong, nonatomic) LHHeaderView *head;

@end

@implementation LHComSpTable

- (void)layoutSubviews{
  
    [super layoutSubviews];
}

- (void)setArrSp:(NSArray *)arrSp{

    _arrSp = arrSp;
    
    if (!_head) {
        
        LHHeaderView *headerView = [LHHeaderView headerView];
        
        _head = headerView;
    }
    
    self.head.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    
    self.tableView.tableHeaderView = self.head;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 130)];
    
    __weak typeof(self) weakSelf = self;
    
    self.head.btnClcike = ^(){
    
        [weakSelf showBG];
    };
}

- (void)showBG{

    UIView *backGround = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    backGround.backgroundColor = [UIColor blackColor];
    
    [self.window addSubview:backGround];
    
    backGround.alpha = 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        backGround.alpha = 0.7;
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    [backGround addSubview:btn];
    
    btn.center = backGround.center;
    
    [btn addTarget:self action:@selector(changeTable:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)changeTable:(UIButton *)btn{

    [btn.superview removeFromSuperview];
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    
    if (scrollView.contentOffset.y >= 0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"moveSpTopBar" object:@(scrollView.contentOffset.y)];
    }
}

@end
