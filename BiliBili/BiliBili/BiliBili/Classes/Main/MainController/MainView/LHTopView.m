//
//  LHTopView.m
//  BiliBili
//
//  Created by 李超 on 16/3/28.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHTopView.h"
#import "LHSlideView.h"

@interface LHTopView() <UIScrollViewDelegate>

@property (assign, nonatomic) NSInteger numTag;

@end

@implementation LHTopView

//顶部导航按钮

- (void)setTitleArr:(NSArray *)titleArr{

    _titleArr = titleArr;
    
    UIScreen *scr = [UIScreen mainScreen];
    
    CGFloat btnW = scr.bounds.size.width / 5;
    
    CGFloat btnH = 30;
    
    CGFloat btnY = 80;
    
    for (NSInteger i = 0; i< titleArr.count; i++) {
        
        UIButton *navBtn = [[UIButton alloc] init];
        
        navBtn.frame = CGRectMake(btnW * i, btnY, btnW, btnH);
        
        [navBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        
        [navBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        navBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        navBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        
        navBtn.tag = i + 1;
        
        [navBtn addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:navBtn];
    }
    
    [(UIButton *)[self viewWithTag:1] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.numTag = 1;
    
    UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(12, 111, btnW - 24, 3)];
    
    bottomBar.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
    
    bottomBar.layer.cornerRadius = 1.5;
    
    [self addSubview:bottomBar];
    
    self.bottomView = bottomBar;

}

- (IBAction)slideBtn
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowSlideView" object:self userInfo:nil];
}

- (void)navBtnClick:(UIButton *)btn{

    [self changeBtnColor:btn.tag];
    
    if (self.clickBtn) {
        self.clickBtn(btn.tag);
    }
}

- (void)changeBtnColor:(NSInteger)tagNum{

    if (self.numTag != 0) {
        [(UIButton *)[self viewWithTag:self.numTag] setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    
    [(UIButton*)[self viewWithTag:tagNum] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.numTag = tagNum;
}

@end
