//
//  EditorUserViewController.m
//  PodTest
//
//  Created by 李超 on 15/12/21.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "EditorUserViewController.h"
#import <QiniuSDK.h>
#import <SVProgressHUD.h>
#import "JsonTransformManager.h"
#import "PFActionSheetView.h"
#import "JEPhotoPickManger.h"
#import "ModifyNameViewController.h"
#import "ModifyNickNameViewController.h"
#import "GenderViewController.h"
#import "SignatureViewController.h"
#import "CommonAddressViewController.h"
#import "ModifyPhoneNumViewController.h"

static NSString *const kupdateUserInfo = @"userinfo/updateuserinfo";

@interface  EditorUserViewController()<UITableViewDataSource,
    UITableViewDelegate,UINavigationControllerDelegate,
    UIImagePickerControllerDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) UIImageView *userHeadImage;
@property (strong, nonatomic) NSArray *detailDataArray;
@property (strong, nonatomic) NSString *qiniuToken;

@end

@implementation EditorUserViewController

- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = @[@[@"头像",@"名字",@"昵称",@"性别",@"个性签名"],
            @[@"绑定手机号",@"常用地址"]];
    }
    return _dataArray;
}

- (NSArray *)detailDataArray{
    if (_detailDataArray == nil) {
        _detailDataArray = @[@[@"",[AccountManager manager].userName,
            [AccountManager manager].userNickName,[AccountManager manager].userGender,
            [AccountManager manager].userSignature],
           @[[AccountManager manager].userDisplaymobile,
            [AccountManager manager].userAddress]];
    }
    return _detailDataArray;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
            style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"编辑信息";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:
        @selector(genderChange) name:kGenderChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:
        @selector(signatureChange) name:kSignatureChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:
        @selector(nameChange) name:kmodifyNameChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:
        @selector(nickNameChange) name:kmodifyNickNameChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:
        @selector(addAddressChange) name:kaddAddressChange object:nil];
   
}

- (void)addAddressChange{
    NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:
        UITableViewRowAnimationNone];
}

- (void)nickNameChange{
    NSIndexPath *path = [NSIndexPath indexPathForRow:2 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:
        UITableViewRowAnimationNone];
}

- (void)nameChange{
    NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:
        UITableViewRowAnimationNone];
}

- (void)genderChange{
    NSIndexPath *path = [NSIndexPath indexPathForRow:3 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:
        UITableViewRowAnimationNone];
}

- (void)signatureChange{
    NSIndexPath *path = [NSIndexPath indexPathForRow:4 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:
        UITableViewRowAnimationNone];
}

//返回分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_dataArray count];
    //return 2;
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:
    (NSIndexPath *)indexPath{
    if (indexPath.section ==0 && indexPath.row ==0) {
        return 80;
    }
    return 44;
}

//设置底部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:
    (NSInteger)section{
        return 20;
}

//每个分区行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
    (NSInteger)section{
       return [self.dataArray[section] count];
}

//绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
    (NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    //头像行
    if (indexPath.row ==0 && indexPath.section ==0) {
        self.userHeadImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,
            60, 60)];
        cell.accessoryView = self.userHeadImage;
        if ([AccountManager manager].userHeadImageUrl) {
            DYNSLog(@"imageUrl = %@",[AccountManager manager].userHeadImageUrl);
            [self.userHeadImage sd_setImageWithURL:[NSURL URLWithString:
                [AccountManager manager].userHeadImageUrl] placeholderImage:
             [UIImage imageNamed:@"littleImage.png"]];
        }
        self.userHeadImage.backgroundColor = MAINCOLOR;
    }else {
        DYNSLog(@"reload = %@ %@",self.detailDataArray[indexPath.section][indexPath.row]
                ,[AccountManager manager].userName);
        cell.detailTextLabel.text = self.detailDataArray[indexPath.section][indexPath.row];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    
    return cell;
}

//点击每行触发事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
    (NSIndexPath *)indexPath{
    if (indexPath.section ==0 && indexPath.row == 0) {
        
        [JEPhotoPickManger pickPhotofromController:self];
        
    }else if(indexPath.section == 1 && indexPath.row == 0){
        
        ModifyPhoneNumViewController *modify = [[ModifyPhoneNumViewController alloc] init];
        [self.navigationController pushViewController:modify animated:YES];
        
    }else if(indexPath.section == 0 && indexPath.row == 1){
        
        ModifyNameViewController *modify = [[ModifyNameViewController alloc] init];
        [self.navigationController pushViewController:modify animated:YES];
        
    }else if(indexPath.section == 0 && indexPath.row == 2){
        
        ModifyNickNameViewController *modify = [[ModifyNickNameViewController alloc] init];
        [self.navigationController pushViewController:modify animated:YES];
        
    }else if(indexPath.section == 0 && indexPath.row == 3){
    
        GenderViewController *modify = [[GenderViewController alloc] init];
        [self.navigationController pushViewController:modify animated:YES];
        
    }else if(indexPath.section == 0 && indexPath.row == 4){
        
        SignatureViewController *modify = [[SignatureViewController alloc] init];
        [self.navigationController pushViewController:modify animated:YES];
    
    }else if(indexPath.section == 1 && indexPath.row == 1){
        
        CommonAddressViewController *modify = [[CommonAddressViewController alloc] init];
        [self.navigationController pushViewController:modify animated:YES];
    }
}

#pragma mark - delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    DYNSLog(@"imageData = %@",[AccountManager manager].userid);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *photoImage = [info valueForKey:UIImagePickerControllerEditedImage];
    
    NSData *photoData = UIImageJPEGRepresentation(photoImage, 0.5);
    self.userHeadImage.image = photoImage;
    
    __weak EditorUserViewController *weakself = self;
    __block NSData *gcdPhtotData = photoData;
    
    NSString *qiniuUrl = [NSString stringWithFormat:BASEURL,kQiniuUpdateUrl];
    [SVProgressHUD show];
    
    [JENetwoking startDownLoadWithUrl:qiniuUrl postParam:nil
        WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            DYNSLog(@"data = %@",data);
            NSDictionary *dataDic = data;
        
            weakself.qiniuToken = dataDic[@"data"];
            
            QNUploadManager *upLoadManager = [[QNUploadManager alloc] init];
          
            NSString *keyUrl = [NSString stringWithFormat:@"%@-%@.png",
                [NSString currentTimeDay],[AccountManager manager].userid];
          
            DYNSLog(@"keyUrl = %@",keyUrl);
            
            [upLoadManager putData:gcdPhtotData key:keyUrl token:weakself.qiniuToken
                complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                    
                    DYNSLog(@"info = %@ %@ %@",info,key,resp);
                    if (info) {
                        DYNSLog(@"key = %@",key);
                        
                        NSString *upImageUrl = [NSString stringWithFormat:
                            kQiniuImageUrl,key];
                        
                        NSString *updateUserInfoUrl = [NSString stringWithFormat:
                            BASEURL,kupdateUserInfo];
                        
                        NSDictionary *headPortrait = @{@"originalpic":upImageUrl,
                                                       @"thumbnailpic":@"",
                                                       @"width":@"",
                                                       @"height":@""};
                        
                        NSDictionary *dictParam = @{@"headportrait":
                            [JsonTransformManager dictionaryTransformJsonWith:
                             headPortrait],@"userid":[AccountManager manager].userid};
                        [JENetwoking startDownLoadWithUrl:updateUserInfoUrl
                             postParam:dictParam
                            WithMethod:JENetworkingRequestMethodPost
                        withCompletion:^(id data) {
                            NSDictionary *dataParam = data;
                            NSNumber *message = dataParam[@"type"];
                            DYNSLog(@"msg = %@ %@",data,dataParam[@"msg"]);
                            if (message.intValue == 1 ) {
                                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                                [AccountManager saveUserHeadImageUrl:upImageUrl];
                                DYNSLog(@"url = %@",[AccountManager manager].
                                    userHeadImageUrl);
                                
                                [weakself.userHeadImage sd_setImageWithURL:
                                 [NSURL URLWithString:[AccountManager manager].userHeadImageUrl]
                                 placeholderImage:[UIImage imageWithData:gcdPhtotData]];
                                
                            }else{
                                [SVProgressHUD showErrorWithStatus:@"修改失败"];
                                return;
                            }
                        }];
                    }
                    
                } option:nil];
        }];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{

    viewController.title =@"照片";
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(0, 0, 44, 44);
    [cancelBtn addTarget:self action:@selector(clickCancel:)
       forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]
       initWithCustomView:cancelBtn];
    viewController.navigationItem.rightBarButtonItem = rightItem;
}

- (void)clickCancel:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
