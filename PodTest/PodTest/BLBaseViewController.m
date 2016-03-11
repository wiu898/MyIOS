//
//  BLBaseViewController.m
//  PodTest
//
//  Created by 李超 on 15/12/2.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "BLBaseViewController.h"
#import <SVProgressHUD.h>
#import <IQKeyboardManager.h>

@interface BLBaseViewController ()

@end

@implementation BLBaseViewController

- (void) viewDidLoad{
    [super viewDidLoad];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    DYNSLog(@"touch");
    [[IQKeyboardManager sharedManager] resignFirstResponder];
}

@end
