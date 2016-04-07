//
//  LHTopView.h
//  BiliBili
//
//  Created by 李超 on 16/3/28.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHTopView : UIView

@property (nonatomic, strong) NSArray* titleArr;

@property (nonatomic, copy) void (^clickBtn)(NSInteger);

@property (nonatomic, copy) void (^clickSlideBtn)();

@property (nonatomic, weak) UIView* bottomView;

- (void)changeBtnColor:(NSInteger)tagNum;

@end
