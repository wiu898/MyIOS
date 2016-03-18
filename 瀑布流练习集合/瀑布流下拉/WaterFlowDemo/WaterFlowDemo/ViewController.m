//
//  ViewController.m
//  WaterFlowDemo
//
//  Created by 李超 on 16/3/14.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "ViewController.h"
#import "WaterflowerView.h"
#import "WaterflowerViewCell.h"
#import "DemoModel.h"
#import "DemoCell.h"
#import "MJExtension.h"

@interface ViewController ()<WaterflowerViewDataSource,WaterflowerViewDelegate>

@property (nonatomic, strong) NSMutableArray *demoArr;
@property (nonatomic, weak) WaterflowerView *waterflowView;  //看成tableView

@end

@implementation ViewController

- (NSMutableArray *)demoArr
{
    if (_demoArr == nil) {
        self.demoArr = [NSMutableArray array];
    }
    return _demoArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"瀑布流";

    [self.demoArr addObjectsFromArray:[DemoModel objectArrayWithFilename:@"demo.plist"]];
    
    WaterflowerView *waterflowerView = [[WaterflowerView alloc] init];
    waterflowerView.frame = self.view.bounds;
    waterflowerView.delegate = self;
    waterflowerView.dataSource = self;
    [self.view addSubview:waterflowerView];
    self.waterflowView = waterflowerView;
}

#pragma mark - dataSource 代理方法

- (NSUInteger)numberOfCellsInWaterflowerView:(WaterflowerView *)waterflowerView{
    
    return self.demoArr.count;
}

- (NSUInteger)numberOfColumnsInWaterflowerView:(WaterflowerView *)waterflowerView{
    
    return 3;
}

- (WaterflowerViewCell *)waterflowerView:(WaterflowerView *)waterflowView cellAtIndex:(NSUInteger)index{

    DemoCell *cell = [DemoCell cellWithWaterflower:waterflowView];
    cell.model = self.demoArr[index];
    return cell;
}

#pragma mark - delegate代理方法

- (CGFloat)waterflowerView:(WaterflowerView *)waterflowerView heightAtIndex:(NSUInteger)index{
    
    DemoModel *model = self.demoArr[index];
    return waterflowerView.cellWidth *model.h / model.w;
}

- (CGFloat)waterflowerView:(WaterflowerView *)waterflowerView marginForType:(WaterflowerViewMarginType)type{

    switch (type) {
        case WaterflowerViewMarginTypeBottom:
        case WaterflowerViewMarginTypeLeft:
        case WaterflowerViewMarginTypeRight:
        case WaterflowerViewMarginTypeRow:
        case WaterflowerViewMarginTypeCulomn:
            return 10;
            break;
            
        default:
            return 10;
            break;
    }
}

- (void)waterflowerView:(WaterflowerView *)waterflowerView didSelectedAtIndex:(NSUInteger)index{

    NSLog(@"点击了第%ld个cell",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
