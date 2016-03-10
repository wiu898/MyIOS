//
//  WSRollController.h
//  WangYiNews
//
//  Created by 李超 on 16/2/26.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedItemBlock)(id obj);

@interface WSRollController : UICollectionViewController

@property (strong, nonatomic) NSArray *ads;

-(void)rollControllerWithAds:(NSArray *)ads selectedItem:(SelectedItemBlock)sel;


@end
