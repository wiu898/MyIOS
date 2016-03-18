//
//  DemoCell.m
//  WaterFlowDemo
//
//  Created by 李超 on 16/3/15.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "DemoCell.h"
#import "WaterflowerView.h"
#import "WaterflowerViewCell.h"
#import "UIImageView+WebCache.h"
#import "DemoModel.h"

@interface DemoCell()

@property (nonatomic,weak) UIImageView *imageView;

@property (weak, nonatomic) UILabel *priceLabel;

@end

@implementation DemoCell

+ (instancetype) cellWithWaterflower:(WaterflowerView *)waterflowView{
  
    static NSString *cellID = @"cellID";
    DemoCell *cell = [waterflowView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[DemoCell alloc] init];
        cell.identifier = cellID;
    }
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        
        [self addSubview:imageView];
        
        self.imageView = imageView;
        
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        priceLabel.textAlignment = NSTextAlignmentCenter;
        priceLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:priceLabel];
        
        self.priceLabel = priceLabel;
    }
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    self.priceLabel.frame = CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 20);
}

- (void)setModel:(DemoModel *)model{
    _model = model;
    self.priceLabel.text = model.price;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"loading"]];
}

@end
