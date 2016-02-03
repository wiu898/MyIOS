//
//  TextAndImageCell.m
//  ImageText图文
//
//  Created by 李超 on 16/2/2.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "TextAndImageCell.h"
#import "TextAndImageModel.h"
#import "PrefixHeader.h"
#import "FromValidator.h"

@interface TextAndImageCell()

@property (nonatomic,strong) UIImageView *headImgV;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *contentLabel;

@end

@implementation TextAndImageCell

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel addLabelWithFrame:
            CGRectMake(65*Width, 15*Height, 100*Width, 15*Height)
            AndText:nil AndFont:14 AndAplha:1
            AndColor:[UIColor blackColor]];
    }
    return _nameLabel;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [UILabel addLabelWithFrame:
            CGRectMake(10*Width, 65*Height, 300*Width, 20*Height)
            AndText:nil AndFont:12 AndAplha:1
            AndColor:[UIColor blackColor]];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UIImageView *)headImgV{
    if (_headImgV == nil) {
        _headImgV = [[UIImageView alloc] initWithFrame:
          CGRectMake(10*Width, 10*Height, 50*Width, 50*Height)];
        _headImgV.layer.cornerRadius = 25*Width;
        _headImgV.layer.masksToBounds = YES;
      //  _headImgV.backgroundColor = [UIColor redColor];
    }
    return _headImgV;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    [self.contentView addSubview:self.headImgV];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.contentLabel];
}

- (void)setModel:(TextAndImageModel *)model{
    NSLog(@"进入ModelSet");
    if (_model != model) {
        _model = model;
    }
    _headImgV.image =[UIImage imageNamed:model.imgStr];
    _nameLabel.text = model.name;
   
    //自适应高度计算
    CGRect rect =[FromValidator rectWidthAndHeightWithStr:model.content
        AndFont:12 WithStrWidth:300];
    
    _contentLabel.frame =CGRectMake(10*Width, 65*Width, 300*Width, rect.size.height);
    _contentLabel.text = model.content;

}

@end
