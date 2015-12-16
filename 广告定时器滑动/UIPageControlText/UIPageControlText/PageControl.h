//
//  PageControl.h
//  UIPageControlText
//
//  Created by 李超 on 15/11/20.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageControl : UIView

@property(nonatomic,strong) UIScrollView *scrollView;

@property(nonatomic,strong) UIPageControl *pageControl;

@property(nonatomic,strong) UIImageView *imageView1;

@property(nonatomic,strong) UIImageView *imageView2;

@property(nonatomic,strong) UIImageView *imageView3;

@property(nonatomic,strong) UIImageView *imageView4;

- (void) setBackGroundImage :(UIImageView *) imageView and: (NSString *)imageNames;

@end
