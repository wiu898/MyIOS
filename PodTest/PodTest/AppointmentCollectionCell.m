//
//  AppointmentCollectionCell.m
//  PodTest
//
//  Created by 李超 on 16/1/21.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "AppointmentCollectionCell.h"
#import "ToolHeader.h"

@interface AppointmentCollectionCell()

@end

@implementation AppointmentCollectionCell

- (UIImageView *)headImageView{
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] initWithFrame:
            CGRectMake(0, 0, 45, 45)];
        _headImageView.backgroundColor = MAINCOLOR;
        _headImageView.layer.cornerRadius = _headImageView.frame.size.width * 0.5;
    }
    return _headImageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    
    [self addSubview:self.headImageView];
    
}

@end
