//
//  LHFaControllerView.m
//  BiliBili
//
//  Created by 李超 on 16/3/28.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHFaControllerView.h"
#import "LHFaHeader.h"
#import "LHFaheadModel.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

@interface LHFaControllerView() <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableViewFa;

@property (nonatomic, strong) NSArray *arrDict;

@end

@implementation LHFaControllerView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
     
        self.tableViewFa = tableView;
        
        tableView.delegate = self;
        
        tableView.dataSource = self;
        
        [self addSubview:tableView];
        
        LHFaHeader *headView = [LHFaHeader faHeadWith];
        
        headView.frame = CGRectMake(0, 0, frame.size.width, 266);
        
        self.tableViewFa.tableHeaderView = headView;
        
        self.tableViewFa.rowHeight = 44;
        
        self.tableViewFa.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.tableViewFa.backgroundColor = [UIColor clearColor];
        
        self.tableViewFa.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 120)];
        
        [self webDataRequest];
    }
    
    return self;
}

- (void)webDataRequest{
    
    NSURL *URL = [NSURL URLWithString:@"http://app.bilibili.com/api/search_rank.json?_device=android&_hwid=130a7709aeac1793&appkey=c1b107428d337928&build=402003&platform=android&ts=1449759338000&sign=35bb746ed62c2a8fbfc445b09dbe06d7"];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:[NSString stringWithFormat:@"%@",URL] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *arr = [NSArray arrayWithArray:[responseObject valueForKeyPath:@"list"]];
        
        self.arrDict = arr;
        
        [self.tableViewFa reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];

}

#pragma mark - dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.arrDict.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    static NSString *ID = @"facell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"  %zd:  %@",indexPath.item+1,[self.arrDict[indexPath.item] valueForKey:@"keyword"]];
    
    cell.textLabel.textColor = [UIColor colorWithRed:(float)arc4random_uniform(256)/255.0 green:(float)arc4random_uniform(256)/255.0 blue:(float)arc4random_uniform(256)/255.0 alpha:1];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    
    if (scrollView.contentOffset.y>=0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"moveTopBar" object:@(scrollView.contentOffset.y)];
    }
    
}

@end
