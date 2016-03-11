//
//  CancelAppointmentCell.m
//  PodTest
//
//  Created by 李超 on 16/1/21.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "CancelAppointmentCell.h"
#import "ToolHeader.h"

@interface CancelAppointmentCell()

@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) UILabel *cancelTitle;
@property (strong, nonatomic) NSMutableArray *btnArray;

@end

@implementation CancelAppointmentCell

- (NSMutableArray *)bntArray {
    if (_btnArray == nil) {
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}

- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 200)];
    }
    return _backGroundView;
}

- (UILabel *)cancelTitle {
    if (_cancelTitle == nil) {
        _cancelTitle = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _cancelTitle.text = @"取消原因";
    }
    return _cancelTitle;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:
   (NSString *)reuseIdentifier{
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
    
    NSArray *titleArray = @[@"临时有事无法参加",@"预约错教练",
        @"暂时不参加驾照自考",@"其他"];
    
    for (NSUInteger i = 0; i<4; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15, 60+(15+20)*i, 15, 15);
        [button setBackgroundImage:[UIImage imageNamed:@"cancelSelect.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"cancelSelect_click.png"] forState:UIControlStateSelected];
        button.tag = 100 + i;
        [self.btnArray addObject:button];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+15+10, 60+(15+20)*i, kSystemWide/2, 15)];
        contentLabel.userInteractionEnabled = YES;
        contentLabel.textColor = [UIColor blackColor];
        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.text = titleArray[i];
        contentLabel.tag = 100 + i;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
           initWithTarget:self action:@selector(clickTap:)];
        [contentLabel addGestureRecognizer:tap];
        
        [self.backGroundView addSubview:button];
        [self.backGroundView addSubview:contentLabel];
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
