//
//  UILabel+Extension.h
//  ImageText图文
//
//  Created by 李超 on 16/2/2.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

+ (UILabel *)addLabelWithFrame:(CGRect)frame AndText:(NSString *)text
     AndFont:(CGFloat)font AndAplha:(CGFloat)alpha
     AndColor:(UIColor *)color;

@end
