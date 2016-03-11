//
//  PFActionSheetView.m
//  PodTest
//
//  Created by 李超 on 15/12/21.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFActionSheetView.h"

@interface PFActionSheetView()<UIActionSheetDelegate>

@property (copy, nonatomic) PFActionSheetViewCompletion completion;

@end

@implementation PFActionSheetView

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:(NSArray *)otherButtonTitles
                    withVc:(UIViewController *)vc
                completion:(PFActionSheetViewCompletion)completion
{
    if ([UIAlertController class] !=nil) {
        __block UIAlertController *alertController = [UIAlertController
            alertControllerWithTitle:title
                            message:message
                            preferredStyle:UIAlertControllerStyleActionSheet];
        
        void(^alertActionHandler)(UIAlertAction *) = [^(UIAlertAction *action){
        
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
        [viewController presentViewController:alertController animated:YES completion:nil];
    }else{
        __block PFActionSheetView *pfAlertView = [[self alloc] init];
        
        //IOS弹出的选择按钮项
        UIActionSheet *alertView = [[UIActionSheet alloc] initWithTitle:title
            delegate:nil cancelButtonTitle:cancelButtonTitle
            destructiveButtonTitle:message otherButtonTitles:nil];
        
        for (NSString *buttonTitle in otherButtonTitles) {
            [alertView addButtonWithTitle:buttonTitle];
        }
        
        pfAlertView.completion = ^(NSUInteger index){
            if (completion) {
                completion(index);
            }
            pfAlertView = nil;
        };
        
        alertView.delegate = pfAlertView;
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        UIViewController *viewController = keyWindow.rootViewController;
        [alertView showInView:viewController.view];
    }
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet
        clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(self.completion){
        self.completion(buttonIndex - actionSheet.firstOtherButtonIndex);
    }

}


@end
