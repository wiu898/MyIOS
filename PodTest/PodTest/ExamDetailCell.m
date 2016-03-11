//
//  ExamDetailCell.m
//  PodTest
//
//  Created by 李超 on 16/1/14.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "ExamDetailCell.h"
#import "ToolHeader.h"
#import "VipserverModel.h"
#import "UIColor+Hex.h"

@interface ExamDetailCell()

@property (strong, nonatomic) UIView *backGroundView;

@end

@implementation ExamDetailCell

- (UILabel *)schoolLabel{
    if (_schoolLabel == nil) {
        _schoolLabel = [WMUITool initWithTextColor:[UIColor blackColor]
            withFont:[UIFont systemFontOfSize:14]];
        _schoolLabel.text = @"驾校信息";
    }
    return _schoolLabel;
}

- (UILabel *)schoolClassLabel{
    if (_schoolClassLabel == nil) {
        _schoolClassLabel = [WMUITool initWithTextColor:[UIColor blackColor]
            withFont:[UIFont systemFontOfSize:14]];
        _schoolClassLabel.text = @"适用驾照类型";
    }
    return _schoolClassLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [WMUITool initWithTextColor:[UIColor blackColor]
            withFont:[UIFont systemFontOfSize:14]];
        _timeLabel.text = @"活动日期";
    }
    return _timeLabel;
}

- (UILabel *)studyLabel{
    if (_studyLabel == nil) {
        _studyLabel = [WMUITool initWithTextColor:[UIColor blackColor]
            withFont:[UIFont systemFontOfSize:14]];
        _studyLabel.text = @"授课日程";
    }
    return _studyLabel;
}

- (UILabel *)featuredTutorials{
    if (_featuredTutorials == nil) {
        _featuredTutorials = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _featuredTutorials.text = @"课程特色:";
    }
    return _featuredTutorials;
}

- (UILabel *)carType {
    if (_carType == nil) {
        _carType = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _carType.text = @"训练车品牌:";
    }
    return _carType;
}

- (UILabel *)price {
    if (_price == nil) {
        _price = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _price.text = @"价格:";
    }
    return _price;
}

- (UILabel *)personCount {
    if (_personCount == nil) {
        _personCount = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _personCount.text = @"已报名人数:";
    }
    return _personCount;
}

- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 300)];
    }
    return _backGroundView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    
    [self.contentView addSubview:self.backGroundView];
    
    self.backGroundView.userInteractionEnabled = YES;
    
    [self.backGroundView addSubview:self.schoolLabel];
    [self.backGroundView addSubview:self.schoolClassLabel];
    [self.backGroundView addSubview:self.timeLabel];
    [self.backGroundView addSubview:self.studyLabel];
    [self.backGroundView addSubview:self.featuredTutorials];
    [self.backGroundView addSubview:self.carType];
    [self.backGroundView addSubview:self.price];
    [self.backGroundView addSubview:self.personCount];
    
    [self.schoolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(18);
    }];
    [self.schoolClassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.schoolLabel.mas_bottom).offset(12);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.schoolClassLabel.mas_bottom).offset(12);
    }];
    [self.studyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(12);
    }];
    [self.featuredTutorials mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.studyLabel.mas_bottom).offset(12);
    }];
    [self.carType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.featuredTutorials.mas_bottom).offset(50);
    }];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.carType.mas_bottom).offset(12);
    }];
    [self.personCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.price.mas_bottom).offset(12);
    }];

}

- (void)receiveVipList:(NSArray *)list{
    for (NSInteger i = 0; i<list.count; i++) {
        NSInteger row = i/4;
        VipserverModel *model = list[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(65+(((kSystemWide-60-40)/4)+5)*i, -5+row*(30),
            (kSystemWide-60-40)/4, 25);
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        button.layer.cornerRadius = 5;
        button.layer.borderColor = [UIColor colorWithHexString:model.color].CGColor;
        button.layer.borderWidth = 1;
        [button setTitleColor:[UIColor colorWithHexString:model.color] forState:UIControlStateNormal];
        [button setTitle:model.name forState:UIControlStateNormal];
        [self.featuredTutorials addSubview:button];
    }
}

@end
