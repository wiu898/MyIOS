//
//  FromValidator.h
//  ImageText图文
//
//  Created by 李超 on 16/2/2.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FromValidator : NSObject

+(UIColor *) randomColor;

+(CGRect)rectWidthAndHeightWithStr:(NSString *)str AndFont:(CGFloat)fontFloat;

+(CGRect)rectWidthAndHeightWithStr:(NSString *)str AndFont:(CGFloat)fontFloat WithStrWidth:(CGFloat)widh;

@end
