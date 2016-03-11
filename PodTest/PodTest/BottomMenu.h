//
//  BottomMenu.h
//  PodTest
//
//  Created by 李超 on 15/12/4.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BottomMenuDelegate <NSObject>
- (void) horizontalMenuScrollPageIndex:(NSUInteger)index;
@end
@interface BottomMenu : UIView

@property (weak,nonatomic) id<BottomMenuDelegate> delegate;

- (id) initWithFrame:(CGRect)frame withItems:(NSArray *) items;

- (void) menuScrollWithIndex:(NSUInteger) index;

@end
