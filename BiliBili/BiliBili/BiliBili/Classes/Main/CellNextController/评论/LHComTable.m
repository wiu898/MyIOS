//
//  LHComTable.m
//  BiliBili
//
//  Created by 李超 on 16/3/30.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHComTable.h"
#import "LHCommCell.h"
#import "LHCommM.h"
#import "LHCommMH.h"
#import "LHDescModel.h"
#import "LHFooterView.h"
#import "LHParam.h"
#import "LHTaCellM.h"
#import "LHTableCellM.h"
#import "YiRefreshFooter.h"
#import "UIKit+AFNetworking.h"
#import "AFNetworking.h"

@interface LHComTable() <UITableViewDataSource,UITableViewDelegate>
{
  
    YiRefreshFooter *refreshFooter;
}

@property (assign, nonatomic) NSInteger page;

@end

@implementation LHComTable

- (NSMutableArray *)arrDict02{

    if (_arrDict02 == nil) {
        _arrDict02 = [NSMutableArray array];
    }
    return _arrDict02;
}

- (void)webDataRequest:(NSString *)param{

    self.page++;
    
    NSString *fan = [NSString stringWithFormat:@"http://api.bilibili.com/feedback?type=jsonp&ver=3&callback=jQuery172019889523880556226_1446769749937&mode=arc&_=1446769758188&page=%zd&aid=%@&pagesize=20&", self.page, param];
    
    NSURL *URL = [NSURL URLWithString:fan];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    UIWebView *web = [[UIWebView alloc] init];
    
    NSProgress *progress = nil;
    
    [web loadRequest:request progress:&progress success:^NSString * _Nonnull(NSHTTPURLResponse * _Nonnull response, NSString * _Nonnull HTML) {
        
        if (HTML != nil) {
            
            self.tableView.sectionFooterHeight = 21;
            
            NSMutableString *str = [NSMutableString stringWithString:HTML];
            
            [str deleteCharactersInRange:NSMakeRange(0, 43)];
            
            [str deleteCharactersInRange:NSMakeRange(str.length - 2, 2)];
            
            NSData *d = [str dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:d options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
            
            NSArray *arr01 = [NSArray arrayWithArray:[dict valueForKey:@"hotList"]];
            
            NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr01.count];
            
            for (NSDictionary *dict in arr01) {
                
                LHCommM *cellM  = [LHCommM cellWithDict:dict];
                
                LHCommMH *cellH = [[LHCommMH alloc] init];
                
                cellH.cellM = cellM;
                
                [arrM addObject:cellH];
            }
            
            self.arrDict = arrM;
            
            NSArray *arr02 = [NSArray arrayWithArray:[dict valueForKey:@"list"]];
            
            for (NSDictionary *dict in arr02) {
                
                LHCommM *cellM = [LHCommM cellWithDict:dict];
                
                LHCommMH *cellH = [[LHCommMH alloc] init];
                
                cellH.cellM = cellM;
                
                [self.arrDict02 addObject:cellH];
            }
            
            [self.tableView reloadData];
            
            [refreshFooter endRefreshing];
        }
        
        return HTML;
        
    } failure:^(NSError * _Nonnull error) {
        
    }];

}

- (void)setCellM:(id)cellM{

    _cellM = cellM;
    
    self.page = 0;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) style:UITableViewStylePlain];
    
    self.tableView = tableView;
    
    [self addSubview:tableView];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 130)];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self webDataRequest:[cellM param]];
    
    __weak typeof(self) weakSelf = self;
    
    refreshFooter = [[YiRefreshFooter alloc] init];
    
    refreshFooter.scrollView = tableView;
    
    [refreshFooter footer];
    
    refreshFooter.beginRefreshingBlock = ^(){
    
        //后台执行
        [weakSelf webDataRequest:[cellM param]];
    };
}

#pragma dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        
        return self.arrDict.count;
    }
    else{
       
        return self.arrDict02.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    LHCommCell *cell = [LHCommCell cellWithTableV:tableView];
    
    if (indexPath.section == 0) {
        cell.cellM = self.arrDict[indexPath.row];
    }else{
        cell.cellM = self.arrDict02[indexPath.row];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    LHFooterView *footView = [LHFooterView footerView];
    
    footView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 21);
    
    if (section == 0) {
        
        return footView;
    }else{
        
        return [[UIView alloc] init];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        return [self.arrDict[indexPath.row] cellH];
    }else{
    
        return [self.arrDict02[indexPath.row] cellH];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.y >= 0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"moveNextTopBar" object:@(scrollView.contentOffset.y)];
    }
}

@end
