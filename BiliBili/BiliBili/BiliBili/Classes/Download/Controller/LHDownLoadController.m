//
//  LHDownLoadController.m
//  BiliBili
//
//  Created by 李超 on 16/3/28.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHDownLoadController.h"
#import "LHASIHTTPRequest.h"
#import "LHDescModel.h"
#import "LHDownCell.h"
#import "LHNetworkQueue.h"
#import "LHRequestDesc.h"
#import "MoviePlayerViewController.h"
#import "NSString+Tools.h"
#import <SystemServices.h>

#define PATH [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"list.data"]

#define SystemSharedServices [SystemServices sharedServices]

#define PATH_HIS [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"his_cell.data"]

@interface LHDownLoadController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView* pressView;

@property (weak, nonatomic) IBOutlet UILabel* numLbl;

@property (weak, nonatomic) IBOutlet UITableView* tableView;

@property (nonatomic, strong) NSMutableArray* arrM;

@property (nonatomic, strong) NSMutableArray* editArr;

@property (nonatomic, strong) LHNetworkQueue* networkQueue;

@property (nonatomic, strong) NSMutableDictionary* dictMHis;

@end

@implementation LHDownLoadController

- (NSMutableDictionary*)dictMHis
{
    
    if (!_dictMHis) {
        _dictMHis = [NSMutableDictionary dictionary];
    }
    return _dictMHis;
}

- (LHNetworkQueue*)networkQueue
{
    
    if (!_networkQueue) {
        
        _networkQueue = [LHNetworkQueue shared];
    }
    
    return _networkQueue;
}

- (NSMutableArray *)arrM{

    if (_arrM == nil) {
        
        NSFileManager *fm = [NSFileManager defaultManager];
        
        if ([fm fileExistsAtPath:PATH]) {
            
            _arrM = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH];
        }
        else{
        
            _arrM = [NSMutableArray array];
            
            [NSKeyedArchiver archiveRootObject:_arrM toFile:PATH];
        }
    }
    return _arrM;
}

- (NSMutableArray *)editArr{
    
    if (_editArr == nil) {
        _editArr = [NSMutableArray array];
    }
    return _editArr;
}

- (IBAction)allSelect:(id)sender{

    for (NSInteger i = 0; i < self.arrM.count; i++) {
        
        LHDownCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
        
        if (!cell.seleBtn.selected) {
            
            [cell seleAction:cell.seleBtn];
        }
    }
}

- (IBAction)delAction:(id)sender{

    NSFileManager *manager = [NSFileManager defaultManager];
    
    for (id requestDesc in self.editArr) {
        
        if (![requestDesc isKindOfClass:[LHRequestDesc class]]) {
            
            continue;
        }
        
        for (LHRequestDesc * request in self.arrM) {
            
            if ([request isEqual:requestDesc]) {
                
                [self.arrM removeObject:request];
                
                break;
            }
        }
        
        if ([manager fileExistsAtPath:[requestDesc destPath]]) {
            
            [manager removeItemAtPath:[requestDesc destPath] error:nil];
        }
        
        if ([manager fileExistsAtPath:[requestDesc tempPath]]) {
            
            [manager removeItemAtPath:[requestDesc tempPath] error:nil];
        }
        
        for (LHASIHTTPRequest *request in self.networkQueue.operations) {
            
            if ([request.request_Key isEqualToString:[requestDesc key]]) {
                
                [request clearDelegatesAndCancel];
                
                break;
            }
        }
    }
    [self.editArr removeAllObjects];
    
    [NSKeyedArchiver archiveRootObject:self.arrM toFile:PATH];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad{

    [super viewDidLoad];
    
    self.numLbl.text = [NSString stringWithFormat:@"主存储:%@ / 可用:%@", [SystemSharedServices diskSpace], [SystemSharedServices freeDiskSpaceinRaw]];
    
    UIView* pregssView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * (1 - [[[SystemSharedServices freeDiskSpaceinRaw] deleStringLastChar] floatValue] / [[[SystemSharedServices diskSpace] deleStringLastChar] floatValue]), self.pressView.bounds.size.height)];
    
    pregssView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:102 / 255.0 blue:144 / 255.0 alpha:1];
    
    [self.pressView addSubview:pregssView];
    
    [self.pressView sendSubviewToBack:pregssView];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.sectionHeaderHeight = 18;
    
    self.tableView.separatorStyle = 0;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    LHRequestDesc *reDescc = self.arrM[section];
    
    UILabel *title = [[UILabel alloc] init];
    
    title.text = [NSString stringWithFormat:@"  %@",[reDescc.cellM title]];
    
    title.font = [UIFont systemFontOfSize:13.0];
    
    title.backgroundColor = [UIColor lightGrayColor];
    
    return title;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.arrM.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    LHDownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"downCell"];
    
    cell.backgroundColor = [UIColor clearColor];
    
    LHRequestDesc *reDescc = self.arrM[indexPath.section];
    
    for (LHASIHTTPRequest *request in self.networkQueue.operations) {
        
        if ([request.request_Key isEqualToString:reDescc.key]) {
            
            cell.request = request;
            
            break;
        }
    }
    
    __weak typeof(self) weakSelf = self;
    
    __weak typeof(cell) weakCell = cell;
    
    cell.deleBlock = ^(LHRequestDesc *requestDesc){
    
        if (requestDesc != nil) {
            
            [weakSelf.editArr addObject:requestDesc];
            
            weakCell.index = weakSelf.editArr.count - 1;
        }
        else{
        
            [weakSelf.editArr replaceObjectAtIndex:weakCell.index withObject:@" "];
        }
    };
    
    cell.palyBlock = ^(id cellM, NSString * URLString, NSString *danmuku){
    
        [weakSelf playAction:cellM and:URLString and:danmuku];
    };
    
    cell.requestDesc = reDescc;
    
    return cell;
}

- (void)playAction:(id)cellM and:(NSString*)URLString and:(NSString*)danmuku
{
    self.view.userInteractionEnabled = NO;
    
    if ([NSKeyedUnarchiver unarchiveObjectWithFile:PATH_HIS]) {
        self.dictMHis = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_HIS];
        if ([self.dictMHis valueForKey:[cellM param]]) {
            
            NSDate* date = [NSDate date];
            
            NSDateFormatter* df = [[NSDateFormatter alloc] init];
            
            df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            
            NSString* dtaeStr = [df stringFromDate:date];
            
            [cellM setHisTime:dtaeStr];
            
            [self.dictMHis removeObjectForKey:[cellM param]];
            
            [self.dictMHis setValue:cellM forKey:[cellM param]];
            
            [NSKeyedArchiver archiveRootObject:self.dictMHis toFile:PATH_HIS];
        }
        else {
            
            NSDate* date = [NSDate date];
            
            NSDateFormatter* df = [[NSDateFormatter alloc] init];
            
            df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            
            NSString* dtaeStr = [df stringFromDate:date];
            
            [cellM setHisTime:dtaeStr];
            
            [self.dictMHis setValue:cellM forKey:[cellM param]];
            
            [NSKeyedArchiver archiveRootObject:self.dictMHis toFile:PATH_HIS];
        }
    }
    
    MoviePlayerViewController* movie = [[MoviePlayerViewController alloc] init];
    
    movie.url = URLString;
    
    movie.danmaku = danmuku;
    
    if (URLString.length) {
        
        if (self.presentedViewController == nil) {
            
            [self presentViewController:movie animated:NO completion:nil];
        }
    }
    else {
        
        self.view.userInteractionEnabled = YES;
    }
}

- (IBAction)popAction:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)dealloc{

    [NSKeyedArchiver archiveRootObject:self.arrM toFile:PATH];
    
    for (LHASIHTTPRequest *request in self.networkQueue.operations) {
        
        [request setDelegate:nil];
        
        [request setDownloadProgressDelegate:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    self.view.userInteractionEnabled = YES;
}

@end
