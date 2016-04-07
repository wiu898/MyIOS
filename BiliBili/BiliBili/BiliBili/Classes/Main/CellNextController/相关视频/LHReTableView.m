//
//  LHReTableView.m
//  BiliBili
//
//  Created by 李超 on 16/3/30.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHReTableView.h"
#import "LHTaCellM.h"
#import "LHTableCellM.h"
#import "LHDescModel.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

@interface LHReTableView() <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *arrDict;

@end

@implementation LHReTableView

- (void)setCellM:(id)cellM{

    _cellM = cellM;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) style:UITableViewStylePlain];
    
    self.tableView = tableView;
    
    [self addSubview:tableView];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = 78;
    
    self.tableView.bounces = NO;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 130 + 21)];
    
    NSString *url = @"http://comment.bilibili.com/recommend,";
    
    NSString *fan = [url stringByAppendingString:[cellM param]];
    
    [self webDataRequest:fan];
}

//得到web数据
- (void)webDataRequest:(NSString *)url{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *arr = [NSArray arrayWithArray:responseObject];
        
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        
        for (NSDictionary *dict in arr) {
           
            LHTaCellM *cellM = [LHTaCellM cellWithDict:dict];
           
            [arrM addObject:cellM];
        }
        
        self.arrDict = arrM;
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

#pragma mark - delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    LHTableCellM *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%zd%@",[self.cellM rand],[self.cellM title]] object:cell.cellM];
}

#pragma mark - dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        NSLog(@"sssssssssssssssss--------%ld",self.arrDict.count);

    return self.arrDict.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    LHTableCellM *cell = [LHTableCellM cellWithTableV:tableView];
    
    cell.backgroundColor = [UIColor clearColor];

    cell.cellM = self.arrDict[indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.y >= 0) {
        
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"moveNextTopBar" object:@(scrollView.contentOffset.y)];
    }
}

@end
