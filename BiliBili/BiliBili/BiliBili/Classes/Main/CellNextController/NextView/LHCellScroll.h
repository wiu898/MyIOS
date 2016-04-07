//
//  LHCellScroll.h
//  BiliBili
//
//  Created by 李超 on 16/3/30.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHReTableView;

@interface LHCellScroll : UIScrollView

@property (nonatomic,strong) id cellM;

@property (nonatomic,strong) LHReTableView *tableRe;

@property (nonatomic,strong) NSArray *sortAVs;

@end
