//
//  BCTextView.m
//  PodTest
//
//  Created by 李超 on 16/1/20.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "BCTextView.h"
#import "ToolHeader.h"

@interface BCTextView()

@end

@implementation BCTextView

- (UILabel *)placeholder{
    if (_placeholder == nil) {
        _placeholder = [[UILabel alloc] init];
        _placeholder.textColor = RGBColor(189, 189, 195);
        _placeholder.font = [UIFont systemFontOfSize:15];
    }
    return _placeholder;
}

- (instancetype)initWithFrame:(CGRect)frame withPlaceholder:(NSString *)placeholder{
    if (self = [super initWithFrame:frame]) {
        self.placeholder.text = placeholder;
        
        [self addSubview:self.placeholder];
        [self.placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(10);
            make.left.mas_equalTo(self.mas_left).offset(10);
        }];
    }
    return self;
}

@end
