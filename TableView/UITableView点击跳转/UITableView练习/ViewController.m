//
//  ViewController.m
//  UITableView练习
//
//  Created by 李超 on 15/11/16.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

{
    UITableView *tableViews;
    
    NSMutableArray *titleArray;
    
    NSMutableArray *dataArray;
    
    NSMutableArray *dataArray1;
    
    NSMutableArray *dataArray2;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    tableViews = [[UITableView alloc] initWithFrame:CGRectMake(0,0,320,420)];
    
    [tableViews setDelegate:self];
    
    [tableViews setDataSource:self];
    
    [self.view addSubview:tableViews];
    
    titleArray = [[NSMutableArray alloc] initWithObjects:@"国家",@"首都",nil];
    
    dataArray1 = [[NSMutableArray alloc] initWithObjects:@"中国",@"美国",@"英国",nil];
    
    dataArray2 = [[NSMutableArray alloc] initWithObjects:@"北京",@"华盛顿",@"伦敦", nil];
    
    dataArray = [[NSMutableArray alloc] init];
    
    [dataArray addObject:dataArray1];
    
    [dataArray addObject:dataArray2];
}

//分区个数

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [titleArray count];
}

//每个分区多少行

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray[section] count];
}

//每个分区头的数据

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [titleArray objectAtIndex:section];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//绘制Cell

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    //定义cell类型
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]
                initWithFrame:CGRectZero];
    }
    
    [[cell textLabel] setText:[[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    
    return cell;
    
}

//点击事件

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [[dataArray objectAtIndex:indexPath.section ] objectAtIndex:indexPath.row];
    
    NSLog(@"%@",str);
    
    ViewController2 *vc2 = [[ViewController2 alloc] init];
    
    vc2.info = str;
    
    [self.navigationController pushViewController:vc2 animated:YES];
}

//向左滑动删除按钮
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

}


@end
