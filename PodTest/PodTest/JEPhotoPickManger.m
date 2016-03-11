//
//  JEPhotoPickManger.m
//  PodTest
//
//  Created by 李超 on 15/12/21.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "JEPhotoPickManger.h"
#import "PFActionSheetView.h"
#import "ToolHeader.h"

@interface JEPhotoPickManger()

@property (weak, nonatomic) UIViewController<UINavigationControllerDelegate,
    UIImagePickerControllerDelegate> *fromVc;

@end

@implementation JEPhotoPickManger

//点击拍照选择,相机或照片

+ (void)pickPhotofromController:(UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate> *)fromController{
    
    [PFActionSheetView showAlertWithTitle:nil message:nil
            cancelButtonTitle:@"取消" otherButtonTitles:@[@"拍照",@"从相册选择"]
            withVc:fromController completion:^(NSUInteger selectOtherButtonIndex) {
                if (selectOtherButtonIndex ==0) {
                    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                        DYNSLog(@"camera");
                        UIImagePickerController *picker = [[UIImagePickerController
                            alloc] init];
                        picker.allowsEditing = YES;
                        picker.delegate = fromController;
                        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                        picker.mediaTypes = [UIImagePickerController
                            availableMediaTypesForSourceType:picker.sourceType];
                        picker.navigationBar.barTintColor = fromController.navigationController
                            .navigationBar.barTintColor;
                        picker.navigationBar.titleTextAttributes =
                        @{NSForegroundColorAttributeName:[UIColor blackColor],
                            NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
                        
                        [fromController presentViewController:picker animated:YES
                            completion:nil];
                    }
                }else if (selectOtherButtonIndex == 1){
                    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                        
                        UIImagePickerController *picker = [[UIImagePickerController
                            alloc] init];
                        picker.allowsEditing = YES;
                        picker.delegate = fromController;
                        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                        picker.mediaTypes = [UIImagePickerController
                            availableMediaTypesForSourceType:picker.sourceType];
                        picker.navigationBar.barTintColor = fromController.navigationController.
                            navigationBar.barTintColor;
                        picker.navigationBar.titleTextAttributes =
                        @{NSForegroundColorAttributeName: [UIColor blackColor],
                            NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
                        
                        [fromController presentViewController:picker
                            animated:YES completion:nil];
                    }
                }
            }];
    
}

@end
