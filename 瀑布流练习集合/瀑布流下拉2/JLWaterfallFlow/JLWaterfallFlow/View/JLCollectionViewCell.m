//
//  JLCollectionViewCell.m
//  JLWaterfallFlow
//
//  Created by 李超 on 16/3/16.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "JLCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "DataModel.h"
#import "Masonry.h"

@interface JLCollectionViewCell()

//@property (strong, nonatomic) UIImageView *handImg;
//
//@property (strong, nonatomic) UIImageView *commentImg;
//
//@property (strong, nonatomic) UIView *backGroundView;

@end

@implementation JLCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

//- (UIView *)backGroundView{
//   
//    if (_backGroundView == nil) {
//        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 163, 172)];
//        _backGroundView.backgroundColor = [UIColor lightGrayColor];
//    }
//    return _backGroundView;
//}
//
//- (UIImageView *)handImg{
//  
//    if (_handImg == nil) {
//        _handImg = [[UIImageView alloc] init];
//        _handImg.image = [UIImage imageNamed:@"community_praise_red_empty"];
//    }
//    return _handImg;
//}
//
//- (UIImageView *)commentImg{
//   
//    if (_commentImg == nil) {
//        _commentImg = [[UIImageView alloc] init];
//        _commentImg.image = [UIImage imageNamed:@"sms_red"];
//    }
//    return _commentImg;
//}
//
//- (UIImageView *)cellImg{
//   
//    if (_cellImg == nil) {
//        _cellImg = [[UIImageView alloc] init];
//    }
//    return _cellImg;
//}
//
//- (UILabel *)priceLa{
//    
//    if (_priceLa == nil) {
//        _priceLa = [[UILabel alloc] init];
//    }
//    return _priceLa;
//}
//
//- (instancetype)initWithFrame:(CGRect)frame{
//
//    if (self = [super initWithFrame:frame]) {
//        [self setUp];
//    }
//    return self;
//}
//

//- (void)setUp{
//    
//    [self.contentView addSubview:self.backGroundView];
//    
//    self.backGroundView.frame = self.contentView.frame;
//    
//    [self.backGroundView addSubview:self.cellImg];
//    
//    [self.cellImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.backGroundView.mas_top).offset(0);
//        make.left.mas_equalTo(self.backGroundView.mas_left).offset(0);
//        make.right.mas_equalTo(self.backGroundView.mas_right).offset(0);
//        make.bottom.mas_equalTo(self.backGroundView.mas_bottom).offset(-25);
//        make.width.mas_equalTo(@163);
//        make.height.mas_equalTo(@142);
//    }];
//    
//    
//    [self.backGroundView addSubview:self.handImg];
//    
//    [self.handImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.cellImg.mas_bottom).offset(5);
//        make.left.mas_equalTo(self.backGroundView.mas_left).offset(10);
//        make.width.mas_equalTo(@13);
//        make.height.mas_equalTo(@16);
//    }];
//    
//    [self.backGroundView addSubview:self.commentImg];
//    
//    [self.commentImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.cellImg.mas_bottom).offset(5);
//        make.left.mas_equalTo(self.handImg.mas_right).offset(10);
//        make.width.mas_equalTo(@15);
//        make.height.mas_equalTo(@16);
//    }];
//    
//    [self.backGroundView addSubview:self.priceLa];
//    
//    [self.priceLa mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.cellImg.mas_bottom).offset(3);
//        make.right.mas_equalTo(self.backGroundView.mas_right).offset(-5);
//        make.width.mas_equalTo(@42);
//        make.height.mas_equalTo(@20);
//    }];
//}


-(void)setCellData:(DataModel *)dataModel
{
    [self.cellImg sd_setImageWithURL:[NSURL URLWithString:dataModel.img]];
    self.priceLa.text = dataModel.price;
}


@end
