//
//  ViewController.m
//  PodTest
//
//  Created by 李超 on 15/11/26.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>

@interface ViewController ()

@property(nonatomic,strong) UIView *subView;

@end

@implementation ViewController

- (UIView *) subView{

    if (_subView == nil) {
        _subView = [[UIView alloc] init];
        _subView.backgroundColor = [UIColor orangeColor];
    }
    return _subView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // self.title = @"first";
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // 防止block中的循环引用
    __weak typeof(self) weakSelf = self;
    
    [self.view addSubview:self.subView];
    
    //自动布局
    
    [self.subView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(weakSelf.view).with.offset(40);
        make.left.mas_equalTo(weakSelf.view).with.offset(40);
        make.right.mas_equalTo(weakSelf.view).with.offset(-40);
        make.bottom.mas_equalTo(weakSelf.view).with.offset(-80);
    }];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
