//
//  LHSearchView.h
//  BiliBili
//
//  Created by 李超 on 16/3/30.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHSearchView : UIView

@property (nonatomic,copy) void(^searchBlock)(NSString*);

@property (weak, nonatomic) IBOutlet UITextField* textFieldV;

+ (instancetype)searchView;

@end
