//
//  LHThreeCell.m
//  BiliBili
//
//  Created by 李超 on 16/3/31.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHThreeCell.h"
#import "LHSpModel.h"
#import "UIButton+WebCache.h"

@implementation LHThreeCell

- (void)setCellM:(LHSpModel *)cellM{

    _cellM = cellM;
    
    CGFloat marginRL = 20;
    
    CGFloat margin = 10;
    
    CGFloat btnW = ([UIScreen mainScreen].bounds.size.width - 3 * margin - 2 * marginRL) / 4;
    
    for (NSInteger i = 0; i < cellM.seasons.count - 1; i++) {
        
        if (cellM.seasons.count == 0) {
            break;
        }
        
        UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(marginRL + (btnW + margin) * (i % 4), 33 - 8 + marginRL + (btnW * 1.8 + margin) * (i / 4), btnW, btnW * 1.5)];
        
        btn.backgroundColor = [UIColor clearColor];
        
        [btn setTitle:[cellM.seasons[i] valueForKey:@"title"] forState:UIControlStateNormal];
        
        [btn sd_setImageWithURL:[NSURL URLWithString:[cellM.seasons[i] valueForKey:@"cover"]] forState:UIControlStateNormal];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:11.0];
        
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, -btnW * 1.8, -10);
        
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self addSubview:btn];
    }
}

+ (instancetype)cellWithTableV{

    return [[[NSBundle mainBundle] loadNibNamed:@"LHThreeCell" owner:nil options:nil] lastObject];
}

@end
