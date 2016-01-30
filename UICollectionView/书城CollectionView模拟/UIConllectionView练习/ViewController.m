//
//  ViewController.m
//  UIConllectionView练习
//
//  Created by 李超 on 15/11/19.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewController.h"
#import "SecondController.h"
#import "MyHeaderView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"first";
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置行距
    flowLayout.minimumLineSpacing = 20.0f;
    
    //设置内部距离
    flowLayout.minimumInteritemSpacing = 5.0f;
   
    //确定是水平滚动还是垂直滚动
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    
    self.collectionView.dataSource = self;
    
    self.collectionView.delegate = self;
    
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    //注册cell,必须要有
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    //注册页眉和页脚
    [self.collectionView registerClass:[MyHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"hxwHeader"];
    
    [self.collectionView registerClass:[MyHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"hxwFooter"];
    
    [self.view addSubview:self.collectionView];
    
}

//定义展示的UICollectionViewCell的个数
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

//定义展示的Section的个数
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

//每个UIcollectionView展示的内容,绘制cell
- (UICollectionViewCell *) collectionView:(UICollectionView *) collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{

   static NSString *CellIdentifier = @"UICollectionViewCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.frame];
    
    [imageView setImage:[UIImage imageNamed:@"1.jpeg"]];
    
    [cell setBackgroundView:imageView];
    
    cell.backgroundColor = [UIColor colorWithRed:((10*indexPath.row)/255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    label.textColor = [UIColor redColor];
    
    label.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    
    for (id subView in cell.contentView.subviews) {
        
        [subView removeFromSuperview];
    }
    
    [cell.contentView addSubview:label];
    
    return  cell;
    
}

//定义每个Item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake(85, 127);

}


//定义每个UICollectionView的Margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{

    return UIEdgeInsetsMake(10, 17, 8, 17);

}

//UicollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    //临时改变颜色
    cell.backgroundColor = [UIColor greenColor];
    
    NSLog(@"item====%ld",indexPath.item);
    NSLog(@"row====%ld",indexPath.item);
    NSLog(@"section==%ld",indexPath.section);
    
    SecondController *second = [[SecondController alloc] init];
    
    second.title = @"second";
    
    [self.navigationController pushViewController:second animated:YES];

}

//返回这个UICollectionView是否可被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    return YES;

}

//页眉页脚设置
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
 //   UICollectionReusableView *result = nil;
    
    MyHeaderView *headView = nil;

    if(kind == UICollectionElementKindSectionHeader){
    
        
//       headView =  [collectionView supplementaryViewForElementKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        
        headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"hxwHeader" forIndexPath:indexPath];
        NSLog(@"headview = %@",headView);
        headView.backgroundColor = [UIColor cyanColor];
        
        [headView setLabelText:[NSString stringWithFormat:@"section %ld's header",indexPath.section]];
        
        [headView setBackgroundImage:@"side.jpg"];
    
        return headView;
        
    }
    
    else if (kind == UICollectionElementKindSectionFooter) {
        
       headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"hxwFooter" forIndexPath:indexPath];
    
        headView.backgroundColor = [UIColor cyanColor];
        
        [headView setLabelText:[NSString stringWithFormat:@"section %ld's footer",indexPath.section]];
        
        [headView setBackgroundImage:@"side.jpg"];
        
        return headView;

    }
    
    return headView;

}

//设置页眉大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{

    CGSize size = {240,33};
    return size;

}

//设置页脚大小
 - (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{

    CGSize size = {240,33};
    return size;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
