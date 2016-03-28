//
//  SettingController.m
//  DouYU
//
//  Created by 李超 on 16/3/24.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "SettingController.h"
#import "SectionView.h"
#import "SwithCell.h"
#import "SliderCell.h"
#import "TanLableCell.h"
#import "UMessage.h"

@interface SettingController()<UITableViewDataSource,UITableViewDelegate>
{

    UITableView *_tableView;
    
    NSArray *_dataArray;
    
    UISwitch *_cellSwitch;
    
    CGFloat alp;
    
    CGFloat fot;
    
}

@property (nonatomic, strong) NSArray *firstArray;

@property (nonatomic, strong) NSArray *lastArray;

@end

@implementation SettingController

- (void)viewDidLoad{

    [super viewDidLoad];
    
    alp = 1;
    
    fot = 17;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _firstArray = [NSArray array];
    _firstArray = @[@"列表自动加载",@"展示全部分类"];
    
    _lastArray = [NSArray array];
    _lastArray = @[@"消息通知",@"清理缓存",@"关于我们",@"给我们评分"];
    
    [self initNav];
    
    [self initTableView];
}

- (void)initTableView{

    _tableView = [[UITableView alloc] initWithFrame:
        CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
}

- (void)initNav{

    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftButton.frame = CGRectMake(0, 0, 25, 25);
    
    [leftButton setImage:[UIImage imageNamed:@"btn_nav_back"]
        forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(CloseSetting) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
        initWithCustomView:leftButton];
    
    self.navigationItem.titleView = nil;
    
    self.title = @"设置";
    
}

- (void)CloseSetting{
   
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    if (section == 0 ) {
        
        return 2;
    
    }else if (section == 1){
     
        return 9;
        
    }else if (section == 2){
        
        return 4;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:
   (NSIndexPath *)indexPath{

    return 55 *KWidth_Scale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:
   (NSInteger)section{
    
    return 45 * KWidth_Scale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:
   (NSInteger)section{

    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *swithCell=@"SwithCell";
    
    if (indexPath.section == 0) {
        
      //  SwithCell *cell = [SwithCell GetCellWithTableView:tableView];
        
        SwithCell *cell=[tableView dequeueReusableCellWithIdentifier:swithCell];
        
        if (!cell) {
            
            cell=[[[NSBundle mainBundle]loadNibNamed:@"SwithCell" owner:nil options:nil] firstObject];
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.Title.text = _firstArray[indexPath.row];
        
        cell.cellSwith.tag = indexPath.row;
        
        [cell.cellSwith addTarget:self action:@selector(SwithButton:) forControlEvents:UIControlEventValueChanged];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    
    }else if (indexPath.section == 1){
       
        if (indexPath.row == 0) {
            
          //  SwithCell * cell = [SwithCell GetCellWithTableView:tableView];
            
            SwithCell *cell=[tableView dequeueReusableCellWithIdentifier:swithCell];
            
            if (!cell) {
                
                cell=[[[NSBundle mainBundle]loadNibNamed:@"SwithCell" owner:nil options:nil] firstObject];
            }

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.Title.text = @"播放器手势";
            
            cell.cellSwith.tag = 2;
            
            [cell.cellSwith addTarget:self action:@selector(SwithButton:) forControlEvents:UIControlEventValueChanged];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }else if (indexPath.row == 1){
            
            static NSString *TCell=@"TanLableCell";
        
          //  TanLableCell *cell = [TanLableCell GetCellWithTableView:tableView];
            
            TanLableCell *cell = [tableView dequeueReusableCellWithIdentifier:TCell];
            
            if (!cell) {
                
                cell = [[[NSBundle mainBundle] loadNibNamed:@"TanLableCell" owner:nil options:nil] firstObject];
            }
            
            cell.Example.alpha = alp;
            
            cell.Example.font = [UIFont systemFontOfSize:fot];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        
        }else if (indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 6){
        
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tanmu"];
            
            if (indexPath.row == 2) {
                cell.textLabel.text = @"弹幕透明度";
            }
            if (indexPath.row == 4) {
                cell.textLabel.text = @"弹幕字号";
            }
            if (indexPath.row == 6) {
                cell.textLabel.text = @"弹幕位置";
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }else if (indexPath.row == 3 || indexPath.row == 5){
            
            static NSString *sliderCell=@"SliderCell";
            
            SliderCell *cell = [tableView dequeueReusableCellWithIdentifier:sliderCell];
            
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"SliderCell" owner:nil options:nil] firstObject];
            }
        
          //  SliderCell *cell = [SliderCell GetCellWithTableView:tableView];
            
            if (indexPath.row == 3) {
                
                cell.Small.image = [UIImage imageNamed:@"Image_font_small"];
                cell.Big.image = [UIImage imageNamed:@"Image_font_big"];
                cell.Silder.tag = 1;
                cell.Silder.value = 1;
                
            }else if (indexPath.row == 5){
            
                cell.Small.image=[UIImage imageNamed:@"Image_alpha_small"];
                cell.Big.image=[UIImage imageNamed:@"Image_alpha_big"];
                cell.Silder.tag=2;

            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.Silder addTarget:self action:@selector(SliderChange:) forControlEvents:UIControlEventValueChanged];
            
            return cell;
            
        }else if (indexPath.row == 7){
            
            static NSString *TCell=@"TanLableCell";
            
            TanLableCell *cell = [tableView dequeueReusableCellWithIdentifier:TCell];
            
            if (!cell) {
                
                cell = [[[NSBundle mainBundle] loadNibNamed:@"TanLableCell" owner:nil options:nil] firstObject];
            }
        
//            TanLableCell *cell = [TanLableCell GetCellWithTableView:tableView];
//            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }else if (indexPath.row == 8){
        
            static NSString *lastCellId = @"lastCellID";
            
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:lastCellId];
            
            if (!cell) {
                
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lastCellId];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.text = @"休眠设置";
            
            return cell;
        }
        
        return nil;
        
    }else if (indexPath.section == 2){
    
        if (indexPath.row == 0) {
            
           // SwithCell *cell = [SwithCell GetCellWithTableView:tableView];
            
            SwithCell *cell=[tableView dequeueReusableCellWithIdentifier:swithCell];
            
            if (!cell) {
                
                cell=[[[NSBundle mainBundle]loadNibNamed:@"SwithCell" owner:nil options:nil] firstObject];
                
            }

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.Title.text = _lastArray[indexPath.row];
            
            cell.cellSwith.tag = 3;
            
            [cell.cellSwith addTarget:self action:@selector(SwithButton:) forControlEvents:UIControlEventValueChanged];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        
        }else if (indexPath.row == 1){
        
            static NSString *lastCellID = @"lastcellID1";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:lastCellID];
            
            if (!cell) {
                
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lastCellID];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            NSString *caches = [NSString stringWithFormat:@"%.1fM",[self filePath]];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-60, 10, 60, 40)];
            
            label.text = caches;
            
            cell.detailTextLabel.text = caches;
            
            [cell.contentView addSubview:label];
            
            cell.textLabel.text = _lastArray[indexPath.row];
            
            return cell;
        
        }else{
        
            static NSString *lastCellID = @"lastcellID2";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:lastCellID];
            
            if (!cell) {
                
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lastCellID];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.text = _lastArray[indexPath.row];
            
            return cell;
            
        }
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
   (NSIndexPath *)indexPath{

    if (indexPath.section == 2) {
        
        if (indexPath.row == 1) {
            
            [self clearFile];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:
   (NSInteger)section{

    NSArray *sectionArray = @[@"系统设置",@"直播设置",@"其他设置"];
    
    SectionView *sectionView = [[SectionView alloc] init];
    
    sectionView.Title.text = sectionArray[section];
    
    return sectionView;
}

- (void)SwithButton:(UISwitch *)sender{
    
    //0 列表自动加载
    //1 展示全部分类
    //2 播放器手势
    //3 消息通知

    NSLog(@"%ld",sender.tag);
    
    if (sender.tag == 3) {
        if (sender.on) {
            
        }else{
           
            [UMessage unregisterForRemoteNotifications];
        }
    }
}

- (void)SliderChange:(UISlider *)sender{

    //弹幕透明度
    if (sender.tag == 1) {
        
        alp = sender.value;
    }
    
    //弹幕大小
    if (sender.tag == 2) {
        
        fot = sender.value * 30;
    }
    
    //刷新
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}

//*********************清理缓存********************//

// 显示缓存大小
- (float)filePath{

    NSString *filePath =
       [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)
        firstObject];
    
    return [self folderSizeAtPath:filePath];
    
}

//1.首先计算单个文件大小

- (long long) fileSizeAtPath:(NSString *)filePath{

    NSFileManager *manager = [NSFileManager defaultManager];
    
    //判断文件存在
    if ([manager fileExistsAtPath:filePath]) {
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    
    return 0;
}

//2.遍历文件夹获得文件夹大小,返回缓存M
- (float) folderSizeAtPath:(NSString *)folderPath{

    NSFileManager *manager = [NSFileManager defaultManager];
    
    //如果文件不存在
    if (![manager fileExistsAtPath:folderPath]) {
       
        return 0;
    }
    
    //取出folder文件夹下所有文件
    NSEnumerator *childFilesEnumerator =
       [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString *fileName;
    
    long long folderSize = 0;
    
    //遍历所有文件
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        
        //根据文件名获得该文件路径
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        //将所有文件大小相加
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    
    return folderSize/ (1024.0 * 1024.0);
    
}

//清理缓存

- (void)clearFile{

    NSString *cachePath = [NSSearchPathForDirectoriesInDomains
      (NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    NSLog(@"cachePath = %@",cachePath);
    
    for (NSString *p in files) {
        
        NSError *error = nil;
        
        NSString *path = [cachePath stringByAppendingPathComponent:p];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
    }
    
    [self performSelectorOnMainThread:@selector(clearCachesSuccess)
        withObject:nil waitUntilDone:YES];
}

- (void)clearCachesSuccess{
    
    UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:@"提示"
        message:@"缓存清理成功" preferredStyle:UIAlertControllerStyleAlert];
    
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
//        style:UIAlertActionStyleCancel
//        handler:^(UIAlertAction *action) {
//            
//        NSLog(@"取消");
//    }];
//    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"
        style:UIAlertActionStyleCancel
        handler:^(UIAlertAction *action) {
                                                             
        NSLog(@"确定");
        }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController
                       animated:YES completion:nil];

    NSLog(@"清理成功");
    
    //刷新
    NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:2];
    
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index, nil]
        withRowAnimation:UITableViewRowAnimationNone];
}

- (void)didReceiveMemoryWarning{

    [super didReceiveMemoryWarning];
}










































@end
