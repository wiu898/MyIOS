//
//  LHDownView.h
//  BiliBili
//
//  Created by 李超 on 16/3/30.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHDownView : UIView

+ (instancetype)downLoadView;

@property (nonatomic,copy) void(^pushBlock)();

@property (nonatomic,strong) id cellM;

@property (nonatomic,strong) NSArray *arrDict;

@end
