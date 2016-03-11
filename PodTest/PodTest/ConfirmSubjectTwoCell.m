//
//  ConfirmSubjectTwoCell.m
//  PodTest
//
//  Created by 李超 on 16/1/20.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "ConfirmSubjectTwoCell.h"
#import "ToolHeader.h"

@interface ConfirmSubjectTwoCell ()

@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) UILabel *cancelTitle;
@property (strong, nonatomic) NSMutableArray *btnArray;
@property (strong, nonatomic) NSMutableArray *titleArray;

@end

@implementation ConfirmSubjectTwoCell

- (NSMutableArray *)bntArray {
    if (_btnArray == nil) {
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}

- (NSMutableArray *)titleArray {
    if (_titleArray == nil) {
        _titleArray = [[NSMutableArray alloc] init];
    }
    return _titleArray;
}

- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 300)];
    }
    return _backGroundView;
}

- (UILabel *)cancelTitle {
    if (_cancelTitle == nil) {
        _cancelTitle = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _cancelTitle.text = @"科目三内容";
    }
    return _cancelTitle;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    
    [self.contentView addSubview:self.backGroundView];
    self.backGroundView.userInteractionEnabled = YES;
    
    [self.backGroundView addSubview:self.cancelTitle];
    [self.cancelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(20);
    }];
    
    NSArray *titleArray = @[@"上车准备",@"夜间行驶",@"起步",@"会车",@"直线行驶",@"超车",
        @"变更车道",@"掉头",@"通过路口",@"综合练习",@"靠边停车",@"其他"];
    
    for (NSUInteger i = 0; i<12; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i % 2 == 0) {
            button.frame = CGRectMake(15, 60+(15)*i, 15, 15);
        }else {
            button.frame = CGRectMake(kSystemWide/2, 60+(15)*(i-1), 15, 15);
        }
        [button setBackgroundImage:[UIImage imageNamed:@"cancelSelect.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"cancelSelect_click.png"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(dealButton:) forControlEvents:UIControlEventTouchUpInside];
        
        button.tag = 1000 + i;
        [self.bntArray addObject:button];
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.backgroundColor = [UIColor cyanColor];
        if (i % 2 == 0) {
            contentLabel.frame = CGRectMake(15+15+10, 60+(15)*i, (kSystemWide/2)-15, 15);
        }else {
            contentLabel.frame = CGRectMake((kSystemWide/2)+15+10, 60+(15)*(i-1),
                (kSystemWide/2)-15-20, 15);
        }
        
        contentLabel.userInteractionEnabled = YES;
        contentLabel.textColor = [UIColor blackColor];
        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.text = titleArray[i];
        contentLabel.tag = 1000 + i;
        [self.titleArray addObject:contentLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
            initWithTarget:self action:@selector(clickTap:)];
        [contentLabel addGestureRecognizer:tap];
        
        [self.backGroundView addSubview:button];
        [self.backGroundView addSubview:contentLabel];

    }
    
}

- (void)dealButton:(UIButton *)sender {
    for (UIButton *b in self.btnArray) {
        b.selected = NO;
        if (b.tag == sender.tag) {
            b.selected = YES;
        }
    }
    UILabel *contentLabel = self.titleArray[sender.tag - 100];
    if ([_delegate respondsToSelector:@selector(senderCancelMessage:)]) {
        DYNSLog(@"content = %@",contentLabel.text);
        [_delegate senderCancelMessage:contentLabel.text];
    }
    
}

- (void)clickTap:(UITapGestureRecognizer *)tap {
    UILabel *contentLabel = (UILabel *)tap.view;
    for (UIButton *b in self.bntArray) {
        b.selected = NO;
        if (b.tag == contentLabel.tag) {
            b.selected = YES;
        }
    }
    if ([_delegate respondsToSelector:@selector(senderCancelMessage:)]) {
        [_delegate senderCancelMessage:contentLabel.text];
    }
}

@end
