//
//  BLPFAlertView.h
//  PodTest
//
//  Created by 李超 on 15/12/30.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^PFAlertViewCompletion)(NSUInteger selectedOtherButtonIndex);

@interface BLPFAlertView : NSObject

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:(NSArray *)otherButtonTitles
                completion:(PFAlertViewCompletion)completion;

@end
