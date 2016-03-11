//
//  AppointmentCollectionViewCell.m
//  PodTest
//
//  Created by 李超 on 15/12/29.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "AppointmentCollectionViewCell.h"
#import "ToolHeader.h"
#import "AppointmentCoachTimeInfoModel.h"

@interface AppointmentCollectionViewCell ()

@property (strong, nonatomic) UIView *selectedAppView;

@end

@implementation AppointmentCollectionViewCell

- (UIView *)selectedAppView {
    if (_selectedAppView == nil) {
        _selectedAppView = [[UIView alloc] init];
        _selectedAppView.layer.borderWidth = 1;
        _selectedAppView.layer.borderColor = MAINCOLOR.CGColor;
    }
    return _selectedAppView;
}

- (UILabel *)startTimeLabel {
    if (_startTimeLabel == nil) {
        _startTimeLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont boldSystemFontOfSize:18]];
        _startTimeLabel.text = @"8:00";
    }
    return _startTimeLabel;
}

- (UILabel *)finalTimeLabel {
    if (_finalTimeLabel == nil) {
        _finalTimeLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:12]];
        _finalTimeLabel.text = @"9:00结束";
    }
    return _finalTimeLabel;
}

- (UILabel *)remainingPersonLabel {
    if (_remainingPersonLabel == nil) {
        _remainingPersonLabel = [WMUITool initWithTextColor:TEXTGRAYCOLOR withFont:[UIFont systemFontOfSize:11]];
        _remainingPersonLabel.text = @"剩余1个名额";
    }
    return _remainingPersonLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.selectedBackgroundView = self.selectedAppView;
        
        [self addSubview:self.startTimeLabel];
        [self addSubview:self.finalTimeLabel];
        [self addSubview:self.remainingPersonLabel];
        
        [self.startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mas_top).offset(15);
        }];
        [self.finalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.startTimeLabel.mas_bottom).offset(5);
        }];
        [self.remainingPersonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.finalTimeLabel.mas_bottom).offset(0);
        }];
    }
    
    return self;
}

- (void)receiveCoachTimeInfoModel:(AppointmentCoachTimeInfoModel *)coachTimeInfo {
    self.userInteractionEnabled = NO;
    
    self.startTimeLabel.text = nil;
    self.finalTimeLabel.text = nil;
    self.remainingPersonLabel.text = nil;
    self.startTimeLabel.textColor = [UIColor blackColor];
    self.finalTimeLabel.textColor = [UIColor blackColor];
    self.remainingPersonLabel.textColor = TEXTGRAYCOLOR;
    
    BOOL is_CotainMySelf = NO;
    
    for (NSString *string in coachTimeInfo.courseuser) {
        DYNSLog(@"string = %@",string);
        if ([string isEqualToString:[AccountManager manager].userid]) {
            is_CotainMySelf = YES;
        }
    }
    if (is_CotainMySelf){
        self.startTimeLabel.textColor = [UIColor blackColor];
        self.finalTimeLabel.textColor = [UIColor blackColor];
        self.remainingPersonLabel.textColor = MAINCOLOR;
        
    }
    
    else if (coachTimeInfo.coursestudentcount.intValue - coachTimeInfo.selectedstudentcount.intValue == 0) {
        self.startTimeLabel.textColor = TEXTGRAYCOLOR;
        self.finalTimeLabel.textColor = TEXTGRAYCOLOR;
        self.remainingPersonLabel.textColor = TEXTGRAYCOLOR;
        
        
    }else  {
        self.userInteractionEnabled = YES;
        
    }
    
    self.startTimeLabel.text = [self dealStringWithTime:coachTimeInfo.coursetime.begintime];
    self.finalTimeLabel.text = [self dealStringWithTime:coachTimeInfo.coursetime.endtime];
    if (is_CotainMySelf) {
        self.remainingPersonLabel.text = @"您已经预约";
    }else {
        self.remainingPersonLabel.text = [NSString stringWithFormat:@"剩余%d个名额",coachTimeInfo.coursestudentcount.intValue - coachTimeInfo.selectedstudentcount.intValue];
    }
    
}

- (NSString *)dealStringWithTime:(NSString *)value {
    NSUInteger lenth = value.length;
    NSUInteger lastLenth = lenth-3;
    NSString *resultString = [value substringWithRange:NSMakeRange(0, lastLenth)];
    return resultString;
}

@end
