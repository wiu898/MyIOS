//
//  LHHeaderView.h
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *numLbl;

+ (instancetype) headerView;

@property (nonatomic,copy) void(^btnClcike)();

@end
