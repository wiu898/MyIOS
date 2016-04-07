//
//  LHComTable.h
//  BiliBili
//
//  Created by 李超 on 16/3/30.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHComTable : UIView

@property (nonatomic,strong) id cellM;

@property (nonatomic, weak) UITableView* tableView;

@property (nonatomic, strong) NSArray* arrDict;

@property (nonatomic, strong) NSMutableArray* arrDict02;

- (void)webDataRequest:(NSString*)param;

@end
