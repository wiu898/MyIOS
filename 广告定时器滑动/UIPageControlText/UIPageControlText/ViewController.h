//
//  ViewController.h
//  UIPageControlText
//
//  Created by 李超 on 15/11/20.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIScrollViewDelegate>

{
    UIScrollView *helpScrView;
    UIPageControl *pageControl;
    NSArray *imageNames;
    NSTimer *myTimer;
    int timeCount;

}

@end

