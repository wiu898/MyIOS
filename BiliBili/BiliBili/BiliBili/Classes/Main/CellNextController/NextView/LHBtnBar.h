//
//  LHBtnBar.h
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHBtnBar : UIView

@property (nonatomic, strong) NSArray* titleArr;

@property (nonatomic, copy) void (^clickBtn)(NSInteger);

@property (nonatomic, weak) UIView* bottomView;

- (void)changeBtnColor:(NSInteger)tagNum;

@end
