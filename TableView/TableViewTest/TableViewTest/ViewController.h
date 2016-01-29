//
//  ViewController.h
//  TableViewTest
//
//  Created by 李超 on 15/11/6.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *DataTable;
    
    NSMutableArray *dataArray1;
    
    NSMutableArray *dataArray2;
    
    NSMutableArray *titleArray;
    
    NSMutableArray *dataArray;  //保存数组的数组
}

@end

