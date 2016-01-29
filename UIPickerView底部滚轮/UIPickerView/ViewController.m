//
//  ViewController.m
//  UIPickerView
//
//  Created by 李超 on 15/12/22.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewController.h"

#define singerPickerView 0
#define singPickerView 1

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIPickerView *pickersView;
@property (strong, nonatomic) NSArray *firstDataArray;
@property (strong, nonatomic) NSArray *secondDataArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *areaArray;
@property (strong, nonatomic) NSDictionary *pickerDictionary;  //读取文件数据

@end

@implementation ViewController

- (UITextField *)textField{
    if (_textField == nil) {
        _textField = [[UITextField alloc]
          initWithFrame:CGRectMake(0,40,self.view.bounds.size.width,44)];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.layer.borderWidth = 1;
    }
    return _textField;
}

- (NSArray *)firstDataArray{
    if (_firstDataArray == nil) {
        _firstDataArray = @[@"北京",@"上海",@"天津"];
    }
    return _firstDataArray;
}

- (NSArray *)secondDataArray{
    if (_secondDataArray == nil) {
        _secondDataArray = @[@[@"朝阳",@"海淀",@"丰台"],
             @[@"虹口",@"浦东"],@[@"滨海"]];
    }
    return _secondDataArray;
}

- (UIPickerView *)pickersView{
    if (_pickersView == nil) {
        _pickersView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
        _pickersView.delegate = self;
        _pickersView.dataSource = self;
        _pickersView.backgroundColor = [UIColor lightGrayColor];
        _pickersView.showsSelectionIndicator = YES;
    }
    return _pickersView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _cityArray = self.firstDataArray;
    
    _areaArray = self.secondDataArray[0];
    
    [self.view addSubview:self.textField];
    
    self.textField.inputView = self.pickersView;
    
    [self.textField becomeFirstResponder];

}

//显示列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    NSLog(@"componet ");

    return 2;
}

//显示行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        NSLog(@"%lu",self.firstDataArray.count);

        return self.firstDataArray.count;
    }else if (component == 1) {
        return _areaArray.count;
    }
    return 0;
}

//点击事件
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        _areaArray = self.secondDataArray[row];
        [self.pickersView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    
    NSInteger firstColumn = [self.pickersView selectedRowInComponent:0];
    NSInteger secondColumn = [self.pickersView selectedRowInComponent:1];
    NSString *city = _cityArray[firstColumn];
    NSString *area = _areaArray[secondColumn];
    self.textField.text = [NSString stringWithFormat:@"%@-%@",city,area];
}

//每行显示内容
- (NSString *)pickerView:(UIPickerView *)pickerView
    titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        NSLog(@"componet = %@",self.firstDataArray[row]);
        NSString  *string = self.firstDataArray[row];
        return string;
    } else if(component == 1){
        return _areaArray[row];
    }
    return @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.pickersView selectRow:0 inComponent:0 animated:YES];
    
    NSString *defaultString = [NSString stringWithFormat:@"%@-%@",
                               _cityArray[0],_areaArray[0]];
    
    self.textField.text = defaultString;

}

@end
