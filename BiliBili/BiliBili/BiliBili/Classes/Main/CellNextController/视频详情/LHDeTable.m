//
//  LHDeTable.m
//  BiliBili
//
//  Created by 李超 on 16/3/30.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHDeTable.h"
#import "LHDescModel.h"
#import "LHSortAV.h"
#import "LHTaCellM.h"
#import "LHWebAVPlayer.h"
#import "LHSortCell.h"

@interface LHDeTable() <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) UITableView *tableViewFa;

@end

@implementation LHDeTable

- (void)setCellM:(id)cellM{

    _cellM = cellM;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) style:UITableViewStylePlain];
    
    self.tableViewFa = tableView;
    
    self.tableViewFa.delegate = self;
    
    self.tableViewFa.dataSource = self;
    
    self.tableViewFa.backgroundColor = [UIColor clearColor];
    
    self.tableViewFa.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addSubview:tableView];
}

#pragma mark - datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSInteger num = self.sortAVs.count;
    num ++;
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        
        LHSortCell *cell = [LHSortCell cellWithTableV:tableView];
        
        cell.cellM = self.cellM;
        
        cell.arrDict = self.sortAVs;
        
        cell.backgroundColor = [UIColor clearColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    static NSString *ID = @"facell";
    
    UITableViewCell *cell = [self.tableViewFa dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    if (indexPath.row == 1) {  //描述
        
        cell.textLabel.text = _desc;
        
        cell.selectionStyle = 0;
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    
    cell.textLabel.numberOfLines = 0;
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    CGFloat cellH = 44;
    
    if (indexPath.row == 0) {
        cellH = 77;
    }
    
    if (indexPath.row == 1) {
        
        cellH = [_desc boundingRectWithSize:CGSizeMake(self.bounds.size.width - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:14.0] }
            context:nil].size.height +16;
    }
    return cellH;
}

@end
