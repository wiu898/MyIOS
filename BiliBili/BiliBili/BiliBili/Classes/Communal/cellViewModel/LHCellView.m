//
//  LHCellView.m
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHCellView.h"
#import "LHCellModel.h"
#import "UIImageView+WebCache.h"

@interface LHCellView()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleView;

@end

@implementation LHCellView

//点击跳转到下一页面
- (IBAction)pushNextVC:(UIButton *)sender{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushController" object:self.cellM];
}

- (void)setCellM:(LHCellModel *)cellM{

    _cellM = cellM;
    
    self.titleView.text = cellM.title;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:cellM.small_cover]];
}

+ (instancetype)viewWithNib{

    return [[[NSBundle mainBundle] loadNibNamed:@"LHCellView" owner:nil options:nil] lastObject];
}

@end
