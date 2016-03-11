//
//  FeedBackViewController.m
//  PodTest
//
//  Created by 李超 on 15/12/23.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "FeedBackViewController.h"
#import "UIDevice+JEsystemVersion.h"

@interface FeedBackViewController()

@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIButton *submitButton;

@end

@implementation FeedBackViewController

- (UIButton *)submitButton{
    if (_submitButton == nil) {
        _submitButton = [WMUITool initWithTitle:@"提交"
            withTitleColor:[UIColor whiteColor]
            withTitleFont:[UIFont systemFontOfSize:16]];
        _submitButton.backgroundColor = MAINCOLOR;
        
        [_submitButton addTarget:self action:@selector(clickSubmit:)
            forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

- (UITextView *)textView{
    if (_textView == nil) {
        _textView = [[UITextView alloc] initWithFrame:
            CGRectMake(0, 20, kSystemWide, 90)];
        _textView.backgroundColor = [UIColor whiteColor];
    }
    return _textView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if ([UIDevice jeSystemVersion] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.title = @"反馈";
    self.view.backgroundColor = RGBColor(245, 247, 250);
    
    [self.view addSubview:self.textView];
    
    [self.view addSubview:self.submitButton];
    
    #pragma mark - 自动布局
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.top.mas_equalTo(self.textView.mas_bottom).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        make.height.mas_equalTo(@44);
    }];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)clickSubmit:(UIButton *)sender {
    NSLog(@"空方法");
}






























@end
