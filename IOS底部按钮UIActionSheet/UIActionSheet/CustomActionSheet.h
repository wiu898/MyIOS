//
//  CustomActionSheet.h
//  UIActionSheet
//
//  Created by 李超 on 15/12/21.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomActionSheet : UIActionSheet

@property (nonatomic, strong)UIView *view;
@property (nonatomic, strong)UIToolbar *toolBar;

- (id)initwithHeight:(float)height WithSheetTitle:(NSString *)title;

@end
