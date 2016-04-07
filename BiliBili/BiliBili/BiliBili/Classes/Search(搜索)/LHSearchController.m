//
//  LHSearchController.m
//  BiliBili
//
//  Created by 李超 on 16/3/28.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHSearchController.h"
#import <AFNetworking.h>
#import "LHCellController.h"
#import "LHSearchView.h"
#import "LHTaCellM.h"
#import "LHTableCellM.h"
#import "NSDictionary+Tools.h"
#import "NSString+Tools.h"
#import "YiRefreshFooter.h"
#import <UIKit+AFNetworking.h>

@interface LHSearchController() <UITableViewDataSource,UITableViewDelegate>
{

    YiRefreshFooter *refreshFooter;
    
}

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) LHSearchView *searchView;

@property (strong, nonatomic) NSMutableArray *arrDict;

@property (weak, nonatomic) UITableView *tableView;

@property (assign, nonatomic) NSInteger page;

@end

@implementation LHSearchController

- (NSMutableArray *)arrDict{

    if (_arrDict == nil) {
        _arrDict = [NSMutableArray array];
    }
    return _arrDict;
}

- (void)setCellData{

    self.page++;
    
    NSString *rest = [self.keyWord URLEncodedString:self.keyWord];
    
    NSDictionary *dict = @{@"keyword" : rest};
    
    NSMutableDictionary *mdic = [dict mutableCopy];
    
    mdic[@"_device"] = @"android";
    mdic[@"_hwid"] = @"831fc7511fa9aff5";
    mdic[@"appkey"] = @"85eb6835b0a1034e";
    mdic[@"bangumi_num"] = @"1";
    mdic[@"build"] = @"408005";
    mdic[@"main_ver"] = @"v3";
    mdic[@"page"] = [NSString stringWithFormat:@"%zd", self.page];
    mdic[@"pagesize"] = @"20";
    mdic[@"platform"] = @"android";
    mdic[@"search_type"] = @"all";
    mdic[@"source_type"] = @"0";
    mdic[@"special_num"] = @"1";
    mdic[@"topic_num"] = @"1";
    mdic[@"upuser_num"] = @"1";
    
    NSString* basePath = [mdic appendGetSortParameterWithSignWithBasePath:@"http://api.bilibili.cn/search?"];
    
    NSURL *URL = [NSURL URLWithString:basePath];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    UIWebView *webView = [[UIWebView alloc] init];
    
    NSProgress *progress = nil;
    
    [webView loadRequest:request progress:&progress success:^NSString * _Nonnull(NSHTTPURLResponse * _Nonnull response, NSString * _Nonnull HTML) {
        
        if (HTML != nil) {
            
            NSMutableString *str = [NSMutableString stringWithString:HTML];
            
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
            
            NSArray *arr = [NSArray arrayWithArray:[[dict valueForKey:@"result"] valueForKey:@"video"]];
            
            for (NSDictionary *dict in arr) {
                
                LHTaCellM *cellM = [LHTaCellM cellWithDict:dict];
                
                [self.arrDict addObject:cellM];
            }
            
            [self.tableView reloadData];
            
            [refreshFooter endRefreshing];
        }
        return HTML;
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (IBAction)g2Back:(id)sender{

    [self.searchView removeFromSuperview];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)searchBtn:(id)sender{

    LHSearchView *searchView = [LHSearchView searchView];
    
    self.searchView = searchView;
    
    searchView.frame = self.view.bounds;
    
    searchView.alpha = 0;
    
    [self.view addSubview:searchView];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        searchView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        searchView.alpha = 1;
        
        searchView.textFieldV.text = self.keyWord;
        
        [self.view bringSubviewToFront:searchView];
    }];
    
    __weak typeof(self) weakSelf = self;
    
    searchView.searchBlock = ^(NSString *key){
    
        LHSearchController *seaC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"search"];
        
        seaC.keyWord = key;
        
        [weakSelf.navigationController pushViewController:seaC animated:YES];
    };
}

- (void)viewDidLoad{

    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44+16, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 44 - 16) style:UITableViewStylePlain];
    
    self.tableView = tableView;

    [self.view addSubview:tableView];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.rowHeight = 78;
    
    tableView.separatorStyle = 0;
    
    tableView.backgroundColor = [UIColor clearColor];
    
    self.titleLbl.text = self.keyWord;
    
    self.page = 0;
    
    [self setCellData];
    
    __weak typeof(self) weakSelf = self;
    
    refreshFooter = [[YiRefreshFooter alloc] init];
    
    refreshFooter.scrollView = tableView;
    
    [refreshFooter footer];
    
    refreshFooter.beginRefreshingBlock = ^(){
    
        [weakSelf setCellData];
    };
}

- (void)didReceiveMemoryWarning{

    [super didReceiveMemoryWarning];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    LHCellController *cellController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"nextView"];
    
    cellController.cellM = self.arrDict[indexPath.row];
    
    [self.navigationController pushViewController:cellController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.arrDict.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    LHTableCellM *cell = [LHTableCellM cellWithTableV:tableView];
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.cellM = self.arrDict[indexPath.row];
    
    return cell;
}

@end
