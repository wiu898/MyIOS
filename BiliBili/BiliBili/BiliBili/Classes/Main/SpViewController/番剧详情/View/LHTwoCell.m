//
//  LHTwoCell.m
//  BiliBili
//
//  Created by 李超 on 16/3/31.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHTwoCell.h"
#import "LHSpModel.h"

@interface LHTwoCell()

@property (weak, nonatomic) IBOutlet UILabel *descLbl;

@property (strong, nonatomic) UIButton *btn;

@end

@implementation LHTwoCell

- (void)setCellM:(LHSpModel *)cellM{

    _cellM = cellM;
    
    self.descLbl.text = cellM.evaluate;
    
    //介绍Label高度
    CGFloat lblH = [self.cellM.evaluate boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20 - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:12.0] } context:nil].size.height + 16 + 17 + 16;
    
    CGFloat marginRL = 20;
    CGFloat margin = 10;
    
    //介绍底部标签按钮的宽度
    CGFloat btnW = ([UIScreen mainScreen].bounds.size.width - 3 * margin - 2 * marginRL) / 4;
    
    NSInteger num = 1;
    
    for (NSInteger i = 0; i < cellM.tags.count; i++) {
        
        UIButton *btn = [[UIButton alloc] init];
        
        btn.backgroundColor = [UIColor whiteColor];
        
        [btn setTitle:[cellM.tags[i] valueForKey:@"tag_name"] forState:UIControlStateNormal];
        
        if ((marginRL + CGRectGetMaxX(self.btn.frame)) > [UIScreen mainScreen].bounds.size.width * 2 / 3) {
            
            btn.frame = CGRectMake(marginRL, marginRL + lblH + (self.btn.bounds.size.height + marginRL) * num, btnW, btnW / 2.5);
            
            num++;
        }
        else {
            
            btn.frame = CGRectMake(marginRL + CGRectGetMaxX(self.btn.frame), marginRL + lblH + (self.btn.bounds.size.height + marginRL) * (num - 1), btnW, btnW / 2.5);
        }
        
        [btn sizeToFit];
        
        if (CGRectGetMaxX(btn.frame) > ([UIScreen mainScreen].bounds.size.width - 20)) {
            
            btn.frame = CGRectMake(marginRL, marginRL + lblH + (self.btn.bounds.size.height + marginRL) * num, btnW, btnW / 2.5);
            [btn sizeToFit];
            
            num++;
        }
        
        btn.layer.cornerRadius = 3;
        
        btn.clipsToBounds = YES;
        
        btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [self addSubview:btn];
        
        self.btn = btn;
        
    }
    
}

+ (instancetype)cellWithTableV{

    return [[[NSBundle mainBundle] loadNibNamed:@"LHTwoCell" owner:nil options:nil] lastObject];
}

@end
