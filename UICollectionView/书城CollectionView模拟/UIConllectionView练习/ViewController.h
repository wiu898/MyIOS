//
//  ViewController.h
//  UIConllectionView练习
//
//  Created by 李超 on 15/11/19.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) UICollectionView *collectionView;

@end

