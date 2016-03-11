//
//  BLPFAlertView.m
//  PodTest
//
//  Created by 李超 on 15/12/30.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "BLPFAlertView.h"
#import <UIKit/UIKit.h>

@interface BLPFAlertView()<UIAlertViewDelegate>

@property (nonatomic, copy) PFAlertViewCompletion completion;

@end

@implementation BLPFAlertView

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:(NSArray *)otherButtonTitles
                completion:(PFAlertViewCompletion)completion{
    if ([UIAlertController class] != nil) {
        __block UIAlertController *alertController = [UIAlertController
                alertControllerWithTitle:title
                                 message:message
                          preferredStyle:UIAlertControllerStyleAlert];
        void (^alertActionHandler)(UIAlertAction *) = [^(UIAlertAction * action){
           
            NSUInteger index = [alertController.actions indexOfObject:action];
            completion(index - 1);
            alertController = nil;
        } copy];
        
        [alertController addAction:[UIAlertAction actionWithTitle:cancelButtonTitle
                                                          style:UIAlertActionStyleCancel
                                                          handler:alertActionHandler]];
        for (NSString *buttonTitle in otherButtonTitles) {
            [alertController addAction:[UIAlertAction actionWithTitle:buttonTitle
                                                        style:UIAlertActionStyleDefault
                                                        handler:alertActionHandler]];
        }
        
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        UIViewController *viewController = keyWindow.rootViewController;
        [viewController presentViewController:alertController
            animated:YES completion:nil];
    }else {
        __block BLPFAlertView *pfAlertView = [[self alloc] init];
        UIAlertView *alertView = [[UIAlertView alloc]
            initWithTitle:title
                  message:message
                 delegate:nil
        cancelButtonTitle:cancelButtonTitle
        otherButtonTitles: nil];
        
        for (NSString *buttonTitle in otherButtonTitles) {
            [alertView addButtonWithTitle:buttonTitle];
        }
        
        pfAlertView.completion = ^(NSUInteger indexs){
            if (completion) {
                completion(indexs);
            }
            pfAlertView = nil;
        };
        alertView.delegate = pfAlertView;
        [alertView show];
    }
}

///--------------------------------------
#pragma mark - UIAlertViewDelegate
///--------------------------------------

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.completion) {
        self.completion(buttonIndex - alertView.firstOtherButtonIndex);
    }
}

@end
