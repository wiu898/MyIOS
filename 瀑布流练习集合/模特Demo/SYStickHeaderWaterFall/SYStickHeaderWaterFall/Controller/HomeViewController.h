//
//  HomeViewController.h
//  SYStickHeaderWaterFall
//
//  Created by 李超 on 16/3/16.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeViewControllerDelegate <NSObject>

@optional

- (void)leftBtnClicked;

@end

@interface HomeViewController : UIViewController

@property (strong, nonatomic) UIButton *leftBtn;

@property (nonatomic, strong) UIImageView *titleImageView;

@property (nonatomic, weak) id<HomeViewControllerDelegate> delegate;

@property (nonatomic, strong) UIButton *goToTopBtn;

@end
