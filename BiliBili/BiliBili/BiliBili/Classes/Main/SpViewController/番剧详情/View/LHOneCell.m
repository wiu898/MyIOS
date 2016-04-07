//
//  LHOneCell.m
//  BiliBili
//
//  Created by 李超 on 16/3/31.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHOneCell.h"
#import "LHParam.h"

@implementation LHOneCell

- (void)setArrDict:(NSArray *)arrDict{

    _arrDict = arrDict;
    
    CGFloat marginRL = 20;   //番剧详情--番剧分集按钮-距离左右两边外边距-距离
    
    CGFloat margin = 10;     // 同一行分集按钮内边距
    
    //分集按钮宽度，一行四个按钮
    CGFloat btnW = ([UIScreen mainScreen].bounds.size.width - 3 * margin - 2 * marginRL) / 4;
    
    //arrDict--番剧集数--按钮数量
    //遍历实现按钮
    for (NSInteger i = 0; i < arrDict.count; i++) {
        
         UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(marginRL + (btnW + margin) * (i % 4), 78 + marginRL + (btnW / 2.5 + margin) * (i / 4), btnW, btnW / 2.5)];
        
        btn.backgroundColor = [UIColor whiteColor];
        
        [btn setTitle:[arrDict[i] index] forState:UIControlStateNormal];
        
        btn.layer.cornerRadius = 3;
        
        btn.clipsToBounds = YES;
        
        btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        btn.tag = i;
        
        [btn addTarget:self action:@selector(AVPlayer:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
    }
}

- (void)AVPlayer:(UIButton *)btn{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"playerSpAV" object:self.arrDict[btn.tag]];
}


+(instancetype)cellWithTableV{

    return [[[NSBundle mainBundle] loadNibNamed:@"LHOneCell" owner:nil options:nil] lastObject];
}









































@end
