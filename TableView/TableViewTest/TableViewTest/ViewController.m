//
//  ViewController.m
//  TableViewTest
//
//  Created by 李超 on 15/11/6.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"first";
    // Do any additional setup after loading the view, typically from a nib.
    
    DataTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, 320, 420)];
    
    [DataTable setDelegate:self];
    
    [DataTable setDataSource:self];
    
    [self.view addSubview:DataTable];
    
    //初始化数组
    
    dataArray1 = [[NSMutableArray alloc] initWithObjects:@"北京",@"上海",@"深圳",nil];
    
    dataArray2 = [[NSMutableArray alloc] initWithObjects:@"中国",@"美国",@"英国",nil];
    
    titleArray = [[NSMutableArray alloc] initWithObjects:@"国家",@"城市", nil];
    
    //初始化dataArray,元素为数组
 //   dataArray = [[NSMutableArray alloc] initWithObjects:dataArray1,dataArray2, nil];
    
     dataArray = [[NSMutableArray alloc] init];
    [dataArray addObject:dataArray2];
    [dataArray addObject:dataArray1];
    
}

//自定义标题

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 40)];
    
    [view setBackgroundColor:[UIColor brownColor]];  //标题背景颜色
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5,10,50,30)];
    
    label.textColor = [UIColor redColor];
    
    label.backgroundColor = [UIColor clearColor];
    
    label.text = [titleArray objectAtIndex:section];
    
    [view addSubview:label];
    
    return view;
}





//- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//
//{
//    return titleArray[section];
//}



//设置标题高度

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}


// 指定分区个数

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [titleArray count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//指定每个分区中的内容多少行

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[dataArray objectAtIndex:section ]count];
}

//绘制Cell

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    }
    
    //取出dataArray中每个分区对应额元素(数组)，并通过其来取值
    [[cell textLabel] setText:[[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    
    return  cell;
}

//改变行高

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

@end
