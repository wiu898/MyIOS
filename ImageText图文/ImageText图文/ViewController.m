//
//  ViewController.m
//  ImageText图文
//
//  Created by 李超 on 16/2/2.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "ViewController.h"
#import "PrefixHeader.h"
#import "TextAndImageModel.h"
#import "TextAndImageCell.h"
#import "FromValidator.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation ViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:
            CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        //tableView背景
        UIView *backGroundView = [[UIView alloc] initWithFrame:self.view.frame];
        backGroundView.backgroundColor = [UIColor lightGrayColor];
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:self.view.frame];
        
        [image setImage:[UIImage imageNamed:@"bj9.jpg"]];
        
        [backGroundView addSubview:image];
        
        backGroundView.alpha = 0.7;
        
        _tableView.backgroundView = backGroundView;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
                
        _dataArray = [[NSMutableArray alloc] init];
        
        TextAndImageModel *model1 = [[TextAndImageModel alloc] init];
        model1.imgStr = @"1.jpg";
        model1.content = @"这个是比较简单的图文混排,自适应宽高";
        model1.name = @"生活的节奏";
        
        TextAndImageModel *model2 = [[TextAndImageModel alloc] init];
        model2.imgStr = @"2.jpg";
        model2.content = @"这个是比较简单的图文混排，自适应宽高这个是比较简单的图文混排，自适应宽高这个是比较简单的图文混排，自适应宽高这个是比较简单的图文混排，自适应宽高";
        model2.name = @"安静的我";
        
        TextAndImageModel *model3 = [[TextAndImageModel alloc] init];
        model3.imgStr = @"3.jpg";
        model3.content = @"这个是比较简单的图文混排，自适应宽高这个是比较简单的图文混排，自适应宽高,这个是比较简单的图文混排，自适应宽高,这个是比较简单的图文混排，自适应宽高,这个是比较简单的图文混排，自适应宽高,这个是比较简单的图文混排，自适应宽高";
        model3.name = @"舒适的日子";
        
        TextAndImageModel *model4 = [[TextAndImageModel alloc] init];
        model4.imgStr = @"4.jpg";
        model4.content = @"这个是比较简单的图这个是比较简单的图文混排，自适应宽高这个是比较简单的图文混排，自适应宽高混排，自适应宽高";
        model4.name = @"热爱生活";
        
        TextAndImageModel *model5 = [[TextAndImageModel alloc] init];
        model5.imgStr = @"5.jpg";
        model5.content = @"这个这个是比较简单的图文混排，自适应宽高这个是比较简单的图文混排，自适应宽高是比较简单的图文混排，自适应宽高";
        model5.name = @"喜欢这种安静";
        
        [_dataArray addObject:model1];
        [_dataArray addObject:model2];
        [_dataArray addObject:model3];
        [_dataArray addObject:model4];
        [_dataArray addObject:model5];

    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"图文混排";
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self.view addSubview:self.tableView];

}

#pragma mark - tableViewDelegate&DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
    (NSIndexPath *)indexPath{
   
    static NSString *cellId = @"cell";
    
    TextAndImageCell *cell = [tableView
       dequeueReusableCellWithIdentifier:cellId];

    if (cell == nil) {
        cell = [[TextAndImageCell alloc] initWithStyle:UITableViewCellStyleDefault
            reuseIdentifier:cellId];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;

    }
    
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TextAndImageModel *model =self.dataArray[indexPath.row];
    CGRect rect =[FromValidator rectWidthAndHeightWithStr:model.content AndFont:12 WithStrWidth:300];
    NSLog(@"long = %f",70*Height+rect.size.height);
    return 70*Height+rect.size.height;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count = %lu",self.dataArray.count);
    return self.dataArray.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
