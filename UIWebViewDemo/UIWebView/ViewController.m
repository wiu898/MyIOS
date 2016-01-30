//
//  ViewController.m
//  UIWebView
//
//  Created by 李超 on 15/11/25.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewController.h"
#import "UIWeb.h"

@interface ViewController ()

@property(strong,nonatomic) UITextField *textField;

@property(copy,nonatomic) NSString *url;

@property(strong,nonatomic) UIButton *goButton;

@property(strong,nonatomic) UIView *backGroundView;

@end

@implementation ViewController

-(UIView *) backGroundView{
   
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:self.view.frame];
        _backGroundView.backgroundColor = [UIColor whiteColor];
    }
    return _backGroundView;

}

- (UITextField *) textField{
    if (_textField == nil) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(10,84,200,40)];
        _textField.placeholder = @"请输入网址";
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.borderStyle = 3;
        _textField.textColor = [UIColor grayColor];
        _textField.font = [UIFont systemFontOfSize:13];
    }
    return _textField;

}

- (UIButton *) goButton{
    if (_goButton == nil) {
        _goButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _goButton.frame = CGRectMake(230,84,60,40);
        _goButton.backgroundColor = [UIColor orangeColor];
        [_goButton setTitle:@"GO" forState:UIControlStateNormal];
        
        [_goButton addTarget:self action:@selector(dealWeb:) forControlEvents:UIControlEventTouchUpInside];
        
        _goButton.layer.cornerRadius = 2;
        
        [_goButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _goButton;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *views = [[UIView alloc] initWithFrame:self.view.frame];
    
    views.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:self.goButton];
    
    [self.view addSubview:self.textField];
    
}

- (void) dealWeb:(UIButton *) sender{
    
    UIWeb *web = [[UIWeb alloc] init];
    
    _url = _textField.text;
    
    web.pathUrl = _url;
    
    NSLog(@"%@",web.pathUrl);
    
    [self.navigationController pushViewController:web animated:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
