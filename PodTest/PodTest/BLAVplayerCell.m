//
//  BLAVplayerCell.m
//  PodTest
//
//  Created by 李超 on 15/12/24.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "BLAVplayerCell.h"
#import "ToolHeader.h"

@interface BLAVplayerCell()

@end

@implementation BLAVplayerCell

- (UIImageView *)backGroundImage{
    if (_backGroundImage == nil) {
        _backGroundImage = [[UIImageView alloc] initWithFrame:
            CGRectMake(0, 0, kSystemWide, 230)];
    }
    return _backGroundImage;
}

- (UIButton *)playButton{
    if (_playButton == nil) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setBackgroundImage:[UIImage imageNamed:@"playImage.png"]
            forState:UIControlStateNormal];
        
        [_playButton addTarget:self action:@selector(clickPlayButton:)
            forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

- (UILabel *)AVdescribe{
    if (_AVdescribe == nil) {
        _AVdescribe = [WMUITool initWithTextColor:[UIColor whiteColor]
            withFont:[UIFont systemFontOfSize:16]];
        _AVdescribe.text = @"倒车入库";
    }
    return _AVdescribe;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:
    (NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    [self.contentView addSubview:self.backGroundImage];
    
    [self.backGroundImage addSubview:self.playButton];
    
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundImage.mas_left).with.offset(15);
        make.bottom.mas_equalTo(self.backGroundImage.mas_bottom).with.offset(-22);
        make.width.mas_equalTo(@22);
        make.height.mas_equalTo(@22);
    }];
    
    [self.backGroundImage addSubview:self.AVdescribe];
    [self.AVdescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.playButton.mas_right).with.offset(10);
        make.top.mas_equalTo(self.playButton.mas_top).with.offset(2);
    }];
}

- (void)clickPlayButton:(UIButton *)sender{
    
}











@end
