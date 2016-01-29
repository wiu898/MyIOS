//
//  centerViewController.m
//  主页
//
//  Created by 北京时代华擎 on 15/9/25.
//  Copyright (c) 2015年 iOS _Liu. All rights reserved.
//

#import "centerViewController.h"
#import "TableViewCell.h"
#import "secondTableViewCell.h"
@interface centerViewController ()
{
    NSArray *array;

}
@end

@implementation centerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBarHidden=NO;
    //自定义导航栏
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)];
    UIImage *image = [UIImage imageNamed:@"w_title_bg.png"];
    imageView.image = image;
    imageView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:imageView];
        
    //标签栏
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 320, 40)];
    label.text = @"个人中心";
    label.textColor = [UIColor colorWithRed:0/255.0 green:101.0/255.0 blue:151.0/255.0 alpha:1.0];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    
    
    //产品介绍桌面试图
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65,  [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height - 115) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.hidden = NO;
    self.tableView.tag =202;
    [self.view addSubview:self.tableView];
    
   array=@[@"个人信息",@"我的消息",@"我的收藏",@"联系我们",@"添加电站",@"电桩分享",@"意见反馈"];
}

#pragma mark - UITabelViewDataSource

//返回section的个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}
//每个section中返回cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else
    {
        return 1;
    }
}

//section表头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    int i;
    if (section==0)
    {
        i=10;
    }
    else
    {
        i=1;
    }
    return i;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    int i;
    if (section==0)
    {
        i=10;
    }
    else
    {
        i=5;
    }
    return i;
}


//cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 120;
    }else
    {
        return 65;
    }}

//section下加载cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString *identifier = @"TableViewCell";
        TableViewCell *cell1 =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell1)
        {
            cell1 = [[[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        
        //让cell1点击没有效果
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.headImageView.backgroundColor=[UIColor redColor];
        cell1.headImageView.layer.masksToBounds=YES;
        cell1.headImageView.layer.cornerRadius=50;
        
        return cell1;
    }else{ static NSString *identifier=@"secondTableViewCell";
        secondTableViewCell *cell2=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell2) {
            cell2=[[[NSBundle mainBundle]loadNibNamed:@"secondTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell2.Lable.text=array[indexPath.section-1];
        cell2.Image.backgroundColor=[UIColor redColor];
        return cell2;    }
    return nil;
}


//点击cell后的响应方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.section==1&&indexPath.row==0)//个人信息
    {
        NSLog(@"2");
        [self performSegueWithIdentifier:@"self" sender:nil];
        
    }
     else if (indexPath.section==2&&indexPath.row==0)//我的消息
    {
        NSLog(@"1");

        [self performSegueWithIdentifier:@"information" sender:self];

    }else if (indexPath.section==3&&indexPath.row==0)//意见反馈
    {
        NSLog(@"2");
        [self performSegueWithIdentifier:@"suggested" sender:self];

    }else if (indexPath.section==4&&indexPath.row==0)//我的收藏
    {
        NSLog(@"3");
        [self performSegueWithIdentifier:@"collection" sender:self];


    }
    else if (indexPath.section==5&&indexPath.row==0)//联系我们
    {
        NSLog(@"4");
        [self performSegueWithIdentifier:@"phone" sender:self];


    }
    else if (indexPath.section==6&&indexPath.row==0)//添加电桩
    {
        NSLog(@"5");
        [self performSegueWithIdentifier:@"add" sender:self];


    }
    else if (indexPath.section==7&&indexPath.row==0)//电桩分享
    {
        NSLog(@"6");
        [self performSegueWithIdentifier:@"share" sender:self];


    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
