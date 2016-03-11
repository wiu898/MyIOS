//
//  BCTextView.h
//  PodTest
//
//  Created by 李超 on 16/1/20.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCTextView : UITextView

@property (strong, nonatomic) UILabel *placeholder;

- (instancetype)initWithFrame:(CGRect)frame
              withPlaceholder:(NSString *)placeholder;

@end
