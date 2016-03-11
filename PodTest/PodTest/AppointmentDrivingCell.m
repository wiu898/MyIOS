//
//  AppointmentDrivingCell.m
//  PodTest
//
//  Created by 李超 on 15/12/29.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "AppointmentDrivingCell.h"
#import "ToolHeader.h"
#import "AppointmentCoachTimeInfoModel.h"
#import "AppointmentCollectionViewCell.h"
#import "BLInformationManager.h"
#import <SVProgressHUD.h>

@interface AppointmentDrivingCell()<UICollectionViewDataSource,
    UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UIScrollView *menuScrollview;
@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) NSIndexPath *firstPath;

@end

@implementation AppointmentDrivingCell

- (NSMutableArray *)upDateArray{
    if (_upDateArray == nil) {
        _upDateArray = [[NSMutableArray alloc] init];
    }
    return _upDateArray;
}

- (NSMutableArray *)dataArray{
    if(_dataArray == nil){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout =
            [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.minimumLineSpacing = 1;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:
            CGRectMake(0, 0, kSystemWide,269-44) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = RGBColor(221, 221, 221);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[AppointmentCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    }
    return _collectionView;
}

- (UIView *)backGroundView{
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
            kSystemWide, 269)];
    }
    return _backGroundView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    [self.contentView addSubview:self.backGroundView];
    [self.backGroundView addSubview:self.collectionView];
}

- (void)receiveCoachTimeData:(NSArray *)coachTimeData{
    
    [self.dataArray removeAllObjects];
    [self.upDateArray removeAllObjects];
    [self.dataArray addObjectsFromArray:coachTimeData];
    
    [self.collectionView reloadData];
    
    DYNSLog(@"count = %ld",self.dataArray.count);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    self.indexPath = nil;
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
    cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString *cellId = @"collectionCell";
    AppointmentCollectionViewCell *cell = [collectionView
        dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];

    if (!cell) {
        DYNSLog(@"创建错误");
    }
    AppointmentCoachTimeInfoModel *model = self.dataArray[indexPath.row];
    [cell receiveCoachTimeInfoModel:model];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
    layout:(UICollectionViewLayout *)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize cellSize = CGSizeMake(kSystemWide/3-1, 75-1);
    return cellSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
    layout:(UICollectionViewLayout *)collectionViewLayout
    insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);

}

- (void)collectionView:(UICollectionView *)collectionView
     didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AppointmentCoachTimeInfoModel *model = self.dataArray[indexPath.row];
    DYNSLog(@"clickModel = %d",model.is_selected);
    
    if(model.is_selected == NO){
        DYNSLog(@"Selected");
        
        if (self.upDateArray.count == 0) {
            AppointmentCollectionViewCell *cell =
              (AppointmentCollectionViewCell *)[collectionView
                 cellForItemAtIndexPath:indexPath];
            cell.startTimeLabel.textColor = MAINCOLOR;
            cell.finalTimeLabel.textColor = MAINCOLOR;
            cell.remainingPersonLabel.textColor = MAINCOLOR;
            model.is_selected = YES;
            
            [self.upDateArray addObject:model];
            [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
            
            [BLInformationManager sharedInstance].appointmentData = self.upDateArray;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kCellChange"
                 object:nil];
            return;
        }
        
        for (AppointmentCoachTimeInfoModel *upDateModel in self.upDateArray) {
            DYNSLog(@"upDateModel = %ld",upDateModel.indexPath);
            if ((model.indexPath +1 == upDateModel.indexPath) ||
                (model.indexPath -1 == upDateModel.indexPath)) {
                AppointmentCollectionViewCell *cell = (AppointmentCollectionViewCell *)
                   [collectionView cellForItemAtIndexPath:indexPath];
                cell.startTimeLabel.textColor = MAINCOLOR;
                cell.finalTimeLabel.textColor = MAINCOLOR;
                cell.remainingPersonLabel.textColor = MAINCOLOR;
                model.is_selected = YES;
                
                [self.upDateArray addObject:model];
                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
                
                [BLInformationManager sharedInstance].appointmentData = self.upDateArray;
                [[NSNotificationCenter defaultCenter]
                   postNotificationName:@"kCellChange" object:nil];
                return;
            }
        }
        [SVProgressHUD showInfoWithStatus:@"请选择连续的时间"];
    }else if (model.is_selected == YES){
        DYNSLog(@"unSelected");
        AppointmentCollectionViewCell *cell = (AppointmentCollectionViewCell *)
          [collectionView cellForItemAtIndexPath:indexPath];
        cell.startTimeLabel.textColor = [UIColor blackColor];
        cell.finalTimeLabel.textColor = [UIColor blackColor];
        cell.remainingPersonLabel.textColor = TEXTGRAYCOLOR;
        model.is_selected = NO;
        [self.upDateArray addObject:model];
        [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
        [BLInformationManager sharedInstance].appointmentData = self.upDateArray;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kCellChange"
            object:nil];
    }

}

@end
