//
//  LHHistoryController.m
//  BiliBili
//
//  Created by 李超 on 16/3/28.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHHistoryController.h"
#import "LHCellController.h"
#import "LHTableCellM.h"
#import "UIImageView+WebCache.h"
#import "LHDescModel.h"

#define PATH_CELL [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"collection_cell.data"]

#define PATH_HIS [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"his_cell.data"]

@interface LHHistoryController() <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong ,nonatomic) NSMutableArray *arrDict;

@property (strong, nonatomic) NSMutableArray *arrDictSp;

@property (assign, nonatomic) NSInteger count;

@property (weak, nonatomic) IBOutlet UILabel *titelLbl;

@end

@implementation LHHistoryController

- (NSMutableArray *)arrDict{
  
    if (_arrDict == nil) {
        
        if ([self.type isEqualToString:@"coll"]) {
            
            if ([NSKeyedUnarchiver unarchiveObjectWithFile:PATH_CELL]) {
                
                NSMutableDictionary *dictM = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_CELL];
                
                NSMutableArray *arrM = [NSMutableArray array];
                
                [dictM enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    
                    [arrM addObject:obj];
                }];
                
                [arrM sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                    
                    return [[obj2 collTime] compare:[obj1 collTime]];
                }];
                
                _arrDict = arrM;
            }
            else{
            
                _arrDict = [NSMutableArray array];
            }
        }
        else if ([self.type isEqualToString:@"his"]){
        
            if ([NSKeyedUnarchiver unarchiveObjectWithFile:PATH_HIS]) {
                
                NSMutableDictionary *dictM = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_HIS];
                
                NSMutableArray *arrM = [NSMutableArray array];
                
                [dictM enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    
                    [arrM addObject:obj];
                }];
                
                [arrM sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                    
                    return [[obj2 hisTime] compare:[obj1 hisTime]];
                }];
                
                _arrDict = arrM;
            }
            else{
            
                _arrDict = [NSMutableArray array];
            }
        }
    }
    return _arrDict;
}

- (IBAction)slideBtn:(UIButton *)sender{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowSlideView" object:self userInfo:nil];
}

- (IBAction)clearBtn:(UIButton *)sender{

    if ([self.type isEqualToString:@"coll"]) {
        
        if ([NSKeyedUnarchiver unarchiveObjectWithFile:PATH_CELL]) {
            
            NSFileManager *manager = [NSFileManager defaultManager];
            
            [manager removeItemAtPath:PATH_CELL error:nil];
            
            [self.arrDict removeAllObjects];
            
            [self.tableView reloadData];
        }
    }
    else if ([self.type isEqualToString:@"his"]){
    
        if ([NSKeyedUnarchiver unarchiveObjectWithFile:PATH_HIS]) {
            
            NSFileManager *manager = [NSFileManager defaultManager];
            
            [manager removeItemAtPath:PATH_HIS error:nil];
            
            [self.arrDict removeAllObjects];
            
            [self.tableView reloadData];
        }
    }
}

- (void)viewDidLoad{

    [super viewDidLoad];
    
    if ([self.type isEqualToString:@"coll"]) {
        
        self.titelLbl.text = @"我的收藏";
    }
    else if ([self.type isEqualToString:@"his"]){
    
        self.titelLbl.text = @"历史记录";
    }
    
    self.tableView.rowHeight = 80;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //注册观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToRootVC) name:@"popMain" object:nil];
    
    self.count = 0;
}

- (void)popToRootVC{

    [self.navigationController popToRootViewControllerAnimated:YES];
}

//删除观察者
- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return self.arrDict.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    LHTableCellM *cell = [LHTableCellM cellWithTableV:tableView];
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.cellM = self.arrDict[indexPath.row];
    
    return cell;
}

#pragma mark - tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    LHCellController *cellController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"nextView"];
    
    cellController.cellM = self.arrDict[indexPath.row];
    
    self.count = 1;
    
    [self.navigationController pushViewController:cellController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
  
    [super viewWillAppear:animated];
    
    if (self.count == 1) {
        
        self.arrDict = nil;
        
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning{

    [super didReceiveMemoryWarning];
}

@end
