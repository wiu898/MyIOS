//
//  JEPhotoPickManger.h
//  PodTest
//
//  Created by 李超 on 15/12/21.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JEPhotoPickManger : NSObject

+ (void)pickPhotofromController:(UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>*)fromController;

@end
