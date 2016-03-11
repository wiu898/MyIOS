//
//  BottomMenu.m
//  PodTest
//
//  Created by 李超 on 15/12/4.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "BottomMenu.h"
#import "UIView+CalculateUIView.h"
#import "ToolHeader.h"
#define MENUWIDE 120
#import <SVProgressHUD.h>
//#import "SignUpListViewController.h"
#import "LoginViewController.h"
#import "AccountManager.h"
static CGFloat const kTopMenuDuration = 0.5;

@interface BottomMenu () {
    CGFloat  StartOffset;
}

@property (copy, nonatomic) NSArray *items;
@property (strong, nonatomic) UIScrollView *menuScrollView;
@property (strong, nonatomic) UIView *topMenuView;

@end

@implementation BottomMenu

- (UIScrollView *) menuScrollView{
    if (_menuScrollView ==nil) {
        _menuScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.calculateFrameWithWide, self.calculateFrameWithHeight)];
        _menuScrollView.showsVerticalScrollIndicator = NO;
    }
    return _menuScrollView;
}

- (UIView *) topMenuView{
    if (_topMenuView == nil) {
        _topMenuView = [[UIView alloc] initWithFrame:CGRectMake((kSystemWide/2- 60/2), 0, 60, 3)];
        _topMenuView.backgroundColor = RGBColor(255,102,51);
       
        _topMenuView.layer.masksToBounds = YES;  //遮盖住它之下的layer
        _topMenuView.layer.borderWidth = 1;
        _topMenuView.layer.borderColor = RGBColor(255,102,51).CGColor;
    }
    return _topMenuView;
}

- (id) initWithFrame:(CGRect)frame withItems:(NSArray *)items{
    if(self = [super initWithFrame:frame]){
        _items = items;
        
        StartOffset = kSystemWide/2 - 60/2;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 1;
        self.layer.borderColor = RGBColor(217,217,217).CGColor;
        [self createBottomMenu];
        [self.menuScrollView addSubview:self.topMenuView];
    }
    return  self;
}

- (void) createBottomMenu{
    self.userInteractionEnabled = YES; // 用户触发的事件是否执行
    [self addSubview:self.menuScrollView];
    [_items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel *menuLabel = [[UILabel alloc] init];
        menuLabel.frame = CGRectMake((kSystemWide/2- MENUWIDE/2)+idx*MENUWIDE, 0, MENUWIDE, self.calculateFrameWithHeight);
        menuLabel.textAlignment = NSTextAlignmentCenter;
        UIViewController *vc = (UIViewController *)obj;
        menuLabel.text = vc.title;
        menuLabel.font = [UIFont systemFontOfSize:15];
        if (idx ==0 ) {
            menuLabel.textColor = RGBColor(255,102,51);
        }else{
            menuLabel.textColor = RGBColor(51,51,51);
        }
        menuLabel.tag = 100 + idx;
        
        //手指点击控件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                    action:@selector(dealClick:)];
        menuLabel.userInteractionEnabled = YES;
        [menuLabel addGestureRecognizer:tap];
        [self.menuScrollView addSubview:menuLabel];
    }];
    self.menuScrollView.contentSize = CGSizeMake(kSystemWide+MENUWIDE*_items.count,
                                    self.calculateFrameWithHeight);

}

- (void)dealClick:(UITapGestureRecognizer *)sender{
    NSUInteger index = sender.view.tag - 100;
    
    if (index >=2 && ![AccountManager isLogin]) {
        LoginViewController *login = [[LoginViewController alloc] init];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:nil];
        return;
    }
    
//    if ([[AccountManager manager].userApplystate isEqualToString:@"0"] && index >= 2) {
//     //   SignUpListViewController *signUpList = [[SignUpListViewController alloc] init];
//        UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    //    [nav pushViewController:signUpList animated:YES];
//        return;
//    }
    
    for (id obj in self.menuScrollView.subviews) {
        if ([obj isKindOfClass:[UILabel class]]) {
            UILabel *menuLabel = (UILabel *)obj;
            menuLabel.textColor = RGBColor(51, 51, 51);
        }
    }
    
    UILabel *menuLabel = (UILabel *)sender.view;
    menuLabel.textColor = RGBColor(255, 102, 51);
    
    [self.menuScrollView setContentOffset:CGPointMake(MENUWIDE*index, 0)
        animated:YES];
    
    if ([_delegate respondsToSelector:@selector(horizontalMenuScrollPageIndex:)]) {
        [_delegate horizontalMenuScrollPageIndex:index];
    }
    [UIView animateWithDuration:kTopMenuDuration animations:^{
        self.topMenuView.frame = CGRectMake(StartOffset+(index*MENUWIDE), self.topMenuView.calculateFrameWithY, self.topMenuView.calculateFrameWithWide, self.topMenuView.calculateFrameWithHeight);
    }];

}

- (void)menuScrollWithIndex:(NSUInteger)index {
    
    if (index >= 2 && ![AccountManager isLogin]) {
        
        LoginViewController *login = [[LoginViewController alloc] init];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:nil];
        return;
    }

    
//    if ([[AccountManager manager].userApplystate isEqualToString:@"0"] && index >= 2) {
//        SignUpListViewController *signUpList = [[SignUpListViewController alloc] init];
//        UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//        [nav pushViewController:signUpList animated:YES];
//        return;
//    }
    
    for (id obj in self.menuScrollView.subviews) {
        if ([obj isKindOfClass:[UILabel class]]) {
            UILabel *menuLabel = (UILabel *)obj;
            if (menuLabel.tag-100 == index) {
                menuLabel.textColor = RGBColor(255, 102, 51);
            }else {
                menuLabel.textColor = RGBColor(51, 51, 51);
                
            }
            
        }
    }
    
    [self.menuScrollView setContentOffset:CGPointMake(MENUWIDE*index, 0) animated:YES];
    [UIView animateWithDuration:kTopMenuDuration animations:^{
        self.topMenuView.frame = CGRectMake(StartOffset+(index*MENUWIDE), self.topMenuView.calculateFrameWithY, self.topMenuView.calculateFrameWithWide, self.topMenuView.calculateFrameWithHeight);
    }];
}

@end
