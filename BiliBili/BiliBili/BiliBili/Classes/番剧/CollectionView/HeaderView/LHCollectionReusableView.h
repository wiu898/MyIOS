//
//  LHCollectionReusableView.h
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHCollectionReusableView : UICollectionReusableView

+(instancetype)collectionHeadWith;

- (void)getADataWithURL;

- (void)getCellDataWithURL;

@end
