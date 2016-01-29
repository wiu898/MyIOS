//
//  centerViewController.h
//  主页
//
//  Created by 北京时代华擎 on 15/9/25.
//  Copyright (c) 2015年 iOS _Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface centerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)UITableView *tableView;

@end
