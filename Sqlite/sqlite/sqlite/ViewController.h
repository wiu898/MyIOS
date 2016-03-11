//
//  ViewController.h
//  sqlite
//
//  Created by 李超 on 16/3/10.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ViewController : UIViewController
{
    sqlite3 *db;
}

@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;
@property (assign, nonatomic) double score;
@property (copy, nonatomic) NSString *sex;


@end

