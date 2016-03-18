//
//  ViewController.m
//  JLWaterfallFlow
//
//  Created by 李超 on 16/3/16.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "ViewController.h"
#import "JLCollectionReusableView.h"
#import "JLCollectionViewCell.h"
#import "JLWaterfallFlowLayout.h"
#import "JLViewModel.h"
#import "DataModel.h"

#define CELLBOTTOMHEIGHT 30; //item底部高度

@interface ViewController ()<JLWaterfallFlowLayoutDelegate,
    UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *JLCollectionView;

@property (strong, nonatomic) JLViewModel *viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configCollectionView];
    
    self.viewModel = [[JLViewModel alloc] init];
    [self.viewModel getData];
    
    [self.JLCollectionView reloadData];
}

- (void)configCollectionView{

    JLWaterfallFlowLayout *waterfallFlowLayout = [[JLWaterfallFlowLayout alloc] init];
    waterfallFlowLayout.itemSpacing = 10; //间距
    waterfallFlowLayout.lineSpacing = 10; //间距
    waterfallFlowLayout.colCount = 3;   //列数
    //试图边界
    waterfallFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    waterfallFlowLayout.delegate = self;
    self.JLCollectionView.collectionViewLayout = waterfallFlowLayout;
    self.JLCollectionView.dataSource = self;
    self.JLCollectionView.delegate = self;
    
    //注册cell以及页眉页脚
    
//    [self.JLCollectionView registerClass:[JLCollectionViewCell class] forCellWithReuseIdentifier:@"JLCollectionViewCell"];

    [self.JLCollectionView registerNib:[UINib nibWithNibName:@"JLCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"JLCollectionViewCell"];
    [self.JLCollectionView registerNib:[UINib nibWithNibName:@"JLCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader"];
    [self.JLCollectionView registerNib:[UINib nibWithNibName:@"JLCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"sectionFooter"];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return self.viewModel.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  
    return [self.viewModel.dataArray[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    JLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JLCollectionViewCell" forIndexPath:indexPath];
    cell.bottomHeight.constant = CELLBOTTOMHEIGHT;
    [cell setCellData:self.viewModel.dataArray[indexPath.section][indexPath.item]];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        JLCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader" forIndexPath:indexPath];
        headerView.titleLa.text = [NSString stringWithFormat:@"header%@", self.viewModel.nameArray[indexPath.section]];
        return headerView;
    }
    else {
        JLCollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"sectionFooter" forIndexPath:indexPath];
        footerView.titleLa.text = [NSString stringWithFormat:@"footer%@", self.viewModel.nameArray[indexPath.section]];
        return footerView;
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"%zi--%zi",indexPath.section,indexPath.item);
}

#pragma mark - JLWaterfallFlowLayoutDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(JLWaterfallFlowLayout *)collectionViewLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{

    DataModel *model = self.viewModel.dataArray[indexPath.section][indexPath.item];
    return model.h/model.w * width + CELLBOTTOMHEIGHT;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(JLWaterfallFlowLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(self.view.frame.size.width - 20, 20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(JLWaterfallFlowLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{

    return CGSizeMake(self.view.frame.size.width - 20, 20);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
