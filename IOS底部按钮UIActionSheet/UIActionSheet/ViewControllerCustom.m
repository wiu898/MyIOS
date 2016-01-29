//
//  ViewControllerCustom.m
//  UIActionSheet
//
//  Created by 李超 on 15/12/21.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewControllerCustom.h"
#import "CustomActionSheet.h"

@interface ViewControllerCustom()

@property (strong, nonatomic) UIButton *button;

@end

@implementation ViewControllerCustom

- (UIButton *)button{
    if(_button == nil){
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(110, 100, 100, 40);
        _button.backgroundColor = [UIColor blackColor];
        _button.layer.cornerRadius = 3;
        [_button setTitle:@"Click" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor redColor]
                      forState:UIControlStateNormal];
        
        [_button addTarget:self action:@selector(testActionSheet) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"second";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.button];
    
}

- (void)testActionSheet{
    CustomActionSheet *actionSheet = [[CustomActionSheet alloc]                initwithHeight:284.0f
        WithSheetTitle:@"自定义ActionSheet"];
    UILabel *label = [[UILabel alloc]
        initWithFrame:CGRectMake(0,50,320,50)];
    label.text = @"这里是要自定义的控制";
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [actionSheet addSubview:label];
    [actionSheet showInView:self.view];
}

@end
