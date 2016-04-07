//
//  LHAtScrollView.m
//  BiliBili
//
//  Created by 李超 on 16/4/6.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHAtScrollView.h"
#import "LHDescModel.h"
#import "UIImageView+WebCache.h"

@interface LHAtScrollView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *titelLbl;

@property (weak, nonatomic) IBOutlet UILabel *numLbl;

@end


@implementation LHAtScrollView

- (void)setCellM:(LHDescModel *)cellM{

    _cellM = cellM;
    
    self.titelLbl.text = cellM.title;
    
    self.numLbl.text = cellM.desc1;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:cellM.cover]];
}

+ (instancetype)atScrollViewWith{

    return [[[NSBundle mainBundle] loadNibNamed:@"LHAtScrollView" owner:nil options:nil] lastObject];
}

- (void)layoutSubviews{

    [super layoutSubviews];
}

@end
