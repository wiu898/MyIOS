//
//  LHBusTableView.m
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHBusTableView.h"
#import <AFNetworking.h>
#import "LHCellBus.h"
#import "LHParam.h"
#import "UIKit+AFNetworking.h"
#import "LHHeaderView.h"

@interface LHBusTableView() <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray *arrDict;

@property (weak, nonatomic) UITableView *tableView;

@end

@implementation LHBusTableView

- (void)setCellM:(LHParam *)cellM{

    _cellM = cellM;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) style:UITableViewStylePlain];
    
    [self addSubview:tableView];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    self.tableView = tableView;
    
    tableView.bounces = NO;
    
    self.tableView.rowHeight = 60;
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.backgroundColor = [UIColor clearColor];
    
    //http://www.bilibili.com/widget/ajaxGetBP?aid=3426217
    
    NSString* url = [NSString stringWithFormat:@"http://www.bilibili.com/widget/ajaxGetBP?aid=%@", self.cellM.param];
    
    [self webDataRequest:url];
    
    LHHeaderView *headerView = [LHHeaderView headerView];
    
    headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    
    tableView.tableHeaderView = headerView;
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 130 + 25)];
    
    __weak typeof(self) weakSelf = self;
    
    headerView.btnClcike = ^(){
        
        [weakSelf showBG];
    };

}

- (void)webDataRequest:(NSString *)url{

    NSURL *URL = [NSURL URLWithString:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    UIWebView *web = [[UIWebView alloc] init];

    NSProgress *progress = nil;
    
    [web loadRequest:request progress:&progress success:^NSString * _Nonnull(NSHTTPURLResponse * _Nonnull response, NSString * _Nonnull HTML) {
        
        NSMutableString *str = [NSMutableString stringWithString:HTML];
        
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *dict01 = [dict valueForKey:@"list"];
        
        self.arrDict = [NSArray arrayWithArray:
            [dict01 valueForKey:@"list"]];
        
        [self.tableView reloadData];
        
        return HTML;
        
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
}

- (void)showBG{

    UIView *backGround = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    backGround.backgroundColor = [UIColor blackColor];
    
    [self.window addSubview:backGround];
                                  
    backGround.alpha = 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        backGround.alpha = 0.7;
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    [backGround addSubview:btn];
    
    btn.center = backGround.center;
    
    [btn addTarget:self action:@selector(changeTable:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)changeTable:(UIButton *)btn{

    [btn.superview removeFromSuperview];
}

#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return self.arrDict.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    LHCellBus *cell = [LHCellBus cellWithTableV:tableView];
    
    cell.dict = self.arrDict[indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.y >= 0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"moveSpTopBar" object:@(scrollView.contentOffset.y)];
    }
}

@end
