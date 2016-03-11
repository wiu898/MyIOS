//
//  SetupViewController.m
//  PodTest
//
//  Created by 李超 on 15/12/23.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "SetupViewController.h"
#import "ToolHeader.h"
#import "UIDevice+JEsystemVersion.h"
#import "FeedBackViewController.h"

@interface SetupViewController()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation SetupViewController

- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = @[@[@"预约提醒",@"新消息通知"],@[@"关于我们",@"去评分",@"反馈"]];
    }
    return _dataArray;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
            style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGBColor(245, 247, 250);
    }
    return _tableView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"设置";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if ([UIDevice jeSystemVersion] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self.view addSubview:self.tableView];

}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - TabelViewDelegate

//分区底部view
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:
    (NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGBColor(245, 247, 250);
    return view;
}

//分区底部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:
    (NSInteger)section{
    return 20;
}

//分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

//每个分区行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
    (NSInteger)section{
    return [self.dataArray[section] count];
}

//绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
    (NSIndexPath *)indexPath{

    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
             reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        UISwitch *switchControl = [[UISwitch alloc] initWithFrame:
            CGRectMake(0, 0, 45, 20)];
        switchControl.onTintColor = MAINCOLOR;
        cell.accessoryView = switchControl;
    }
    return cell;
}

//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
     (NSIndexPath *)indexPath{

    if (indexPath.section == 1 && indexPath.row == 2) {
        FeedBackViewController *feedBack = [[FeedBackViewController alloc] init];
        [self.navigationController pushViewController:feedBack animated:YES];
    }
}

@end
