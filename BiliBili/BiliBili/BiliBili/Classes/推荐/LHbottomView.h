//
//  LHbottomView.h
//  BiliBili
//
//  Created by 李超 on 16/4/6.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHbottomView : UIView

@property (nonatomic, strong) NSArray* arrDict;

@property (weak, nonatomic) IBOutlet UILabel* titleLbl;

+ (instancetype)bottomViewWith;

@end
